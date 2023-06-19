//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Authentication%20Models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataSession with ChangeNotifier{

  Future<bool> saveUserData(LoginModel user)async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('access_token', user.accessToken.toString());
    sp.setString('token_type', user.tokenType.toString());
    notifyListeners();
    return true;
  }

  Future<LoginModel> getUserData()async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String accessToken = sp.getString('access_token');
    final String tokenType = sp.getString('token_type');

    return LoginModel(
      accessToken: accessToken.toString(),
      tokenType: tokenType.toString(),
    );
  }

  Future<bool> removeUserData()async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}