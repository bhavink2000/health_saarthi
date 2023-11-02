
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import '../../../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../Api Service/api_service_post_get.dart';
import '../../Api Service/api_service_type_post_get.dart';

class UserAuthentication {
  ApiServicesTypePostGet apiServicesTypePostGet = ApiServicePostGet();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await apiServicesTypePostGet.postApiResponse(ApiUrls.loginUrl, data);
      return response;
    } catch (e) {
      if(e.toString() == 'Internet connection problem'){
        GetXSnackBarMsg.getWarningMsg('Internet connection problem');
      }
      else{}
      print("throw e->$e");
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
      var forgotData = json.decode(response.body);
      print("forgot data->$forgotData");
      if(forgotData['status'] == 200){
        var msg = forgotData['message'];
        GetXSnackBarMsg.getWarningMsg('$msg');
        return forgotData['status'];
      }
      else if(forgotData['status'] == 400){
        if(forgotData['status'] == 400){
          var errorMsg = forgotData['error']['password'][0];
          GetXSnackBarMsg.getWarningMsg('$errorMsg');
        }
        else{
          var errorMsg = forgotData['message'];
          GetXSnackBarMsg.getWarningMsg('$errorMsg');
        }
      }
      else{
        Navigator.pop(context);
      }
    } catch (e) {
      print("forgot e->$e");
      Navigator.pop(context);
    }
  }
}