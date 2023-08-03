// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Sign%20up%20Screen/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../App Helper/Backend Helper/Device Info/device_info.dart';
import '../../../App Helper/Backend Helper/Providers/Authentication Provider/authentication_provider.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Loading Helper/loading_indicator.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../Sign up Screen/Email & OTP Verify/email_verify.dart';
import 'custom_button.dart';
import 'fade_slide_transition.dart';

class LoginForm extends StatefulWidget {
  final Animation<double> animation;
  var screenH,deviceToken,deviceType;
  LoginForm({Key? key,this.screenH,
    required this.animation,this.deviceType,this.deviceToken
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  double screenHeight = 0;
  double screenWidth = 0;

  final email = TextEditingController();
  final forgotEmail = TextEditingController();
  final password = TextEditingController();
  bool obScured = true;
  void _togglePasswordView() {
    setState(() {
      obScured = !obScured;
    });
  }
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;


  var appVersion, updateMsg;
  @override
  void initState() {
    super.initState();
    DeviceInfo().sendDeviceToken(context, widget.deviceToken, widget.deviceType).then((value) {
      if (value == null) {
        LoadingIndicater().onLoadExit(false, context);
        Navigator.pop(context);
      } else {
        var data = json.decode(value);
        if (data['status'] == 200) {
          print("version status${data['status']}");
          //LoadingIndicater().onLoadExit(false, context);
          //Navigator.pop(context);
        } else if (data['status'] == 201) {
          setState(() {
            updateMsg = data['message'];
            appVersion = data['app_version'];
          });
          showDialog(
              context: context,
              builder: (BuildContext context){
                return StatefulBuilder(
                  builder: (context, setState){
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: AlertDialog(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                        contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                        content: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.height / 2.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("About update?",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18,fontWeight: FontWeight.bold)),
                              Text("$updateMsg Version $appVersion is now available - \nYour current app version 1.0",style: const TextStyle(fontFamily: FontType.MontserratLight),),
                              const SizedBox(height: 10,),
                              const Text("Would you like to update it now?",style: TextStyle(fontFamily: FontType.MontserratLight)),
                              const SizedBox(height: 10),
                              const Text("Release Notes:",style: TextStyle(fontFamily: FontType.MontserratMedium,fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              const Text("Minor update and \nimprovement",style: TextStyle(fontFamily: FontType.MontserratLight),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Later")
                                  ),
                                  TextButton(
                                      onPressed: (){},
                                      child: const Text("Update Now")
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
          );
        } else {
          var errorMsg = data['error']['device_token'];
          print("Error->$errorMsg");
          LoadingIndicater().onLoadExit(false, context);
          Navigator.pop(context);
        }
      }
    });
  }
  final GlobalKey<FormState> _forgotPasswordKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final userAuth = Provider.of<AuthProvider>(context);
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? hsSpaceM : hsSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: hsPaddingL),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: 0.0,
              child: TextFormField(
                controller: email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Email',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratMedium,
                  ),
                  prefixIcon: const Icon(
                    Icons.email_rounded,
                    color: Colors.black87,
                  ),
                ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email id';
                    }
                    return null;
                  }
              ),
            ),
            SizedBox(height: space),
            FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: space,
              child: TextFormField(
                controller: password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: obScured,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratMedium
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_open_rounded,
                    color: Colors.black87
                  ),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: space),
            SizedBox(height: space),
            FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: 2 * space,
              child: InkWell(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setState){
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: AlertDialog(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                contentPadding: const EdgeInsets.only(top: 10.0),
                                content: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  height: MediaQuery.of(context).size.height / 3.5.h,
                                  child: Form(
                                    key: _forgotPasswordKey,
                                    child: Column(
                                      //mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Image(image: AssetImage("assets/health_saarthi_logo.png"),width: 150),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                          child: TextFormField(
                                            controller: forgotEmail,
                                            style: const TextStyle(color: Colors.black),
                                            decoration: InputDecoration(
                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne.withOpacity(0.5))),
                                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne)),
                                              fillColor: Colors.lightBlueAccent,
                                              labelText: 'Email',
                                              labelStyle: TextStyle(color: hsPrimeOne.withOpacity(0.5),),
                                            ),
                                            onChanged: (value) {
                                              if (value.contains(RegExp(r'[A-Z]')) && value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                                // Password meets all the requirements
                                              } else if (!value.contains('gmail.com')) {
                                                // Show a SnackBar with the error message
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  backgroundColor: hsPrime,
                                                  content: const Text('Email id must contain "gmail.com"'),
                                                ));
                                              } else {
                                                // Show a SnackBar with the error message
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  backgroundColor: hsPrime,
                                                  content: const Text('Please enter a valid email id'),
                                                ));
                                              }
                                            },
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter a email';
                                              }
                                              if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                                return 'email id must contain at least one special character';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                              child: TextButton(
                                                child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,color: Colors.white),),
                                                onPressed: (){
                                                  forgotEmail.text = '';
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                              child: TextButton(
                                                child: const Text("Send",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,color: Colors.white),),
                                                onPressed: () async {
                                                  if (_forgotPasswordKey.currentState!.validate()) {
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          content: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: const [
                                                              CircularProgressIndicator(),
                                                              SizedBox(height: 16),
                                                              Text('Sending...'),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );

                                                    try {
                                                      String? responseMessage = await getForgotPass(forgotEmail.text, context);
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      Navigator.pop(context);

                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          Future.delayed(const Duration(seconds: 2), () {
                                                            Navigator.pop(context); // Close dialog after 2 seconds
                                                          });
                                                          return AlertDialog(
                                                            content: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Text(
                                                                  responseMessage!,
                                                                  style: const TextStyle(fontFamily: FontType.MontserratMedium),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } catch (error) {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      Navigator.pop(context);
                                                      // Handle error case
                                                    }

                                                    forgotEmail.text = '';
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                  );
                },
                child: Text("Forgot password",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsPrime,letterSpacing: 1),))
            ),
            SizedBox(height: space),
            SizedBox(height: space),
            FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: 2 * space,
              child: InkWell(
                onTap: ()async{
                  if (_formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();

                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('email', email.text);
                    await prefs.setString('password', password.text);

                    Map data = {
                      "email_id": email.text,
                      "password": password.text
                    };
                    userAuth.loginApi(data, context,widget.deviceToken,widget.deviceType);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: hsPrime),
                  child: const Text("Login to continue",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                ),
              ),
            ),
            SizedBox(height: space),
            FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: 4 * space,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SignUpScreen(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: hsBlack),
                  child: const Text("Create an account",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<String?> getForgotPass(String emailId, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.forgotPasswordUrl),
        body: {'email_id': emailId},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final forgotPasswordResponse = ForgotPasswordResponse.fromJson(data);

        if (forgotPasswordResponse.status == 200) {
          SnackBarMessageShow.successsMSG("${forgotPasswordResponse.message}", context);
          Navigator.pop(context);
          return forgotPasswordResponse.message;
        } else if (forgotPasswordResponse.status == 400) {
          final errorMsg = forgotPasswordResponse.error['email_id'][0];
          SnackBarMessageShow.errorMSG("$errorMsg", context);
          Navigator.pop(context);
          return Future.error(errorMsg);
        }
      } else {
        // Handle non-200 status code (e.g., 404, 500)
        throw Exception("Failed to perform the request. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      SnackBarMessageShow.errorMSG("An error occurred: ${e.toString()}", context);
      Navigator.pop(context);
      return Future.error(e.toString());
    }
  }

}
class ForgotPasswordResponse {
  final int status;
  final String message;
  final Map<String, dynamic> error;

  ForgotPasswordResponse({required this.status, required this.message, required this.error});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      status: json['status'],
      message: json['message'],
      error: json['error'],
    );
  }
}