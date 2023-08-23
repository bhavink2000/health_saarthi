import 'package:shared_preferences/shared_preferences.dart';

import '../Get Access Token/get_access_token.dart';

class LogoutUserFromApp{
  GetAccessToken getAccessToken = GetAccessToken();
  var deviceToken;

  Future<dynamic> retrieveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      deviceToken = prefs.getString('deviceToken');
    print("SharedPreferences DeviceToken->$deviceToken");
    return deviceToken;
  }
}