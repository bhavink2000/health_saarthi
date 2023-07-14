//@dart=2.9
import 'dart:convert';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Sign%20up%20Screen/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';

class OTPVerify extends StatefulWidget {
  var getOtp,getEmail, enterEmail;
  OTPVerify({Key key,this.getOtp,this.getEmail,this.enterEmail}) : super(key: key);

  @override
  State<OTPVerify> createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  final otpVerify = TextEditingController();
  @override
  Widget build(BuildContext context) {

    print("otp->${widget.getOtp} / email->${widget.getEmail}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
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
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width.w,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: TextField(
                            controller: otpVerify,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(hsPaddingM),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              ),
                              hintText: 'OTP',
                              hintStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontFamily: FontType.MontserratRegular,
                                  fontSize: 14
                              ),
                              prefixIcon: const Icon(Icons.code_rounded, color: hsBlack,size: 20),
                            ),
                          ),
                        )
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async{
                          if (otpVerify.text.isEmpty) {
                            SnackBarMessageShow.warningMSG('Enter OTP', context);
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
                                          'Submitting OTP...', // Loading message
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            await submitOtp();
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(hsPrime),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              TextButton(
                onPressed: (){
                  setState(() {
                    otpVerify.clear();
                  });
                  resendEmail();
                },
                child: Text(
                  "Resend New Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: hsPrimeOne,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> submitOtp() async {
    await http.post(
        Uri.parse(ApiUrls.verifyOtpUrl),
        body: {
          'email_id': widget.enterEmail.toString(),
          'otp': otpVerify.text,
          'provided_email_id': widget.getEmail.toString(),
          'provided_otp': widget.getOtp.toString(),
        }
    ).then((response) {
      var data = json.decode(response.body);
      if(data['status'] == 200){
        SnackBarMessageShow.successsMSG('${data['message']}', context);
        //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignUpScreen(emailId: widget.enterEmail == null ? widget.getEmail : widget.enterEmail,)), (Route<dynamic> route) => false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen(emailId: widget.enterEmail == null ? widget.getEmail : widget.enterEmail)));
      }
      else if(data['status'] == 400){
        SnackBarMessageShow.warningMSG('${data['message']}', context);
      }
      else{
        print("error");
      }
    });
  }

  Future<String> resendEmail() async {
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
                  'Resending email...', // Loading message
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
    final response = await http.post(
      Uri.parse(ApiUrls.reSendOtpUrl),
      body: {
        'email_id': widget.getEmail,
      },
    );
    Navigator.of(context).pop(); // Dismiss the loading dialog

    var data = json.decode(response.body);
    if (data['status'] == 200) {
      SnackBarMessageShow.successsMSG('${data['success']}', context);
      setState(() {
        widget.getOtp = data['otp'];
        widget.getEmail = data['email_id'];
      });
    } else if (data['status'] == 400) {
      var errorMsg = data['error']['email_id'];
      SnackBarMessageShow.warningMSG('$errorMsg', context);
    }
  }
}
