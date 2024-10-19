import 'dart:convert';
import 'package:helping_hand/services/auth.dart';
import 'package:http/http.dart' as http;

String localTestUrl = 'http://127.0.0.1:5001/helping-hand-9002c/us-central1/api/send-chat-notification';
String prodUrl = 'https://api-ly3obdkoua-uc.a.run.app/send-chat-notification';

Future<void> sendChatNotification(String recipientUid, String message, String senderName, String chatID) async {
  final idToken = await AuthService().user?.getIdToken();
  
  
  final response = await http.post(
    Uri.parse(prodUrl),
    headers: {
      'Authorization': 'Bearer $idToken',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'recipientUid': recipientUid,
      'messageText': message,
      'senderName': senderName, // Get from your user profile
      'chatID': chatID, // Optional
      'senderUID': AuthService().user?.uid,
    }),
  );

  print(response.statusCode);
  print(response.body);
  

  if (response.statusCode != 200) {
    throw Exception('Failed to send notification');
  }
}