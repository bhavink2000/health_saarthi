//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Providers/Home%20Menu%20Provider/home_menu_provider.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Providers/Location%20Provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Api Service/notification_service.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Api Urls/api_urls.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Device Info/device_info.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Network Check/network_binding.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Providers/Authentication Provider/authentication_provider.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import 'Heath Saarthi/Authentication Screens/Splash Screen/splash_screen.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  DependencyInjection.init();
  runApp(const MyApp());
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
}


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print(message.notification.title.toString());
  print(message.data['title']);
  print(message.data['message']);
}


class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String fcmToken;
  AndroidNotificationChannel channel;
  bool isFlutterLocalNotificationsInitialized = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationCall();
  }

  void notificationCall()async{
    FirebaseApp app = await Firebase.initializeApp(); //initialize Firebase first
    FirebaseMessaging.instance.getToken().then((value) async { // getFcm Token
      setState(() {
        fcmToken = value;
      });
      print("firebase Token : ${fcmToken}");
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler); //  background/killed app notification handler
      await setupFlutterNotifications();// initialize Local Notification services
    });
    FirebaseMessaging.instance.getInitialMessage().then((event) async {//  handel click event of background notification
      print("firebase getInitialMessage : ${event}");
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("in firebaseBackgroundHandleer ->${message.data}");
    await Firebase.initializeApp();//initialize Firebase if not initialize when opend from background
    await setupFlutterNotifications();// initialize Local Notification services
    RemoteNotification notification = message.notification;

    AndroidNotification android = message.notification?.android;  // IOS will show notification normaly for android need to do it manualy
    if (message.data != null) {
      print("in if done");
      print("title->${message.data['title']}\nmessage->${message.data['message']}");
      Future.delayed(Duration(milliseconds: 300), () {
        print("in delayed");
        flutterLocalNotificationsPlugin.cancelAll();
        flutterLocalNotificationsPlugin.show(
            message.hashCode,
            //notification.title,
            //notification.body,
            message.data['title'],
            message.data['message'],
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id, channel.name,
                  channelDescription: channel.description,
                  largeIcon: DrawableResourceAndroidBitmap("ic_launcher")
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
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(onDidReceiveLocalNotification: (i, a, b, c) {});
    final LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin, linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse payload) async {
        handelAndroidNotification(payload.payload);
      },
    );

    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((value) {
      if (value.didNotificationLaunchApp) {
        if (value.notificationResponse != null) {
          handelAndroidNotification(value.notificationResponse.payload);
          flutterLocalNotificationsPlugin.cancel(value.notificationResponse.id);
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

      if (message.data != null) {
        print('Message also contained a notification: ${message.data}');
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
      RemoteNotification notification = message.notification;

      AndroidNotification android = message.notification?.android;
      if (message.data != null) {
        Future.delayed(Duration(milliseconds: 300), () {
          flutterLocalNotificationsPlugin.show(
              message.hashCode,
              //notification.title,
              //notification.body,
              message.data['title'],
              message.data['message'],

              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id, channel.name,
                  channelDescription: channel.description,
                  largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
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

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthProvider()),
        ChangeNotifierProvider(create: (_)=> UserDataSession()),
        ChangeNotifierProvider(create: (_)=> LocationProvider()),
        ChangeNotifierProvider(create: (_)=> HomeMenusProvider()),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}

