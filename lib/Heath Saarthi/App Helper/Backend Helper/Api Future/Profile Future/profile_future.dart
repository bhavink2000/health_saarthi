import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/snackbar_msg_show.dart';
import 'package:http/http.dart' as http;
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';

import '../../Models/Authentication Models/user_model.dart';
import '../../Models/Dashboard Model/profile_model.dart';

class ProfileFuture{
  Future<ProfileModel> fetchProfile(var accessToken) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    var response = await http.get(
      Uri.parse(ApiUrls.profileUrls),
      headers: headers,
    );
    print("Profile Response->${response.body}");
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print("Response -> $jsonResponse");
      if (jsonResponse['status'] == 'Token is Expired') {
        throw Exception('Token is Expired');
      }
      return ProfileModel.fromJson(jsonResponse);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
