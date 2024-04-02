import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Providers/Home%20Menu%20Provider/home_menu_provider.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/push_notification_helper.dart';
import 'package:provider/provider.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Api Future/Profile Future/profile_future.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Api Service/notification_service.dart';
import 'Heath Saarthi/Authentication Screens/Splash Screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
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

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{

  final box = GetStorage();

  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance!.addObserver(this);
    notificationService.requestNotificationPermission();
    NotificationHandler().notificationCall();
  }

  @override
  void dispose() {
   // WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }


  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   //getAccessToken.checkAuthentication(context, setState);
  //   if (state == AppLifecycleState.resumed) {
  //     log('----- >>>>> come to foreground <<<<< -----');
  //     Future.delayed(Duration(seconds: 2), () {
  //       callingForeground();
  //     });
  //     setState(() {});
  //   }
  //   else if(state == AppLifecycleState.paused){
  //     log('----- >>>>> go to background <<<<< -----');
  //     Future.delayed(Duration(seconds: 2), () {
  //       callingBackground();
  //     });
  //     setState(() {});
  //   }
  // }
  //
  // void callingForeground()async{
  //   try{
  //     //notificationCall();
  //     var userStatus = await ProfileFuture().fetchProfile();
  //     setState(() {
  //       box.write('userStatus', userStatus.data!.status);
  //     });
  //     await homeMenusProvider.fetchTodayDeal(1);
  //   }
  //   catch(e){
  //     log("----- >>>>> foreground catch e -> $e");
  //   }
  // }
  //
  // void callingBackground()async{
  //   try{
  //     //notificationCall();
  //     var userStatus = await ProfileFuture().fetchProfile();
  //     setState(() {
  //       box.write('userStatus', userStatus.data!.status);
  //     });
  //     await homeMenusProvider.fetchTest(1,  '');
  //     await homeMenusProvider.fetchPackage(1, '');
  //   }
  //   catch(e){
  //     log("----- >>>>> background catch e -> $e");
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
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
              scrollbarTheme: ScrollbarThemeData(thumbVisibility: MaterialStateProperty.all<bool>(true),),
            ),
          );
        },
      ),
    );
  }
}

