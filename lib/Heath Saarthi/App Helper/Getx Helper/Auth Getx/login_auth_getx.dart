
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Device%20Info/device_info.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Authentication%20Models/login_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/hs_dashboard.dart';
import 'package:http/http.dart' as http;

import '../../Backend Helper/Api Service/api_calling.dart';
import '../../Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../../Backend Helper/bottom_navigation_controller.dart';
import '../../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../Frontend Helper/Text Helper/test_helper.dart';


class LoginController extends GetxController{

  final controller = Get.put(BottomBarController());

  final mobileNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  RxBool obScured = true.obs;
  void togglePasswordView() {
    obScured.value = !obScured.value;
  }

  LoginModel? loginModel;
  RxBool loginLoading = false.obs;

  Future<void> getLogin() async {
    loginLoading(true);

    try {
      final box = GetStorage();
      final deviceType = box.read('deviceType') ?? DeviceInfo.getDeviceType();
      box.write('deviceType', deviceType);

      final data = {
        "mobile": mobileNumber.text,
        "password": password.text,
        "device_token": box.read('deviceToken') ?? '',
        'device_type': '$deviceType',
      };

      log('login Payload -> $data');

      final response = await http.post(Uri.parse(ApiUrls.loginUrl), body: data);
      final responseBody = jsonDecode(response.body);
      loginModel = LoginModel.fromJson(responseBody);
      log('login response :-> $responseBody');
      if (loginModel?.status == 200) {
        loginLoading(false);
        log('logged in successfully');
        log('login model :-> ${loginModel?.data?.emailId}');
        AuthenticationManager().saveToken(loginModel?.accessToken.toString());
        GetXSnackBarMsg.getSuccessMsg('Login successfully');
        Get.offAll(() => const Home());
      } else if (loginModel?.status == 400) {
        loginLoading(false);
        var errorMessage = responseBody['error']['message'] != null
            ? responseBody['error']['message'][0]
            : null;
        var mobileError = responseBody['error']['mobile'] != null
            ? responseBody['error']['mobile'][0]
            : null;
        var passwordError = responseBody['error']['password'] != null
            ? responseBody['error']['password'][0]
            : null;

        if (errorMessage != null) {
          GetXSnackBarMsg.getWarningMsg('$errorMessage');
        } else if (mobileError != null) {
          GetXSnackBarMsg.getWarningMsg('$mobileError');
        } else if (passwordError != null) {
          GetXSnackBarMsg.getWarningMsg('$passwordError');
        } else {
          log("in else");
        }
      } else if (loginModel?.status == 500) {
        loginLoading(false);
        log('Internal server error');
        GetXSnackBarMsg.getWarningMsg('${AppTextHelper().internalServerError}');
      }
    }
    on FormatException catch (e) {
      print('Error parsing response: $e');
    }
    on SocketException {
      loginLoading(false);
      log('in login socket exception');
    } catch (e) {
      loginLoading(false);
      log('something went wrong in login :-< $e');
    }
  }

  // Future<void> getLogin() async {
  //   final box = GetStorage();
  //   final deviceType = box.read('deviceType') ?? DeviceInfo.getDeviceType();
  //   box.write('deviceType', deviceType);
  //
  //   var url = Uri.parse(ApiUrls.loginUrl);
  //
  //   try {
  //     var request = http.MultipartRequest('POST', url);
  //     request.fields.addAll({
  //       "mobile": mobileNumber.text,
  //       "password": password.text,
  //       "device_token": box.read('deviceToken') ?? '',
  //       'device_type': '$deviceType',
  //     });
  //
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       // If response is successful, print the response body
  //       String responseBody = await response.stream.bytesToString();
  //       print(responseBody);
  //
  //       // Assuming the response body contains JSON, you need to parse it to access the access token
  //       Map<String, dynamic> loginResponse = json.decode(responseBody);
  //
  //       // Extract access token from login response
  //       String? accessToken = loginResponse['access_token'] as String?;
  //       if (accessToken != null) {
  //         // Save access token and handle successful login
  //         loginLoading(false);
  //         AuthenticationManager().saveToken(accessToken);
  //         GetXSnackBarMsg.getSuccessMsg('Login successfully');
  //         controller.index.value = 0;
  //         Get.offAll(() => const Home());
  //       } else {
  //         print('Error: Access token not found in response');
  //       }
  //     } else {
  //       // If response status code is not 200, print the reason phrase
  //       print('Error: ${response.statusCode} - ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     // Catch any exceptions that occur during the request
  //     print('Error: $e');
  //   }
  // }
}