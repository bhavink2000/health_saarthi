import 'dart:convert';
import 'dart:ui';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/UI%20Helper/app_icons_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Authentication Screens/Splash Screen/splash_screen.dart';
import '../../Backend Helper/Api Urls/api_urls.dart';
import '../../Backend Helper/Device Info/device_info.dart';
import '../../Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../Font & Color Helper/font_&_color_helper.dart';
import '../Snack Bar Msg/getx_snackbar_msg.dart';

class UpdateShowDialog {

  final box = GetStorage();

  void updateShow(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: StatefulBuilder(
            builder: (context, setState) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  content: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image(
                            image: AppIcons.hsTransparent,
                            width: 150,
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        const Text(
                          "About update?",
                          style: TextStyle(
                            fontFamily: FontType.MontserratMedium,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        const Text(
                          "You must be logout your account from health saarthi",
                          style: TextStyle(
                            fontFamily: FontType.MontserratLight,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                          "if you are not logout then you are not use new features",
                          style: TextStyle(fontFamily: FontType.MontserratLight),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "so please logout your account",
                          style: TextStyle(
                            fontFamily: FontType.MontserratMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "",
                          style: TextStyle(fontFamily: FontType.MontserratLight),
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () async {
                                await handleLogout(context);
                              },
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  fontFamily: FontType.MontserratMedium,
                                  color: hsPrime,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> handleLogout(BuildContext context) async {
    //userDataSession = Provider.of<UserDataSession>(context, listen: false);
    try {
      await logoutUser();
      await AuthenticationManager().removeToken();
      await DeviceInfo().deleteDeviceToken(context);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SplashScreen()),
            (Route<dynamic> route) => false,
      );
    } catch (error) {
      print("Error during logout: $error");
      // Handle errors here, show a snackbar, or any other appropriate action
    }
  }

  Future<void> logoutUser() async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('accessToken')}',
    };
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.logoutUrl),
        headers: headers,
      );
      final responseData = json.decode(response.body);
      print("token logout->$responseData");
      var bodyStatus = responseData['status'];
      var bodyMsg = responseData['message'];

      if (bodyStatus == 200) {
        GetXSnackBarMsg.getSuccessMsg('$bodyMsg');
      } else {
        // Handle other status codes or error conditions
        throw Exception("Logout failed: $bodyMsg");
      }
    } catch (error) {
      print("logoutUser catch->$error");
      throw Exception("Logout failed: $error");
    }
  }
}
