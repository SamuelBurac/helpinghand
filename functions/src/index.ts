/* eslint-disable max-len */
/* eslint-disable require-jsdoc */
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as express from "express";
import * as cors from "cors";
import {getMessaging} from "firebase-admin/messaging"

// Initialize Firebase Admin
admin.initializeApp({
  credential: admin.credential.applicationDefault(),
});



interface NotificationPayload {
  recipientUid: string;
  messageText: string;
  senderName: string;
  chatID: string;
  senderUID: string;
}

interface FirebaseAuthRequest extends express.Request {
  user?: admin.auth.DecodedIdToken;
}

interface FCMResponse {
  success: boolean;
  successCount: number;
  failureCount: number;
  error?: string;
}

const app = express();
app.use(cors({origin: true}));

// Middleware to verify Firebase Auth token
const authenticateRequest = async (
  req: FirebaseAuthRequest,
  res: express.Response,
  next: express.NextFunction
): Promise<express.Response | void> => {
  if (!req.headers.authorization?.startsWith("Bearer ")) {
    return res.status(403).json({error: "Unauthorized"});
  }

  const idToken = req.headers.authorization.split("Bearer ")[1];
  try {
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    req.user = decodedToken;
    next();
  } catch (error) {
    return res.status(403).json({error: "Invalid token"});
  }
};

// Get user's FCM tokens from Firestore
async function getUserFCMTokens(uid: string): Promise<string[]> {
  try {
    const userDoc = await admin.firestore().collection("users").doc(uid).get();
    const userData = userDoc.data();
    return userData?.fcmTokens || [];
  } catch (error) {
    console.error("Error getting user FCM tokens:", error);
    return [];
  }
}

// Remove invalid FCM tokens
async function removeInvalidTokens(uid: string, invalidTokens: string[]): Promise<void> {
  try {
    await admin.firestore().collection("users").doc(uid).update({
      fcmTokens: admin.firestore.FieldValue.arrayRemove(...invalidTokens),
    });
  } catch (error) {
    console.error("Error removing invalid tokens:", error);
  }
}

// Endpoint to send chat notification
app.post("/send-chat-notification",
  authenticateRequest,
  async (req: FirebaseAuthRequest, res: express.Response<FCMResponse>
  ): Promise<express.Response<FCMResponse>> => {
    try {
      const {recipientUid, messageText, senderName, chatID, senderUID} = req.body as NotificationPayload;

      if (!recipientUid || !messageText || !senderName) {
        return res.status(400).json({
          success: false,
          successCount: 0,
          failureCount: 1,
          error: "Missing required fields",
        });
      }

      const tokens = await getUserFCMTokens(recipientUid);

      if (tokens.length === 0) {
        return res.status(404).json({
          success: false,
          successCount: 0,
          failureCount: 1,
          error: "No FCM tokens found for user",
        });
      }

      const message: admin.messaging.MulticastMessage = {
        notification: {
          title: `New message from ${senderName}`,
          body: messageText,
        },
        data: {
          type: "chat",
          senderName: senderName,
          interlocutorUid: senderUID || "",
          messagePreview: messageText.substring(0, 100),
          chatID: chatID || "",
          timestamp: Date.now().toString(),
        },
        android: {
          notification: {
            channelId: "high_importance_channel",
            priority: "high",
            icon: "@mipmap/ic_launcher",
            sound: "default",
          },
        },
        apns: {
          payload: {
            aps: {
              sound: "default",
              badge: 1,
            },
          },
        },
        tokens: tokens,
      };


      const response = await getMessaging().sendEachForMulticast(message);
      console.log("Notification sent:", response);

      // Handle failed tokens
      if (response.failureCount > 0) {
        const failedTokens: string[] = [];
        response.responses.forEach((resp, idx) => {
          if (!resp.success) {
            failedTokens.push(tokens[idx]);
          }
        });

        if (failedTokens.length > 0) {
          await removeInvalidTokens(recipientUid, failedTokens);
        }
      }

      return res.json({
        success: true,
        successCount: response.successCount,
        failureCount: response.failureCount,
      });
    } catch (error) {
      console.error("Error sending notification:", error);
      return res.status(500).json({
        success: false,
        successCount: 0,
        failureCount: 1,
        error: "Failed to send notification",
      });
    }
  });

// Export the Express app as a Firebase Cloud Function
export const api = functions.https.onRequest(app);


