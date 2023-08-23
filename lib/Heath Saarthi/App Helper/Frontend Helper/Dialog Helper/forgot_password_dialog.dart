import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Backend Helper/Api Repo/User Authentication/user_authentication.dart';
import '../Font & Color Helper/font_&_color_helper.dart';

/*
class ForgotPasswordDialog{
  static bool isLoading = false;
  static var forgotEmail = TextEditingController();
  static void forgotPasswordDialogBox(BuildContext context,var forgotPasswordKey){
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
                      key: forgotPasswordKey,
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
                                    if (forgotPasswordKey.currentState!.validate()) {
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
                                        String? responseMessage = await UserAuthentication().getForgotPass(forgotEmail.text, context);
                                        setState(() {
                                          isLoading = false;
                                        });
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
                                        Navigator.pop(context);
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
  }
}*/
