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
import '../../../Frontend Helper/Dialog Helper/update_app_dialog.dart';
import '../../../Frontend Helper/Loading Helper/loading_indicator.dart';
import '../../../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
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
      ));

      if(value['access_token'] == null || value['access_token'] == ''){
        GetXSnackBarMsg.getWarningMsg('Login error.\nPlease try again');
        LoadingIndicater().onLoadExit(false, context);
        Navigator.pop(context);
      }
      else{
        GetXSnackBarMsg.getSuccessMsg('login Successfully');
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
      }
    }).catchError((error, stackTrace) {
      print("cathcError -> $error");
      print("cathcStackTrace -> $stackTrace");

      try {
        var errorString = error.toString();
        print("errorString -> $errorString");

        var jsonStartIndex = errorString.indexOf('{');
        print("jsonStartIndex -> $jsonStartIndex");

        var jsonEndIndex = errorString.lastIndexOf('}');
        print("jsonEndIndex -> $jsonEndIndex");

        var jsonString = errorString.substring(jsonStartIndex, jsonEndIndex + 1);
        print("jsonString -> $jsonString");

        var errorData = json.decode(jsonString) as Map<String, dynamic>;
        print("errorData -> $errorData");

        var errorObject = errorData['error'];
        if(errorString == 'Internet connection problem'){
          GetXSnackBarMsg.getWarningMsg('Internet connection problem');
        }
        if (errorObject != null) {
          var errorMessage = errorObject['message'] != null ? errorObject['message'][0] : null;
          var mobileError = errorObject['mobile'] != null ? errorObject['mobile'][0] : null;
          var passwordError = errorObject['password'] != null ? errorObject['password'][0] : null;

          if (errorMessage != null) {
            print("in errorMessage if");
            GetXSnackBarMsg.getWarningMsg('$errorMessage');
          } else if (mobileError != null) {
            print("in mobileError if");
            GetXSnackBarMsg.getWarningMsg('$mobileError');
          } else if (passwordError != null) {
            print("in passwordError if");
            GetXSnackBarMsg.getWarningMsg('$passwordError');
          } else {
            print("in else");
          }
        } else {
          print("No 'error' key found in the response.");
        }

        Navigator.pop(context);
      } catch (e) {
        print('Error decoding response: $e');
        Navigator.pop(context);
      }
    });
  }

}