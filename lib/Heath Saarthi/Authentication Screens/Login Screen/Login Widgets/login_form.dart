// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Dialog%20Helper/update_app_dialog.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/getx_snackbar_msg.dart';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Login%20Screen/Forgot%20Password/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Sign%20up%20Screen/signup_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App Helper/Backend Helper/Device Info/device_info.dart';
import '../../../App Helper/Backend Helper/Providers/Authentication Provider/authentication_provider.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Loading Helper/loading_indicator.dart';
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

  final mobileNumber = TextEditingController();
  final password = TextEditingController();

  final forgotEmail = TextEditingController();

  bool obScured = true;

  void _togglePasswordView() {
    setState(() {
      obScured = !obScured;
    });
  }
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;


  var appVersion, updateMsg;
  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;
  String? installerStore;
  var deviceToken,deviceType;
  var dType;
  @override
  void initState() {
    super.initState();
    retriveDeviceInfo();
    deviceTokenType();
  }

  void retriveDeviceInfo()async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? deviceType = sp.getString('deviceType');
    dType = deviceType == 'Android' ? 0 : 1;
    print("dType->$dType");
  }


  void deviceTokenType()async{
    await retrieveDeviceToken();
    await retrieveDeviceDetails();
    print("----->>>>> calling without add device token api <<<<<-----");
    await DeviceInfo().sendDeviceToken(context, deviceToken, deviceType, '').then((value) {
      if (value == null) {
        var data = json.decode(value);
        print("before login check value-->${value}");
        print("before login chack value data->${data}");
      } else {
        var data = json.decode(value);
        if (data['status'] == 200) {
          print("----->>>>>");
          print("Before login check device token check status->>${data['status']}");
          print("<<<<<-----");
        } else if (data['status'] == 201) {
          print("<<<<<-----");
          print("before login device status is ->${data['status']}");
          setState(() {
            updateMsg = data['message'];
            appVersion = data['app_version'];
          });
          UpdateAppDialog.showUpdateAppDialog(context, updateMsg, appVersion);
          print("----->>>>>");
        } else {
          var errorMsg = data['error']['device_token'];
          print("Error->$errorMsg");
          Navigator.pop(context);
        }
      }
    });
  }

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
                controller: mobileNumber,
                keyboardType: TextInputType.phone,
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
                  hintText: 'Mobile number',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratMedium,
                  ),
                  prefixIcon: const Icon(
                    Icons.phone_android_rounded,
                    color: Colors.black87,
                  ),
                ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile number';
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
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
                    await prefs.setString('mobile', mobileNumber.text);
                    await prefs.setString('password', password.text);
                    Map data = {
                      "mobile": mobileNumber.text,
                      "password": password.text,
                      "device_token": deviceToken,
                      'device_type': dType.toString(),
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


  Future<void> retrieveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      deviceToken = prefs.getString('deviceToken');
    });
    print("before login DeviceToken->$deviceToken");
  }

  Future retrieveDeviceDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      appName     = packageInfo.appName;
      packageName = packageInfo.packageName;
      version     = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      installerStore = packageInfo.installerStore;
      print('Android Release Version appName->$appName \npackageName->$packageName, \nversion->$version \nbuildNumber->$buildNumber');
      setState(() {
        deviceType = 'Android';
      });
      return deviceType;
    } else if (Platform.isIOS) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      print('IOS Release Version appName->$appName \npackageName->$packageName, \nversion->$version \nbuildNumber->$buildNumber');
      setState(() {
        deviceType = 'iOS';
      });
      return deviceType;
    }
    print('before login Device Type: $deviceType');
  }
}
