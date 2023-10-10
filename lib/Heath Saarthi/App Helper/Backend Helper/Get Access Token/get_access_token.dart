
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Authentication%20Models/login_model.dart';
import '../../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../Providers/Authentication Provider/user_data_auth_session.dart';

class GetAccessToken{
  String access_token = "",token_type = "";
  var userStatus;
  Future<LoginModel> getUserData() => UserDataSession().getUserData();

  void checkAuthentication(BuildContext context, StateSetter setState)async{
    getUserData().then((value)async{
      if(value.accessToken == "null" || value.accessToken == ""){
        GetXSnackBarMsg.getWarningMsg('Authentication invalid');
      }
      else{
        setState((){
          access_token = value.accessToken.toString();
          token_type = value.tokenType.toString();
        });
      }
    }).onError((error, stackTrace){
      print(error);
    });
  }
}