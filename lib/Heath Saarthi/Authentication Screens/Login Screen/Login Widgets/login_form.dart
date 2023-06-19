import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Sign%20up%20Screen/signup_screen.dart';
import 'package:provider/provider.dart';
import '../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../App Helper/Backend Helper/Providers/Authentication Provider/authentication_provider.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import 'custom_button.dart';
import 'fade_slide_transition.dart';

class LoginForm extends StatefulWidget {
  final Animation<double> animation;
  var screenH;
  LoginForm({Key? key,this.screenH,
    required this.animation,
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
  @override
  Widget build(BuildContext context) {

    final userAuth = Provider.of<AuthProvider>(context);

    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? hsSpaceM : hsSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: hsPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 0.0,
            child: TextField(
              controller: email,
              decoration: InputDecoration(
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
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            child: TextField(
              controller: password,
              obscureText: obScured,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(hsPaddingM),
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
                    Icons.visibility_sharp
                        :
                    Icons.visibility_off_sharp,
                    color: Colors.black,
                  ),
                ),
              ),
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
                                height: MediaQuery.of(context).size.height / 4.5.h,
                                child: Column(
                                  //mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Health Saarthi", style: TextStyle(fontFamily: FontType.MontserratMedium,fontWeight: FontWeight.bold,letterSpacing: 3,fontSize: 18),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                      child: TextField(
                                        controller: forgotEmail,
                                        style: TextStyle(color: Colors.black),
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
                                            onPressed: (){
                                              if(forgotEmail.text.isEmpty){
                                                print("in if");
                                                SnackBarMessageShow.warningMSG('Please Fill Field', context);
                                              }
                                              else{
                                                print("in else");
                                                getForgotPass(forgotEmail.text);
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
              child: Text("Forgot Password",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsPrime,letterSpacing: 1),))
          ),
          SizedBox(height: space),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 2 * space,
            child: CustomButton(
              color: hsPrime,
              textColor: hsWhite,
              text: 'Login to continue',
              onPressed: () {
                Map data = {
                  "email_id": email.text,
                  "password": password.text
                };
                userAuth.loginApi(data, context);
                /*if(email.text.isEmpty || password.text.isEmpty){
                  SnackBarMessageShow.warningMSG('Please Fill All Field', context);
                }
                else{
                  Map data = {
                    "email_id": email.text,
                    "password": password.text
                  };
                  userAuth.loginApi(data, context);
                }*/
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
              },
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 4 * space,
            child: CustomButton(
              color: hsBlack,
              textColor: hsWhite,
              text: 'Create a Account',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SignUpScreen(screenH: widget.screenH),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void getForgotPass(String emailId) async {
    await http.post(
        Uri.parse(ApiUrls.forgotPasswordUrl),
        body: {
          'email_id': emailId,
        }
    ).then((response) {
      print(response.body);
      if(response.statusCode == 200){
        var data = json.decode(response.body);
        var msg = data['message'];
        if (data['status'] == 200) {
          SnackBarMessageShow.successsMSG("$msg", context);
        }
      }
      else{
        if(response.statusCode == 400){
          var data = json.decode(response.body);
          var errorMsg = data['error']['email_id'][0];
          if (data['status'] == 400) {
            SnackBarMessageShow.errorMSG("$errorMsg", context);
          }
        }
      }
    });
  }
}
