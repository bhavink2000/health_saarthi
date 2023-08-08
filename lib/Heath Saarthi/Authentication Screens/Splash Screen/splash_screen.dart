//@dart=2.9
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Blocs/Internet%20Bloc/internet_bloc.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Blocs/Internet%20Bloc/internet_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../App Helper/Backend Helper/Api Service/notification_service.dart';
import '../../App Helper/Backend Helper/Models/Authentication Models/login_model.dart';
import '../../App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../DashBoard/hs_dashboard.dart';
import '../Login Screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool internetCheck = false;

  Future<LoginModel> getUserData() => UserDataSession().getUserData();
  NotificationService notificationService = NotificationService();

  String deviceType;
  String deviceVersion;
  String deviceToken;

  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.firebaseInit(context);
    notificationService.getDeviceToken().then((value) {
      if (value == '' || value == null) {
        print("Do Not Get Device Token");
      } else {
        setState(() {
          deviceToken = value;
        });
        storeDeviceToken(value).then((_) {
          retrieveDeviceDetails().then((value) {
            print("retrive Device token value->>>>$value");
            if (deviceToken == '' ||
                value == '' ||
                deviceToken == null ||
                value == null) {
              print("Do not get device token\nplease restart the app");
            } else {
              print("check Device Token->$deviceToken");
              print("check Device type->$deviceType");
              checkAuthentication(context);
            }
          });
        });
      }
    });
  }
  Future<void> storeDeviceToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceToken', token);
  }
  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      print("checkAuth Access Token => ${value.accessToken}");
      print("checkAuth UserStatus => ${value.userStatus}");
      if (value.accessToken == "null") {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen(deviceToken: deviceToken,deviceType: deviceType)),
        );
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(deviceToken: deviceToken)),
        );
      }
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  Future retrieveDeviceDetails() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      print('Android Release Version ->$release \n(SDK Version$sdkInt), \n$manufacturer \n$model');
      setState(() {
        deviceType = 'Android';
        deviceVersion = androidInfo.version.release;
      });
      return deviceType;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;
      print('IOS ->$systemName \nVersion ->$version, \n$name \n$model');
      setState(() {
        deviceType = 'iOS';
        deviceVersion = iosInfo.systemVersion;
      });
      return deviceType;
    }
    print('retrieve Device Type: $deviceType');
    print('retrieve Device Version: $deviceVersion');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<InternetBloc, InternetState>(
        listener: (context, state){
          if(state is InternetGainedState){
            print("Internet Connected");
          }
          else if(state is InternetLostState){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text("Internet Not Connected",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),)
              )
            );
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.orange,
                content: Text("Internet Loading",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),)
              )
            );
          }
        },
        builder: (context, state){
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Image(
                image: AssetImage("assets/Gif/HS_Blood test_GIF.gif"),
              ),
            ),
          );
        },
      ),
    );
  }
}
