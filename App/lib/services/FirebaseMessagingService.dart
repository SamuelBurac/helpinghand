// lib/services/firebase_messaging_service.dart

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:helping_hand/Chats_screens/chat_screen.dart';


class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  late final String uid;
  bool hasToken = false;

  // Initialize notification channels for Android
  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  Future<void> initialize(String uid) async {

    this.uid = uid;
    // Request permission (will be used later for iOS)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      provisional: true,
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications
    await _localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@drawable/notification_icon'),
        // iOS settings can be added later
        iOS: DarwinInitializationSettings(),
      ),
    );

    // Create the Android notification channel
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);


    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });

    // Handle notification open events
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationOpen(message);
    });

    // Get the token
    String? token = await _firebaseMessaging.getToken();
    // print('FCM Token: $token'); // Save this token to your backend
    if (token != null) {
      hasToken = true;
      await FirestoreService().addFCMToken(this.uid, token);
    }

    // Listen for token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      // print('FCM Token refreshed: $token'); // Save this token to your backend

      await FirestoreService().addFCMToken(this.uid, newToken);
    }).onError((err) {
      // Error getting token.
      print('Error getting FCM token: $err');
    });
  }

  Future<void> removeToken() async {
    if (!hasToken) {
      return;
    }
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      await FirestoreService().removeFCMToken(uid, token);
    }
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: '@drawable/notification_icon',
            color: Colors.orange,
            largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
          ),
        ),
      );
    }
  }

  void _handleNotificationOpen(RemoteMessage message) async{
    // Handle notification tap
    print('Notification tapped!');
    print(message.data);
    // if (message.data['type'] == 'chat') {
    //   // Handle chat notification
    //   // Add navigation logic here
    //   Chat chat = await FirestoreService().getChatByID(message.data['chatID']);
    //   User? interlocutor = await FirestoreService().getUser(message.data['senderUID']);
    //   if (interlocutor != null) {
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (context) => ChatScr(
    //           chat: chat,
    //           interlocutor: interlocutor,
    //         ),
    //       ),
    //     );
    //   }
    // }
    // Add navigation logic here
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

