import 'dart:convert';
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

  Future<UserModel> fetchUser(String userEmail, String userPassword) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.loginUrl),
        body: {
          'email_id': userEmail,
          'password': userPassword,
        },
      );
      print("User Response -> ${response.body}");
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        if (jsonBody.containsKey('status') && jsonBody['status'] == 200) {
          return UserModel.fromJson(jsonBody);
        } else {
          throw Exception('Failed to fetch user: Invalid status code');
        }
      } else {
        throw Exception('Failed to fetch user: ${response.statusCode}');
      }
    } catch (e) {
      print("catch E->$e");
      throw Exception('Failed to fetch user: $e');
    }
  }
}
