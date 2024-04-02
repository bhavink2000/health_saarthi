
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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



class SignUpTextField extends StatelessWidget {

  TextEditingController? tController;
  TextInputType? textInputType;
  TextCapitalization? textCapitalization;
  List<TextInputFormatter>? inputFormatters;
  String? tName,tSign;
  IconData? tIcon;
  int? maxLine,minLine,maxLength;
  final String? Function(String?)? validator;
  SignUpTextField({super.key, this.validator,this.tController,this.tName,this.tSign,this.tIcon,this.textInputType,this.inputFormatters,this.maxLine,this.minLine,this.maxLength,this.textCapitalization});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: TextFormField(
        controller: tController,
        maxLines: maxLine,
        minLines: minLine,
        maxLength: maxLength,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: textInputType,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(hsPaddingM),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
          ),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$tName"),
              Text(" $tSign", style: TextStyle(color: Colors.red)),
            ],
          ),
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontFamily: FontType.MontserratRegular,
            fontSize: 14,
          ),
          prefixIcon: Icon(tIcon, color: hsBlack, size: 20),
        ),
        validator: validator, // Set the validator function
      ),
    );
  }
}
