import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/token_expired_helper.dart';
import 'package:http/http.dart' as http;
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import '../../Models/Dashboard Model/profile_model.dart';

class ProfileFuture{

  final box = GetStorage();
  Future<ProfileModel> fetchProfile() async {

    log('profile url --->>${ApiUrls.profileUrls}');

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('accessToken')}',
    };

    var response = await http.get(
      Uri.parse(ApiUrls.profileUrls),
      headers: headers,
    );
    log("profile response->${response.body}");
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if(jsonResponse['status'] == '402'){
        throw Exception(jsonResponse);
      }
      else{
        return ProfileModel.fromJson(jsonResponse);
      }
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
