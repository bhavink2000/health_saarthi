//@dart=2.9
// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../Authentication Screens/Login Screen/login_screen.dart';
import '../../../Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../Api Urls/api_urls.dart';


class SignUpProvider with ChangeNotifier {
  Future<void> signUpData({
    TextEditingController firstNm,
    TextEditingController email,
    TextEditingController password,
    TextEditingController mobile,
    TextEditingController createVendor,
    String stateId,
    String cityId,
    String areaId,
    String costCenterId,
    TextEditingController address,
    TextEditingController pincode,
    File panCardFile,
    File addressFile,
    File aadharCardFFile,
    File aadharCardBFile,
    String salesExcutiveId,
    String b2bSubAdminId,
    BuildContext context,
  }) async {
    var url = ApiUrls.signUpUrl;
    try {
      FormData formData = FormData.fromMap({
        "name": firstNm.text,
        "email_id": email.text,
        "password": password.text,
        "mobile": mobile.text,
        "vendor_name": createVendor.text,
        "state_id": '3',
        'city_id': '4',
        'area_id': '29',
        'cost_center_id': '12',
        'address': address.text,
        'pincode': pincode.text,
        'pancard': await MultipartFile.fromFile(panCardFile.path),
        'address_proof': await MultipartFile.fromFile(addressFile.path),
        'aadhar_front': await MultipartFile.fromFile(aadharCardFFile.path),
        'aadhar_back': await MultipartFile.fromFile(aadharCardBFile.path),
        'sales_executive_admin_id': '3',
        'b2b_subadmin_id': '4',
      });
      print('Form -> ${formData.fields}');

      var dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true)); // Enable detailed logging

      var response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        final jsonData = response.data;
        var bodyStatus = jsonData['status'];
        var bodyMSG = jsonData['0'];
        if (bodyStatus == 200) {
          SnackBarMessageShow.successsMSG('$bodyMSG', context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
        } else {
          SnackBarMessageShow.errorMSG('$bodyMSG', context);
        }
      } else if (response.statusCode == 400) {
        var errorData = response.data;
        var errorMessage = errorData['0']['email_id'][0]; // Extract the error message
        SnackBarMessageShow.errorMSG(errorMessage, context);
      } else {
        SnackBarMessageShow.errorMSG('Failed to load data', context);
      }
    } catch (e) {
      print('Error -> ${e.toString()}');
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }
}