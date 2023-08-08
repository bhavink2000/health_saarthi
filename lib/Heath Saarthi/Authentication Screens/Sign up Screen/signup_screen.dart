import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Sign%20up%20Screen/sign_form.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import 'header_signup.dart';

class SignUpScreen extends StatefulWidget {
  var deviceType, deviceToken;
  SignUpScreen({Key? key,this.deviceType,this.deviceToken}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: hsWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HeaderSignUp(),
              SignUpForm(dType: widget.deviceType,dToken: widget.deviceToken),
            ],
          ),
        ),
      ),
    );
  }
}
