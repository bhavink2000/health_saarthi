//@dart=2.9
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';

class ChangePasswordScreen extends StatefulWidget {
  var accessToken;
  ChangePasswordScreen({Key key,this.accessToken}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final GlobalKey<FormState> _changePasswordFormKey = GlobalKey<FormState>();

  final currentPassword = TextEditingController();
  final password = TextEditingController();
  final cPassword = TextEditingController();

  bool obScured = true;
  void _togglePasswordView() {
    setState(() {
      obScured = !obScured;
    });
  }
  bool obCScured = true;
  void _toggleCPasswordView() {
    setState(() {
      obCScured = !obCScured;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _changePasswordFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back,size: 30,)
                    ),
                    Text("Change password",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18.sp,letterSpacing: 0.5),)
                  ],
                ),
              ),
              Divider(color: Colors.grey.withOpacity(0.5),thickness: 1),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: currentPassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(hsPaddingM),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    hintText: 'Current password',
                    hintStyle: const TextStyle(
                        color: Colors.black54,
                        fontFamily: FontType.MontserratRegular,
                        fontSize: 14
                    ),
                    prefixIcon: const Icon(Icons.password_rounded, color: hsBlack,size: 20),
                  ),
                  onChanged: (value) {
                    if (value.length >= 8 && value.contains(RegExp(r'[A-Z]')) &&
                        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) && value.contains(RegExp(r'[0-9]'))) {
                      // Password meets all the requirements
                    } else {
                      print('Password does not meet the requirements.');
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter current password';
                    }
                    if (value.trim().length < 8) {
                      return 'Password must be at least 8 characters in length';
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain at least one uppercase letter';
                    }
                    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                      return 'Password must contain at least one special character';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: password,
                  obscureText: obScured,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(hsPaddingM),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                        color: Colors.black54,
                        fontFamily: FontType.MontserratRegular,
                        fontSize: 14
                    ),
                    prefixIcon: const Icon(Icons.lock_open_rounded, color: hsBlack,size: 20),
                    suffixIcon: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        obScured
                            ?
                        Icons.visibility_off_rounded
                            :
                        Icons.visibility_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length >= 8 && value.contains(RegExp(r'[A-Z]')) &&
                        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) && value.contains(RegExp(r'[0-9]'))) {
                      // Password meets all the requirements
                    } else {
                      print('Password does not meet the requirements.');
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter new password';
                    }
                    if (value.trim().length < 8) {
                      return 'Password must be at least 8 characters in length';
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain at least one uppercase letter';
                    }
                    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                      return 'Password must contain at least one special character';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: cPassword,
                  obscureText: obCScured,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(hsPaddingM),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    hintText: 'Confirm password',
                    hintStyle: const TextStyle(
                        color: Colors.black54,
                        fontFamily: FontType.MontserratRegular,
                        fontSize: 14
                    ),
                    prefixIcon: const Icon(Icons.lock_outline_rounded, color: hsBlack,size: 20),
                    suffixIcon: InkWell(
                      onTap: _toggleCPasswordView,
                      child: Icon(
                        obCScured
                            ?
                        Icons.visibility_off_rounded
                            :
                        Icons.visibility_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length >= 8 && value.contains(RegExp(r'[A-Z]')) &&
                        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) && value.contains(RegExp(r'[0-9]'))) {
                      // Password meets all the requirements
                    } else {
                      print('Password does not meet the requirements.');
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter confirm password';
                    }
                    if (value.trim().length < 8) {
                      return 'Password must be at least 8 characters in length';
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain at least one uppercase letter';
                    }
                    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                      return 'Password must contain at least one special character';
                    }
                    if(password.text != cPassword.text){
                      return 'Password not match';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: hsPrime,
                      child: InkWell(
                        onTap: (){
                          currentPassword.text = "";
                          password.text = "";
                          cPassword.text = "";
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                          alignment: Alignment.center,
                          child: Text(
                              "Cancel",
                            style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white,fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: hsPrime,
                      child: InkWell(
                        onTap: (){
                          if(_changePasswordFormKey.currentState.validate()){
                            getChangePass();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                          alignment: Alignment.center,
                          child: Text(
                              "Submit",
                            style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white,fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void getChangePass() async {
    await http.post(
        Uri.parse(ApiUrls.changePasswordUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${widget.accessToken}',
        },
        body: {
          'current_password': currentPassword.text,
          'password': password.text,
          'confirm_password': cPassword.text,
        }
    ).then((response) {
      print(response.body);
      if(response.statusCode == 200){
        var data = json.decode(response.body);
        var msg = data['message'];
        if (data['status'] == 200) {
          SnackBarMessageShow.successsMSG("$msg", context);
          Navigator.pop(context);
        }
      }
      else{
        if(response.statusCode == 400){
          var data = json.decode(response.body);
          var errorMsg = data['message'];
          if (data['status'] == 400) {
            SnackBarMessageShow.warningMSG("$errorMsg", context);
            Navigator.pop(context);
          }
        }
      }
    });
  }
}
