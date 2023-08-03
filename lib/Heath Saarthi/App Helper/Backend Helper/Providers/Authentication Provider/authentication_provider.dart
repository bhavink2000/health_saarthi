// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'dart:ui';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Device%20Info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Authentication%20Models/login_model.dart';
import 'package:provider/provider.dart';
import '../../../../DashBoard/hs_dashboard.dart';
import '../../../Frontend Helper/Loading Helper/loading_indicator.dart';
import '../../../Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../Api Repo/User Authentication/user_authentication.dart';
import '../../App Exceptions/app_exceptions.dart';
import 'user_data_auth_session.dart';

class AuthProvider with ChangeNotifier{

  final _myUser = UserAuthentication();

  bool _loading = false;
  bool get loading => _loading;
  setLoginLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context, var deviceToken,var deviceType) async {
    print("login Data->$data");
    LoadingIndicater().onLoad(true, context);
    setLoginLoading(true);
    _myUser.loginApi(data).then((value) {

      setLoginLoading(false);
      final userDataSession = Provider.of<UserDataSession>(context, listen: false);
      userDataSession.saveUserData(LoginModel(
        accessToken: value['access_token'].toString(),
        userStatus: value['data']['status'].toString(),
      ));
      print("accessToken--------->${value['access_token'].toString()}");
      SnackBarMessageShow.successsMSG('Login Successfully', context);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
      if (kDebugMode) {
        print(value);
      }
    }).catchError((error, stackTrace) {
      print("cathcError->$error");
      print("cathcStackTrace->$stackTrace");
      var errorString = error.toString();
      var jsonStartIndex = errorString.indexOf('{');
      var jsonEndIndex = errorString.lastIndexOf('}');
      var jsonString = errorString.substring(jsonStartIndex, jsonEndIndex + 1);
      var errorData = json.decode(jsonString) as Map<String, dynamic>;
      var eError = errorData['error'];
      print("e data->$errorData");
      if (error is UnAuthorizedException) {
        SnackBarMessageShow.warningMSG('${eError}', context);
        Navigator.pop(context);
        return;
      }
      var errorDatas = {};
      try {
        var errorString = error.toString();
        print("errorStrig ->$errorString");
        var jsonStartIndex = errorString.indexOf('{');
        print("jsonStarti->$jsonStartIndex");
        var jsonEndIndex = errorString.lastIndexOf('}');
        print("jsonEndI->$jsonEndIndex");
        var jsonString = errorString.substring(jsonStartIndex, jsonEndIndex + 1);
        print("jsonString->$jsonString");
        errorDatas = json.decode(jsonString) as Map<String, dynamic>;
        print("errorDates->$errorDatas");
        var emailError = errorData['error']['email_id'][0].replaceAll(RegExp(r'\[|\]'), '');
        print("emailError->$emailError");
        var passwordError = errorDatas['error']['password'][0] as String;
        SnackBarMessageShow.warningMSG('$emailError\n$passwordError', context);
        Navigator.pop(context);
      } catch (e) {
        print('Error decoding response: $e');
        Navigator.pop(context);
      }
    });
  }

}