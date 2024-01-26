// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Login%20Screen/Forgot%20Password/forgot_password_update.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';

class OTPVerifyScreen extends StatefulWidget {
  var mobileNumber;
  OTPVerifyScreen({Key? key,this.mobileNumber}) : super(key: key);

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {

  final otpVerify = TextEditingController();

  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: SingleChildScrollView(
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
                SizedBox(height: 18,),
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
                SizedBox(height: 24,),
                Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Enter your OTP code number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 28,),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                                hintText: '${widget.mobileNumber}',
                                hintStyle: const TextStyle(
                                    color: Colors.black54,
                                    fontFamily: FontType.MontserratRegular,
                                    fontSize: 14
                                ),
                                prefixIcon: const Icon(Icons.phone_android_rounded, color: hsBlack,size: 20),
                              ),
                            ),
                          )
                      ),
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
                      SizedBox(height: 15,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async{
                            if (otpVerify.text.isEmpty) {
                              GetXSnackBarMsg.getWarningMsg('${AppTextHelper().enterOTP}');
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
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Time remaining $secondsRemaining sec",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                    enableResend ? resendOTP() : GetXSnackBarMsg.getWarningMsg('${AppTextHelper().resendOTP}');
                  },
                  child: Text(
                    "Resend New Code",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: enableResend ? hsPrimeOne : Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  dispose(){
    timer!.cancel();
    super.dispose();
  }
  Future<String?> submitOtp() async {
    await http.post(
        Uri.parse(ApiUrls.verifyOtpUrl),
        body: {
          'mobile': widget.mobileNumber.toString(),
          'otp': otpVerify.text,
        }
    ).then((response) {
      var data = json.decode(response.body);
      if(data['status'] == 200){
        GetXSnackBarMsg.getSuccessMsg('${data['message']}');
        //SnackBarMessageShow.successsMSG('${data['message']}', context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ForgotPasswordUpdate(
          mobileNo: widget.mobileNumber,
        )));
      }
      else if(data['status'] == 400){
        print("in else if");
        GetXSnackBarMsg.getWarningMsg('${data['message']}');
        Navigator.pop(context);
      }
      else{
        print("error");
      }
    });
  }
  void _resendCode() {
    setState((){
      secondsRemaining = 30;
      enableResend = false;
    });
  }
  Future<String?> resendOTP() async {
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
                  'Resending OTP...', // Loading message
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
        'mobile': widget.mobileNumber,
      },
    );
    Navigator.of(context).pop();
    var data = json.decode(response.body);
    if (data['status'] == 200) {
      GetXSnackBarMsg.getSuccessMsg('${data['message']}');
      _resendCode();
    } else if (data['status'] == 400) {
      var errorMsg = data['error']['mobile'][0];
      GetXSnackBarMsg.getWarningMsg('$errorMsg');
    }
  }
}
