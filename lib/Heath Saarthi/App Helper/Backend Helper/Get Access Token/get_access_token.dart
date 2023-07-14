//@dart=2.9
// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Authentication%20Models/login_model.dart';
import '../../Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../Providers/Authentication Provider/user_data_auth_session.dart';

class GetAccessToken{
  String access_token = "",token_type = "";
  var userStatus;
  Future<LoginModel> getUserData() => UserDataSession().getUserData();

  void checkAuthentication(BuildContext context, StateSetter setState)async{
    getUserData().then((value)async{
      if(value.accessToken == "null" || value.accessToken == ""){
        SnackBarMessageShow.warningMSG('Authentication Invalid', context);
      }
      else{
        setState((){
          access_token = value.accessToken.toString();
          token_type = value.tokenType.toString();
          userStatus = value.userStatus.toString();
        });
      }
    }).onError((error, stackTrace){
      print(error);
    });
  }
}