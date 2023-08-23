
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import '../../../Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../Api Service/api_service_post_get.dart';
import '../../Api Service/api_service_type_post_get.dart';

class UserAuthentication {
  ApiServicesTypePostGet apiServicesTypePostGet = ApiServicePostGet();

  Future<dynamic> loginApi(dynamic data) async {
    print("login api data->$data");
    try {
      dynamic response = await apiServicesTypePostGet.postApiResponse(ApiUrls.loginUrl, data);
      return response;
    } catch (e) {
      print("Login Error->$e");
      throw e;
    }
  }
  Future<dynamic> getForgotPass(var mobileNo,var pass, var cPass, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.forgotPasswordUrl),
        body: {
          'mobile': mobileNo,
          'password': pass,
          'confirm_password': cPass,
        },
      );
      print("response->${response.body}");
      var forgotData = json.decode(response.body);
      print("forgot data->$forgotData");

      if(forgotData['status'] == 200){
        var msg = forgotData['message'];
        SnackBarMessageShow.successsMSG('$msg', context);
        return forgotData['status'];
      }
      else if(forgotData['status'] == 400){
        if(forgotData['status'] == 400){
          var errorMsg = forgotData['error']['password'][0];
          SnackBarMessageShow.warningMSG('$errorMsg', context);
        }
        else{
          var errorMsg = forgotData['message'];
          SnackBarMessageShow.warningMSG('$errorMsg', context);
        }
      }
      else{
        print("in main else");
        Navigator.pop(context);
      }
    } catch (e) {
      print("forgot e->$e");
      Navigator.pop(context);
    }
  }
}