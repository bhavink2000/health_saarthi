// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Splash%20Screen/splash_screen.dart';

import '../../../App Helper/Backend Helper/Api Repo/User Authentication/user_authentication.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../../App Helper/Frontend Helper/Text Helper/test_helper.dart';

class ForgotPasswordUpdate extends StatefulWidget {
  var mobileNo;
  ForgotPasswordUpdate({Key? key,this.mobileNo}) : super(key: key);

  @override
  State<ForgotPasswordUpdate> createState() => _ForgotPasswordUpdateState();
}

class _ForgotPasswordUpdateState extends State<ForgotPasswordUpdate> {

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
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/Gif/otp_verify.gif',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(hsPaddingM),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                          ),
                          hintText: '${widget.mobileNo}',
                          hintStyle: const TextStyle(
                              color: Colors.black54,
                              fontFamily: FontType.MontserratRegular,
                              fontSize: 14
                          ),
                          prefixIcon: const Icon(Icons.phone_android_rounded, color: hsBlack,size: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
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
                          hintText: 'Password *',
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
                            return 'Enter a password';
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
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
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
                          hintText: 'Confirm password *',
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
                            return 'Enter a password';
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
                          if (value != password.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (password.text.isEmpty) {
                              GetXSnackBarMsg.getWarningMsg('${AppTextHelper().enterPassword}');
                            } else {
                              if(cPassword.text.isEmpty){
                                GetXSnackBarMsg.getWarningMsg('${AppTextHelper().enterCPassword}');
                              }
                              else{
                                if(password.text == cPassword.text){
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              CircularProgressIndicator(), // Loading indicator
                                              SizedBox(height: 16),
                                              Text(
                                                'Updating password...', // Loading message
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  try {
                                    var responseMessage = await UserAuthentication().getForgotPass(widget.mobileNo,password.text,cPassword.text, context);
                                    if(responseMessage == 200){
                                      print('responseMessage->$responseMessage');
                                      password.text = '';
                                      cPassword.text = '';
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                                    }
                                    else{
                                      print("in else");
                                      Navigator.pop(context);
                                    }
                                  } catch (error) {
                                    Navigator.pop(context);
                                  }
                                }
                                else{
                                  GetXSnackBarMsg.getWarningMsg('${AppTextHelper().enterCPNotMatch}');
                                }
                              }
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(hsPrime),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
