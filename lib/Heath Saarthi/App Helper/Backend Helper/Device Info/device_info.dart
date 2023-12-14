import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../Authentication Screens/Splash Screen/splash_screen.dart';
import '../../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../Frontend Helper/Text Helper/test_helper.dart';
import '../Providers/Authentication Provider/user_data_auth_session.dart';


class DeviceInfo{


  Future<String> sendDeviceToken(BuildContext context, deviceToken, deviceType, accessToken) async {

    var dType = deviceType == 'Android' ? 0 : 1;
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
        Uri.parse(ApiUrls.addDeviceUrl),
        headers: headers,
        body: {
          'device_token': deviceToken ?? '',
          'device_type': dType.toString() ?? '',
          'app_version': '2.03' ?? '',
        },
      );
      print("Device Token Response -> ${response.body}");
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

  Future<String> deleteDeviceToken(BuildContext context, deviceToken,accessToken) async {
    var returnMessage;
    Completer<String> completer = Completer<String>();

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    await http.post(
        Uri.parse(ApiUrls.deleteDeviceUrl),
        headers: headers,
        body: {
      'device_token': deviceToken ?? '',
    }).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      if (data['status'] == 200) {
        returnMessage = data['massage'];
      } else {
        var data = json.decode(response.body);
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
  Future<void> logoutUser(BuildContext context, var deviceToken, var accessToken) async {
    final userDataSession = Provider.of<UserDataSession>(context, listen: false);
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${accessToken}',
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
        userDataSession.removeUserData().then((value) {
          deleteDeviceToken(context, deviceToken, accessToken).then((value) {
            if (value == 'success') {
              print("token is deleted $value");
            } else {
              print("Token is not deleted");
            }
          });
        });
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SplashScreen()),
              (Route<dynamic> route) => false,
        );
      } else {
        userDataSession.removeUserData().then((value) {
          deleteDeviceToken(context, deviceToken, accessToken).then((value) {
            if (value == 'success') {
              print("token is deleted $value");
            } else {
              print("Token is not deleted");
            }
          });
        });
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SplashScreen()),
              (Route<dynamic> route) => false,
        );
      }
    } catch (error) {
      print(error.toString());
      userDataSession.removeUserData().then((value) {
        deleteDeviceToken(context, deviceToken, accessToken).then((value) {
          if (value == 'success') {
            print("token is deleted $value");
          } else {
            print("Token is not deleted");
          }
        });
      });
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SplashScreen()),
            (Route<dynamic> route) => false,
      );
      //GetXSnackBarMsg.getWarningMsg('${AppTextHelper().logoutProblem}');
    }
  }
}