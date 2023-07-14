//@dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Providers/Home%20Menu%20Provider/home_menu_provider.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Providers/Location%20Provider/location_provider.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Blocs/Internet%20Bloc/internet_bloc.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Blocs/Location%20Bloc/location_bloc.dart';
import 'package:provider/provider.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Providers/Authentication Provider/authentication_provider.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import 'Heath Saarthi/App Helper/Backend Helper/Providers/File Set Provider/file_set_provider.dart';
import 'Heath Saarthi/App Helper/Blocs/Location Bloc/location_repo.dart';
import 'Heath Saarthi/Authentication Screens/Splash Screen/splash_screen.dart';
import 'dart:ui' as ui;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
}


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print(message.notification.title.toString());
}


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = ui.window.physicalSize.width / ui.window.devicePixelRatio;
    double screenHeight = ui.window.physicalSize.height / ui.window.devicePixelRatio;

    print("Screen Width-> $screenWidth");
    print("Screen Height-> $screenHeight");
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
        ChangeNotifierProvider(create: (_)=> FileState()),
      ],
      child: ScreenUtilInit(
        //designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<InternetBloc>(create: (BuildContext context) => InternetBloc()),
              BlocProvider<LocationBloc>(create: (BuildContext context) => LocationBloc(LocationRepo())),
            ],
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}

//WZ-Application-Team's Mac mini