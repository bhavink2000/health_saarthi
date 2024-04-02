
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '../../../HealthSaarthi/HS_Dashboard/health_saarthi_dashboard.dart';
import '../../App Helper/Backend Helper/Api Service/notification_service.dart';
import '../../App Helper/Backend Helper/Device Info/device_info.dart';
import '../../App Helper/Backend Helper/Models/Authentication Models/login_model.dart';
import '../../App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/UI Helper/app_icons_helper.dart';
import '../../DashBoard/hs_dashboard.dart';
import '../Login Screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    int? deviceType = DeviceInfo.getDeviceType();
    final box = GetStorage();
    box.write('deviceType', deviceType);
    Future.delayed(const Duration(seconds: 3), () {
      var token = AuthenticationManager().getToken();
      token != null ? Get.off(() => const Home()) : Get.off(() => LoginScreen());
    });
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
            Padding(
              padding: EdgeInsets.all(15),
              child: Image(
                image: AppIcons.splashHsGIF,
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Image(
                image: AppIcons.hsLogo,
                width: 150,
              ),
            ),
            Text("Version ${AppTextHelper().appVersion}",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.grey)),
            Platform.isIOS ? SizedBox(height: 15) : Container()
          ],
        ),
      )
    );
  }
}
