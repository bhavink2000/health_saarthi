import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Service/api_calling.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../Authentication Screens/Splash Screen/splash_screen.dart';
import '../../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../Frontend Helper/Text Helper/test_helper.dart';
import '../Providers/Authentication Provider/user_data_auth_session.dart';


class DeviceInfo{

  final box = GetStorage();
  static int? getDeviceType() {
    if (GetPlatform.isAndroid) {
      return 0;
    } else if (GetPlatform.isIOS) {
      return 1;
    }
    return null;
  }

  Future<dynamic> sendDeviceToken() async {

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('accessToken')}',
    };
    try {
      var response = await http.post(
        Uri.parse(ApiUrls.addDeviceUrl),
        headers: headers,
        body: {
          'device_token': box.read('deviceToken') ?? '',
          'device_type': box.read('deviceType').toString() ?? '',
          'app_version': '${AppTextHelper().appVersion}' ?? '',
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      }else if(response.statusCode == 201){
        return response.body;
      }
      else {
        throw Exception("Server returned status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error sending device token: $e");
    }
  }

  Future<String> deleteDeviceToken() async {
    var returnMessage;
    Completer<String> completer = Completer<String>();

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('accessToken')}',
    };
    await http.post(
        Uri.parse(ApiUrls.deleteDeviceUrl),
        headers: headers,
        body: {
      'device_token': box.read('deviceToken') ?? '',
    }).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      if (data['status'] == 200) {
        returnMessage = data['massage'];
      } else {
        if (data['status'] == 400) {
          var errorMsg = data['error']['device_token'];
          print("delete Error->$errorMsg");
        }
        returnMessage = data['error']['device_token'];
      }
      completer.complete(returnMessage);
    });
    return completer.future;
  }

  var bodyMsg;
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
      var bodyStatus = responseData['status'];
      bodyMsg = responseData['message'];

      if (bodyStatus == 200) {
        GetXSnackBarMsg.getSuccessMsg('$bodyMsg');
        AuthenticationManager().removeToken().then((value){
          deleteDeviceToken().then((value) {
            if (value == 'success') {
              print("token is deleted $value");
            } else {
              print("Token is not deleted");
            }
          });
        });
        Get.offAll(SplashScreen());
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (context) => const SplashScreen()),
        //       (Route<dynamic> route) => false,
        // );
      } else {
        AuthenticationManager().removeToken().then((value){
          deleteDeviceToken().then((value) {
            if (value == 'success') {
              print("token is deleted $value");
            } else {
              print("Token is not deleted");
            }
          });
        });
        Get.offAll(SplashScreen());
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (context) => const SplashScreen()),
        //       (Route<dynamic> route) => false,
        // );
      }
    } catch (error) {
      print(error.toString());
      AuthenticationManager().removeToken().then((value){
        deleteDeviceToken().then((value) {
          if (value == 'success') {
            print("token is deleted $value");
          } else {
            print("Token is not deleted");
          }
        });
      });
      Get.offAll(SplashScreen());
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (context) => const SplashScreen()),
      //       (Route<dynamic> route) => false,
      // );
    }
  }
}