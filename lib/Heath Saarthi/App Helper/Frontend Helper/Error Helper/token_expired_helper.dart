// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Backend Helper/Device Info/device_info.dart';
import '../../Backend Helper/Get Access Token/get_access_token.dart';


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
