import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<void> requestNotificationPermission() async {
    try {
      NotificationSettings settings = await messaging.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: true,
          criticalAlert: true,
          provisional: true,
          sound: true
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        String? deviceToken = await getDeviceToken();
      } else {
        requestNotificationPermission();
        print('User declined notification permission');
      }
    } catch (e) {
      print('Error initializing app: $e');
    }
  }

  Future<String?> getDeviceToken() async {
    try {
      if (Platform.isAndroid) {
        String? token = await messaging.getToken();
        print('Android token->$token');
        return token!;
      } else {
        String? token = await messaging.getToken();
        print('IOS token->$token');
        return token;
      }
    } catch (e) {
      print('Error getting device token: $e');
      return null;
    }
  }

}

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    _notificationsPlugin.initialize(
      initializationSettings,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      displayNotification(message);
    });
  }

  static void displayNotification(RemoteMessage message) async {
    try {
      final id = Random().nextInt(20000);
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "high_importance_channel",
            "High Importance Notifications",
            priority: Priority.high
        ),
      );
      await _notificationsPlugin.show(
        id,
        message.data['title'],
        message.data['message'],
        notificationDetails,
        payload: message.data['_id'],
      );
    } catch (e) {
      log('e -> $e' as num);
    }
  }

  static void handleNotificationSelection(String? payload) {
    // Handle the action when the user selects the notification.
    if (payload != null) {
      print("Notification selected with payload: $payload");
      // You can navigate to a specific screen or perform an action based on the payload.
    }
  }
}