// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../Api Urls/api_urls.dart';

/*
class DeviceInfo{
  Future<String> sendDeviceToken(BuildContext context, deviceToken, deviceType) async {
    var returnToken;
    var dType = deviceType == 'Android' ? 0 : 1;

    Completer<String> completer = Completer<String>();

    await http.post(Uri.parse(ApiUrls.addDeviceUrl), body: {
      'device_token': deviceToken ?? '',
      'device_type': dType.toString() ?? '',
      'app_version': '1' ?? '',
    }).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      if (data['status'] == 200) {
        returnToken = data['data']['device_token'];
      } else if (data['status'] == 400) {
        var errorMsg = data['error']['device_token'];
        SnackBarMessageShow.warningMSG("$errorMsg", context);
        returnToken = data['error']['device_token'];
      } else {
        var data = json.decode(response.body);
        if (data['status'] == 400) {
          var errorMsg = data['error']['device_token'];
          SnackBarMessageShow.warningMSG("$errorMsg", context);
        }
        returnToken = data['error']['device_token'];
      }
      completer.complete(returnToken);
    });
    return completer.future;
  }

  Future<String> deleteDeviceToken(BuildContext context, deviceToken) async {
    print("Delete Device Token->$deviceToken");

    var returnMessage;
    Completer<String> completer = Completer<String>();

    await http.post(Uri.parse(ApiUrls.deleteDeviceUrl), body: {
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
          SnackBarMessageShow.warningMSG("$errorMsg", context);
        }
        returnMessage = data['error']['device_token'];
      }
      completer.complete(returnMessage);
    });
    return completer.future;
  }
}*/
