// lib/services/firebase_messaging_service.dart

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helping_hand/services/firestore.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  late final String uid;

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
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        // iOS settings can be added later
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
            icon: '@mipmap/launcher_icon',
          ),
        ),
      );
    }
  }

  void _handleNotificationOpen(RemoteMessage message) {
    // Handle notification tap
    print('Notification tapped!');
    // Add navigation logic here
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

