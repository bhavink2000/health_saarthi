//@dart=2.9
// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../App Helper/Backend Helper/Api Service/notification_service.dart';
import '../../App Helper/Backend Helper/Models/Authentication Models/login_model.dart';
import '../../App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
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
    notificationService.getDeviceToken().then((value) {
      if (value == '' || value == null) {
        print("Do Not Get Device Token");
      } else {
        setState(() {
          deviceToken = value;
        });
        storeDeviceToken(value).then((_) {
          retrieveDeviceDetails().then((value) async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('deviceType', value);
            print("Device type value->>>>$value");

            if (deviceToken == '' || value == '' || deviceToken == null || value == null) {
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
  var access_token = GetStorage();
  Future<void> storeDeviceToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceToken', token);
  }
  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      print("checkAuth Access Token => ${value.accessToken}");

      access_token.write('accessToken', value.accessToken);

      if (value.accessToken == '' || value.accessToken == null || value.accessToken == 'null') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen(deviceToken: deviceToken,deviceType: deviceType)),
        );
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HSDashboard()));
      }
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  Future retrieveDeviceDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      print('Android Release Version appName->$appName \npackageName->$packageName, \nversion->$version \nbuildNumber->$buildNumber');
      setState(() {
        deviceType = 'Android';
        deviceVersion = version;
      });
      return deviceType;
    } else if (Platform.isIOS) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      print('IOS Release Version appName->$appName \npackageName->$packageName, \nversion->$version \nbuildNumber->$buildNumber');
      setState(() {
        deviceType = 'iOS';
        deviceVersion = version;
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 4),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Image(
                image: AssetImage("assets/Gif/HS_Blood test_GIF.gif"),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Image(
                image: AssetImage("assets/health_saarthi_logo.png"),
                width: 150,
              ),
            ),
            const Text("Version 1.0",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.grey))
          ],
        ),
      )
    );
  }
}
