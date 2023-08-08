import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:http/http.dart' as http;
import '../../../DashBoard/hs_dashboard.dart';
import '../../Frontend Helper/Loading Helper/loading_indicator.dart';
import '../../Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';

class DeviceInfo{
  Future<String> sendDeviceToken(BuildContext context, deviceToken, deviceType) async {
    var dType = deviceType == 'Android' ? 0 : 1;

    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    var response = await http.post(
      Uri.parse(ApiUrls.addDeviceUrl),
      headers: headers,
      body: {
        'device_token': deviceToken ?? '',
        'device_type': dType.toString() ?? '',
        'app_version': '0.5' ?? '',
      },
    );

    print("Device Token Response -> ${response.body}");

    return response.body;
  }
  Future<String> deleteDeviceToken(BuildContext context, deviceToken,accessToken) async {
    print("Delete Device Token->$deviceToken");

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
}