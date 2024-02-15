import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Api Service/notification_service.dart';

class NotificationHandler{

  late AndroidNotificationChannel channel;
  bool isFlutterLocalNotificationsInitialized = false;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  
  void notificationCall()async{
    await Firebase.initializeApp();
    await Future.delayed(const Duration(seconds: 1));
    if (Platform.isAndroid ||Platform.isIOS) {
      FirebaseMessaging.instance.getToken().then((value) async {
        FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
        await setupFlutterNotifications();
      });
    }
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        firebaseMessagingBackgroundHandler(value);
      }
    });
    FirebaseMessaging.instance.getInitialMessage().then((value) => value != null ? firebaseMessagingBackgroundHandler : false);
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    await setupFlutterNotifications();

    Future.delayed(const Duration(milliseconds: 300), () {
      flutterLocalNotificationsPlugin.cancelAll();
      flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.data['title'],
        message.data['message'],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            largeIcon: const DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data).replaceAll("/", ""),
      );
    });
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(onDidReceiveLocalNotification: (i, a, b, c) {});
    const LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin, linux: initializationSettingsLinux);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Parse the payload string to a map
        Map<String, dynamic> payloadMap = json.decode(response.payload!);
        handleAndroidNotification(payloadMap);
      },
    );

    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((value) {
      if (value!.didNotificationLaunchApp) {
        if (value.notificationResponse != null) {
          // Parse the payload string to a map
          Map<String, dynamic> payloadMap = json.decode(value.notificationResponse!.payload!);
          handleAndroidNotification(payloadMap);
          flutterLocalNotificationsPlugin.cancel(value.notificationResponse!.id!);
        }
      }
    });
    
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    isFlutterLocalNotificationsInitialized = true;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data != null) {
        showFlutterNotification(message);
      } else if (message.data.isNotEmpty) {
        handleAndroidNotification(message.data);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      LocalNotificationService.displayNotification(event);
    });

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    String? token = await FirebaseMessaging.instance.getToken();
    print("Firebase Messaging Token: $token");
  }

  void showFlutterNotification(RemoteMessage message) {
    if (Platform.isAndroid || Platform.isIOS) {
      Future.delayed(const Duration(milliseconds: 300), () {
        flutterLocalNotificationsPlugin.show(
          message.hashCode,
          message.data['title'],
          message.data['message'],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              largeIcon: const DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: jsonEncode(message.data).replaceAll("/", ""),
        );
      });

      if (Platform.isIOS) {
        print('Handling a background message ${jsonEncode(message.data)}');
      }
    }
  }
  void handleAndroidNotification(Map<String, dynamic> payload) {
    String title = payload['notification']['title'] ?? 'Default Title';
    String body = payload['notification']['body'] ?? 'Default Body';
    print('Notification Title: $title');
    print('Notification Body: $body');
    Future.delayed(const Duration(seconds: 1), () {
    });
  }
}