import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../DashBoard/Notification Menu/notification_menu.dart';

class NotificationService{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void requestNotificationPermission()async{
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("User Granted Permission");
    }
    else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print("User Granted Provisional Permission");
    }
    else{
      print("User denied Permission");
    }
  }

  Future<String> getDeviceToken()async{
    String? token = await messaging.getToken();
    return token!;
  }

  void initLocalNotification(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      },
    );
  }
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {

      print("---------------------------------------");
      print("message data->${message.data}");
      print("message notification->${message.notification}");


      print("notification title->${message.data['title']}");
      print("notification message->${message.data['message']}");

      print("---------------------------------------");
      initLocalNotification(context, message);
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message)async{
    print("showNotification message data->${message.data}");
    print("showNotification message noti->${message.notification}");
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notification',
        importance: Importance.max
    );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
        icon: "@mipmap/ic_launcher",
        channelDescription: 'your channel description',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker'
    );
    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails
    );
    Future.delayed(Duration.zero,(){
      _flutterLocalNotificationsPlugin.show(
          0,
          //message.notification!.title.toString(),
          //message.notification!.body.toString(),
          message.data!['title'],
          message.data!['message'],
          notificationDetails
      );
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    print("calling handleMessage");
    if(message.data['title'] != null){
      print("in if");
      print("No data");
    }
    else{
      print("in else");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationMenu()),
      );
    }
    print("called handleMessage");
  }
}