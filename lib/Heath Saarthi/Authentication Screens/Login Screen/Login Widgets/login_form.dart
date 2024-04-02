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
import '../../../App Helper/Backend Helper/Api Repo/User Authentication/user_authentication.dart';
import '../../../App Helper/Backend Helper/Device Info/device_info.dart';
import '../../../App Helper/Backend Helper/Providers/Authentication Provider/authentication_provider.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Loading Helper/loading_indicator.dart';
import '../../../App Helper/Getx Helper/Auth Getx/login_auth_getx.dart';
import 'fade_slide_transition.dart';

class LoginForm extends StatefulWidget {
  final Animation<double> animation;
  var screenH;
  LoginForm({Key? key,this.screenH,
    required this.animation
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {


  final controller = Get.find<LoginController>();


  //final mobileNumber = TextEditingController();
  //final password = TextEditingController();

  // bool obScured = true;
  // void _togglePasswordView() {
  //   setState(() {
  //     obScured = !obScured;
  //   });
  // }
  // final _formKey = GlobalKey<FormState>();

   var appVersion, updateMsg;
  // String? appName;
  // String? packageName;
  // String? version;
  // String? buildNumber;
  // String? installerStore;
  // var deviceToken,deviceType;
  // var dType;
  @override
  void initState() {
    super.initState();
    deviceTokenType();
  }

  void deviceTokenType()async{
    print("----->>>>> calling without add device token api <<<<<-----");
    await DeviceInfo().sendDeviceToken(context).then((value) {
      if (value == null) {
        var data = json.decode(value);

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
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? hsSpaceM : hsSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: hsPaddingL),
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: 0.0,
              child: TextFormField(
                controller: controller.mobileNumber,
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
              child: Obx(
                    () => TextFormField(
                  controller: controller.password,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: controller.obScured.value,
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.all(hsPaddingM),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                        color: Colors.black54,
                        fontFamily: FontType.MontserratMedium),
                    prefixIcon: const Icon(Icons.lock_open_rounded,
                        color: Colors.black87),
                    suffixIcon: InkWell(
                      onTap: controller.togglePasswordView,
                      child: Icon(
                        controller.obScured.value
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
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
                  if (controller.loginFormKey.currentState!.validate()) {
                    controller.getLogin();
                  }
                },
                child: Obx(()=>Container(
                  height: Get.height / 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: hsPrime),
                  child: controller.loginLoading.value ? CircularProgressIndicator(color: Colors.white,strokeWidth: 2,) : Text("Login to continue",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                )),
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
                  height: Get.height / 20,
                  alignment: Alignment.center,
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
}
