// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Cart%20Menu/patient_model.dart';
import 'package:http/http.dart' as http;
import '../../../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../Api Urls/api_urls.dart';
import '../../Models/Cart Menu/mobile_number_model.dart';
import 'cart_response_model.dart';

class CartFuture{
  var count, amount;
  Future<CartResponseModel> addToCartTest(accessToken, testId, BuildContext context) async {
    print("add to cart ->$testId /$accessToken");
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.addItemsUrls),
        headers: headers,
        body: {
          'test_managements_id': testId.toString(),
        },
      );
      final responseData = json.decode(response.body);
      var bodyStatus = responseData['status'];
      var bodyMsg = responseData['message'];

      if (bodyStatus == 200) {
         count = responseData['data']['count'];
         amount = responseData['data']['amount'];
         GetXSnackBarMsg.getSuccessMsg('$bodyMsg');
      }else if(bodyMsg == 400){
        GetXSnackBarMsg.getWarningMsg('$bodyMsg');
      }
       else {
        GetXSnackBarMsg.getWarningMsg('$bodyMsg');
      }
      return CartResponseModel(bodyStatus, bodyMsg,count, amount);
    } catch (error) {
      print(error.toString());
      GetXSnackBarMsg.getWarningMsg('Please try again');
      return CartResponseModel(500, 'Something went wrong',0,'0.00');
    }
  }

  Future<CartResponseModel> removeToCartTest(accessToken, testId, BuildContext context) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      final response = await http.post(
          Uri.parse(ApiUrls.removeItemsUrls),
          headers: headers,
          body: {
            'test_managements_id': testId.toString()
          }
      );
      final responseData = json.decode(response.body);
      var bodyStatus = responseData['status'];
      var bodyMsg = responseData['message'];
      var count = responseData['data']['count'];
      var amount = responseData['data']['amount'];
      if (bodyStatus == 200) {
        GetXSnackBarMsg.getSuccessMsg('$bodyMsg');
        Navigator.pop(context);
      } else {
        GetXSnackBarMsg.getWarningMsg('$bodyMsg');
      }
      return CartResponseModel(bodyStatus, bodyMsg,count, amount);
    } catch (error) {
      print(error.toString());
      GetXSnackBarMsg.getWarningMsg('Please try again');
      return CartResponseModel(500, 'Something went wrong',0,'0.00');
    }
  }

  Future<List<MobileData>> getMobileNumber(var accessToken, var mobileNumber) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.mobileNumberListUrls),
        headers: headers,
        body: {
          'mobile_no': mobileNumber?.toString() ?? '',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        MobileNumberModel mobileNumberModel = MobileNumberModel.fromJson(data);
        List<MobileData>? mobileNumberList = mobileNumberModel.mobileData;
        print("MobileData -> $mobileNumberList");
        return mobileNumberList ?? [];
      } else {
        throw Exception('Failed to fetch state list');
      }
    } catch (e) {
      print("Error -> $e");
      throw Exception('Failed to fetch state list');
    }
  }

  Future<PatientModel> fetchPatientProfile(var accessToken, var patientId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    var response = await http.post(
        Uri.parse(ApiUrls.patientProfileUrls),
        headers: headers,
      body: {
          'enc_pharmacy_patient_id': patientId.toString(),
      }
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return PatientModel.fromJson(jsonResponse);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}