//@dart=2.9
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';
import 'package:provider/provider.dart';

import '../../../Authentication Screens/Login Screen/login_screen.dart';
import '../../Backend Helper/Api Urls/api_urls.dart';
import '../../Backend Helper/Get Access Token/get_access_token.dart';
import '../../Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../Snack Bar Msg/snackbar_msg_show.dart';

class LoginErrorHelper extends StatefulWidget {
  const LoginErrorHelper({Key key}) : super(key: key);

  @override
  State<LoginErrorHelper> createState() => _LoginErrorHelperState();
}

class _LoginErrorHelperState extends State<LoginErrorHelper> {

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
  }

  @override
  Widget build(BuildContext context) {
    final userDataSession = Provider.of<UserDataSession>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.5.w,
          height: MediaQuery.of(context).size.height / 4.h,
          child: const Image(
            image: AssetImage("assets/Gif/logout.gif"),
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            "Your Token Is Expired, \nSo You Need To Login To Continue Your Activities",
            style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsOne,fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width /1.5.w,
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsTwo),
                  child: const Text("Back",style: TextStyle(color: Colors.white,fontSize: 16),),
                ),
              ),
              InkWell(
                onTap: (){
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: AlertDialog(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                            content: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset("assets/health_saarthi_logo.png",width: 150),
                                  const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "Are You Sure Would Like To Logout?",
                                      style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      TextButton(
                                        child: const Text("Stay",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 2),),
                                        onPressed: () => Navigator.of(context).pop(),
                                      ),
                                      TextButton(
                                        child: const Text("Logout",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 2),),
                                        onPressed: (){
                                          logoutUser().then((value){
                                            userDataSession.removeUserData();
                                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  );
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsTwo),
                  child: const Text("Logout",style: TextStyle(color: Colors.white,fontSize: 16),),
                ),
              ),
            ],
          ),
        )
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
      var bodyStatus = responseData['status'];
      bodyMsg = responseData['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMsg', context);
      } else {
        SnackBarMessageShow.warningMSG('$bodyMsg', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.warningMSG('Something went wrong', context);
    }
  }
}
