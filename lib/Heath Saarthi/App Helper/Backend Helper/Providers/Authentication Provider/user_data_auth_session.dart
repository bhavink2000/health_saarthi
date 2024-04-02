import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Authentication%20Models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationManager {
  final box = GetStorage();

  Future<bool> saveToken(String? token) async {
    await box.write('accessToken', token);
    return true;
  }

  String? getToken() {
    return box.read('accessToken');
  }

  Future<void> removeToken() async {
    await box.remove('accessToken');
  }

}





// class UserDataSession with ChangeNotifier{
//
//   Future<bool> saveUserData(LoginModel user)async{
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.setString('access_token', user.accessToken.toString());
//     sp.setString('token_type', user.tokenType.toString());
//     notifyListeners();
//     return true;
//   }
//
//   Future<LoginModel> getUserData() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     final String? accessToken = sp.getString('access_token');
//     final String? tokenType = sp.getString('token_type');
//     final String? userStatus = sp.getString('status');
//
//     return LoginModel(
//       accessToken: accessToken ?? "",
//       tokenType: tokenType ?? "",
//     );
//   }
//
//   Future<bool> removeUserData()async{
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     return sp.clear();
//   }
// }

