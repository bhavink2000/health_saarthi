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
import '../../../App Helper/Backend Helper/Providers/Authentication Provider/authentication_provider.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
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

  final email = TextEditingController();
  final forgotEmail = TextEditingController();
  final password = TextEditingController();
  bool obScured = true;
  void _togglePasswordView() {
    setState(() {
      obScured = !obScured;
    });
  }
  String _errorMessage = '';
  void validateEmail(String val) {
    if(val.isEmpty){
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    }else{
      setState(() {
        _errorMessage = "";
      });
    }
  }
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {

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
                                  height: MediaQuery.of(context).size.height / 4.h,
                                  child: Column(
                                    //mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Image(image: AssetImage("assets/health_saarthi_logo.png"),width: 150),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                        child: TextField(
                                          controller: forgotEmail,
                                          style: const TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne.withOpacity(0.5))),
                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne)),
                                            fillColor: Colors.lightBlueAccent,
                                            labelText: 'Email',
                                            labelStyle: TextStyle(color: hsPrimeOne.withOpacity(0.5),),
                                          ),
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
                                                if (forgotEmail.text.isEmpty) {
                                                  SnackBarMessageShow.warningMSG('Please enter email id', context);
                                                  Navigator.pop(context);
                                                } else {
                                                  try {
                                                    String responseMessage = await getForgotPass(forgotEmail.text);
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
                                                                responseMessage,
                                                                style: const TextStyle(fontFamily: FontType.MontserratMedium)
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
                      builder: (_) => EmailVerify(),
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


  Future<String> getForgotPass(String emailId) async {
    Completer<String> completer = Completer<String>();
    await http.post(Uri.parse(ApiUrls.forgotPasswordUrl), body: {
      'email_id': emailId,
    }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var msg = data['message'];
        if (data['status'] == 200) {
          SnackBarMessageShow.successsMSG("$msg", context);
          completer.complete(msg);
          Navigator.pop(context);
        }
      } else {
        if (response.statusCode == 400) {
          var data = json.decode(response.body);
          var errorMsg = data['error']['email_id'][0];
          if (data['status'] == 400) {
            SnackBarMessageShow.errorMSG("$errorMsg", context);
            completer.completeError(errorMsg);
            Navigator.pop(context);
          }
        }
      }
    });
    return completer.future;
  }

}
