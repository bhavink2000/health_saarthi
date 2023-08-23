import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationNewService{
  String? fcmToken;
  late AndroidNotificationChannel channel;
  bool isFlutterLocalNotificationsInitialized = false;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();//initialize Firebase if not initialize when opend from background
    await setupFlutterNotifications();// initialize Local Notification services
    RemoteNotification? notification = message.notification;

    AndroidNotification? android = message.notification?.android;  // IOS will show notification normaly for android need to do it manualy
    if (notification != null && android != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        flutterLocalNotificationsPlugin.cancelAll();
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description, largeIcon: DrawableResourceAndroidBitmap("ic_launcher")
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
              ),
            ),
            payload: jsonEncode(message.data).replaceAll("/", "")); // handel infromation from noticication
      });
    }
    print('Handling a background message ${jsonEncode(message.data)}');
  }

  Future<void> setupFlutterNotifications() async {// Local Notification setup
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

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(onDidReceiveLocalNotification: (i, a, b, c) {});
    final LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin, linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? payload) async {
        handelAndroidNotification(payload!.payload!);
      },
    );

    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((value) {
      if (value!.didNotificationLaunchApp) {
        if (value.notificationResponse != null) {
          handelAndroidNotification(value.notificationResponse!.payload!);
          flutterLocalNotificationsPlugin.cancel(value.notificationResponse!.id!);
        }
      }
    });

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    isFlutterLocalNotificationsInitialized = true;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {   // handle forground notifications
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        showFlutterNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      onNotificationTap(event);// onClick Events
    });
  }

  handelAndroidNotification(String payload) {
    Future.delayed(Duration(seconds: 2), () {
      print("-------------------------------------");
      print(payload);
      print("-------------------------------------");

    });
  }

  void onNotificationTap(event) {
    // onClick handel Events
  }

  void showFlutterNotification(RemoteMessage message) { // display android notification code
    if (Platform.isAndroid) {
      RemoteNotification? notification = message.notification;

      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        Future.delayed(Duration(milliseconds: 300), () {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,

              //notification.title,
              //notification.body,
              message.data!['title'],
              message.data!['message'],

              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id, channel.name,
                  channelDescription: channel.description,
                  largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                ),
              ),
              payload: jsonEncode(message.data).replaceAll("/", ""));
        });
      }
      print('Handling a background message ${jsonEncode(message.data)}');
    }
  }

}