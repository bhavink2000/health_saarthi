// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
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
  var tokenMsg;
  TokenExpiredHelper({Key? key,this.tokenMsg}) : super(key: key);

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
    final userDataSession = Provider.of<UserDataSession>(context, listen: false);
    Future.delayed(const Duration(seconds: 1),(){
      logoutUser().then((value){
        userDataSession.removeUserData().then((value){
          DeviceInfo().deleteDeviceToken(context, deviceToken,getAccessToken.access_token).then((value){
            if(value == 'success'){
              print("token is deleted $value");
            }
            else{
              print("Token is not deleted");
            }
          });
        });
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SplashScreen()), (Route<dynamic> route) => false);
      });
      //openLogoutBox(context);
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
    final userDataSession = Provider.of<UserDataSession>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text("${widget.tokenMsg}",
              style: const TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 16,fontWeight: FontWeight.bold),
            )
        ),
        SizedBox(height: 10.h,),
      ],
    );
  }

  var bodyMsg;
  Future<void> logoutUser() async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.logoutUrl),
        headers: headers,
      );
      final responseData = json.decode(response.body);
      print("token logout->$responseData");
      var bodyStatus = responseData['status'];
      bodyMsg = responseData['message'];

      if (bodyStatus == 200) {
        GetXSnackBarMsg.getWarningMsg('$bodyMsg');
      } else {
      }
    } catch (error) {
      print("logoutUser catch->$error");
    }
  }
}
