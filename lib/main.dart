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
import 'package:provider/provider.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Api Service/notification_service.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Network Check/network_binding.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Providers/Authentication Provider/authentication_provider.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import 'Heath Saarthi/Authentication Screens/Splash Screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  DependencyInjection.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  LocalNotificationService.displayNotification(message);
  await Firebase.initializeApp();
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String? fcmToken;
  late AndroidNotificationChannel channel;
  bool isFlutterLocalNotificationsInitialized = false;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationCall();
  }

  void notificationCall()async{
   await Firebase.initializeApp();
    FirebaseMessaging.instance.getToken().then((value) async {
      setState(() {
        fcmToken = value;
      });
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      await setupFlutterNotifications();
    });
   FirebaseMessaging.instance
       .getInitialMessage()
       .then((value) => value != null ? firebaseMessagingBackgroundHandler : false);
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
                channel.id, channel.name,
                channelDescription: channel.description,
                largeIcon: const DrawableResourceAndroidBitmap("ic_launcher")
            ),
          ),
          payload: jsonEncode(message.data).replaceAll("/", ""));
    });
      print('Handling a background message ${jsonEncode(message.data)}');
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
      onDidReceiveNotificationResponse: (NotificationResponse payload) async {
        handelAndroidNotification(payload.payload!);
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
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    isFlutterLocalNotificationsInitialized = true;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showFlutterNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      LocalNotificationService.displayNotification(event);
      //onNotificationTap(event);// onClick Events
    });
  }

  handelAndroidNotification(String payload) {
    Future.delayed(const Duration(seconds: 1), () {

    });
  }

  void onNotificationTap(event) {
    // onClick handel Events
  }

  void showFlutterNotification(RemoteMessage message) {
    if (Platform.isAndroid) {
      Future.delayed(const Duration(milliseconds: 300), () {
        flutterLocalNotificationsPlugin.show(
            message.hashCode,
            message.data['title'],
            message.data['message'],
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id, channel.name,
                channelDescription: channel.description,
                largeIcon: const DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
              ),
            ),
            payload: jsonEncode(message.data).replaceAll("/", ""));
      });
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
        ChangeNotifierProvider(create: (_)=> HomeMenusProvider()),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            //navigatorKey: GlobalKey<NavigatorState>(),
            home: const SplashScreen(),
            theme: ThemeData(
              scrollbarTheme: ScrollbarThemeData(
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              )
            ),
          );
        },
      ),
    );
  }
}

