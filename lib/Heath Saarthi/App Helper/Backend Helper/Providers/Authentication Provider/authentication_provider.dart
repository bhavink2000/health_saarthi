// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Authentication%20Models/login_model.dart';
import 'package:provider/provider.dart';
import '../../../../DashBoard/hs_dashboard.dart';
import '../../../Frontend Helper/Loading Helper/loading_indicator.dart';
import '../../../Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../Api Repo/User Authentication/user_authentication.dart';
import 'user_data_auth_session.dart';

class AuthProvider with ChangeNotifier{

  final _myUser = UserAuthentication();

  bool _loading = false;
  bool get loading => _loading;
  setLoginLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    LoadingIndicater().onLoad(true, context);
    setLoginLoading(true);
    _myUser.loginApi(data).then((value) {
      setLoginLoading(false);
      final userDataSession =
      Provider.of<UserDataSession>(context, listen: false);
      userDataSession.saveUserData(LoginModel(
        accessToken: value['access_token'].toString(),
      ));
      SnackBarMessageShow.successsMSG('Login Successfully', context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false);
      LoadingIndicater().onLoadExit(false, context);
      if (kDebugMode) {
        print(value);
      }
    }).catchError((error, stackTrace) {
      setLoginLoading(false);
      var errorData = {};
      try {
        var errorString = error.toString();
        var jsonStartIndex = errorString.indexOf('{');
        var jsonEndIndex = errorString.lastIndexOf('}');
        var jsonString = errorString.substring(jsonStartIndex, jsonEndIndex + 1);
        errorData = json.decode(jsonString) as Map<String, dynamic>;
        var emailError = errorData['error']['email_id'][0] as String;
        var passwordError = errorData['error']['password'][0] as String;
        SnackBarMessageShow.errorMSG('$emailError\n$passwordError', context);
        Navigator.pop(context);
      } catch (e) {
        print('Error decoding response: $error');
        Navigator.pop(context);
      }
    });
  }


}