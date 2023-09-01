//@dart=2.9
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import 'otp_verify_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final otpText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
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
                'Forgot password',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your mobile number. we'll send you a verification code.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: otpText,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter mobile no',
                        hintStyle: TextStyle(fontSize: 16)
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (otpText.text.isEmpty) {
                            GetXSnackBarMsg.getWarningMsg('${AppTextHelper().enterMobileNo}');
                          } else {
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
                                          'Sending otp...', // Loading message
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            await verifyMobileNumber();
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
                            'Send',
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
    );
  }
  bool mobileLoading = true;
  Future<void> verifyMobileNumber() async {
    setState(() {
      mobileLoading = true;
    });
    final response = await http.post(
      Uri.parse(ApiUrls.sendOtpUrl),
      body: {
        'mobile': otpText.text,
      },
    );
    var data = json.decode(response.body);
    if (data['status'] == 200) {
      GetXSnackBarMsg.getWarningMsg('${data['message']}');
      //SnackBarMessageShow.successsMSG('${data['message']}', context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OTPVerifyScreen(
            mobileNumber: otpText.text,
          ),
        ),
      );
    } else if (data['status'] == 400) {
      var errorMsg = data['error']['mobile'][0];
      GetXSnackBarMsg.getWarningMsg('${errorMsg}');
      Navigator.pop(context);
      setState(() {
        mobileLoading = false;
      });
    }
  }
}
