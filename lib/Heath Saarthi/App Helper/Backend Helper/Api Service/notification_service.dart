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
    var iosInitializationSettings = const IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        handleMessage(context, message);
        return Future.value(null); // Add this line to return a Future
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

  // void firebaseInit(BuildContext context) {
  //   FirebaseMessaging.onMessage.listen((message) {
  //     print("---------------------------------------");
  //     print("message data->${message.data}");
  //     print("message notification->${message.notification}");
  //
  //     if (message.data != null) {
  //       print("*-*----*--*-***-*-*----*-*-*--*-*-*-*-*-----");
  //       print("notification title->${message.data['title']}");
  //       print("notification message->${message.data['message']}");
  //     } else {
  //       print("-=-=-=-=-=-=-=-==-=-=-=-=-=-==--=-");
  //       print("Notification data is null.");
  //     }
  //
  //     print("---------------------------------------");
  //     initLocalNotification(context, message);
  //     showNotification(message);
  //   });
  // }

  /*Future<void> showNotification(RemoteMessage message)async{
    print("showNotification message data->${message.data}");
    print("showNotification message noti->${message.notification}");
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'High Importance Notification',
      'Your channel description here',
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      'Your channel description here',
      icon: "@mipmap/ic_launcher",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    IOSNotificationDetails darwinNotificationDetails = const IOSNotificationDetails(
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
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          //message.data['title'],
          //message.data['message'],
          notificationDetails
      );
    });
  }*/

  Future<void> showNotification(RemoteMessage message) async {
    var androidNotificationDetails = AndroidNotificationDetails(
      'channel_id', // Replace with your channel ID
      'channel_name', // Replace with your channel name
      'channel_description', // Replace with your channel description
      importance: Importance.high,
      priority: Priority.high,
    );

    var iosNotificationDetails = IOSNotificationDetails();

    var notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
      payload: 'item x',
    );
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
