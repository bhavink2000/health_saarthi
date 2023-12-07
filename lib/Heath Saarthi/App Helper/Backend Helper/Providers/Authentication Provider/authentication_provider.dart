// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Authentication%20Models/login_model.dart';
import 'package:provider/provider.dart';
//import '../../../../../HealthSaarthi/HS_Dashboard/health_saarthi_dashboard.dart';
import '../../../../DashBoard/hs_dashboard.dart';
import '../../../Frontend Helper/Loading Helper/loading_indicator.dart';
import '../../../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../Api Repo/User Authentication/user_authentication.dart';
import 'user_data_auth_session.dart';

class AuthProvider with ChangeNotifier{

  var accessToken = GetStorage();

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
      accessToken.write('accessToken', value['access_token'].toString());

      if(value['access_token'] == null || value['access_token'] == ''){
        GetXSnackBarMsg.getWarningMsg('Login error.\nPlease try again');
        LoadingIndicater().onLoadExit(false, context);
        Navigator.pop(context);
      }
      else{
        GetXSnackBarMsg.getSuccessMsg('login Successfully');
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
        //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HSDashboard()), (Route<dynamic> route) => false);
      }
    }).catchError((error, stackTrace) {
      try {
        var errorString = error.toString();
        var jsonStartIndex = errorString.indexOf('{');
        var jsonEndIndex = errorString.lastIndexOf('}');
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

            GetXSnackBarMsg.getWarningMsg('$errorMessage');
          } else if (mobileError != null) {

            GetXSnackBarMsg.getWarningMsg('$mobileError');
          } else if (passwordError != null) {

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
        GetXSnackBarMsg.getWarningMsg('Internal server error 500');
        Navigator.pop(context);
      }
    });
  }

}