// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Authentication Screens/Login Screen/login_screen.dart';
import '../../../Authentication Screens/Splash Screen/splash_screen.dart';
import '../../Backend Helper/Api Urls/api_urls.dart';
import '../../Backend Helper/Device Info/device_info.dart';
import '../../Backend Helper/Get Access Token/get_access_token.dart';
import '../../Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../Font & Color Helper/font_&_color_helper.dart';
import '../Snack Bar Msg/getx_snackbar_msg.dart';
import '../Snack Bar Msg/snackbar_msg_show.dart';

class TokenExpiredHelper extends StatefulWidget {
  const TokenExpiredHelper({Key? key}) : super(key: key);

  @override
  State<TokenExpiredHelper> createState() => _TokenExpiredHelperState();
}

class _TokenExpiredHelperState extends State<TokenExpiredHelper> {
  GetAccessToken getAccessToken = GetAccessToken();
  String? deviceToken;

  @override
  void initState() {
    super.initState();
    retrieveDeviceToken();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      DeviceInfo().logoutUser(context, deviceToken, getAccessToken.access_token);
    });
  }
  Future<void> retrieveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      deviceToken = prefs.getString('deviceToken');
    });
    print("SharedPreferences DeviceToken->$deviceToken");
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
