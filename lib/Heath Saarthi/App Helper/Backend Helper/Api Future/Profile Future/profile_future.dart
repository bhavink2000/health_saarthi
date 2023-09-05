import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
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
      if(jsonResponse['status'] == '402'){
        print("in if with status code ->${jsonResponse['status']}");
        throw Exception(jsonResponse);
      }
      else{
        print("in else with status code ->${jsonResponse['status']}");
        return ProfileModel.fromJson(jsonResponse);
      }
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
