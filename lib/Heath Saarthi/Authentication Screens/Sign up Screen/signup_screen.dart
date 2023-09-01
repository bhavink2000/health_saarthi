
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Sign%20up%20Screen/sign_form.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';
import 'header_signup.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? hsSpaceM : hsSpaceS;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: hsWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HeaderSignUp(),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
