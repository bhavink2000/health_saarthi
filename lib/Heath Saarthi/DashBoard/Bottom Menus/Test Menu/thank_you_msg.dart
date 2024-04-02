import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../App Helper/Backend Helper/bottom_navigation_controller.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/UI Helper/app_icons_helper.dart';
import '../../../App Helper/Getx Helper/user_status_check.dart';
import '../../hs_dashboard.dart';


class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  final controller = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvoked: (value){
        return openExitBox();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50,),
              Image(image: AppIcons.hsLogo,width: 200,),
              const SizedBox(height: 50,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                child: Image(image: AppIcons.thankYou,width: 200,),
              ),
              SizedBox(height: screenHeight * 0.1),
              Text(
                "Thank You!",
                style: TextStyle(
                  color: hsPrimeOne,
                  fontFamily: FontType.MontserratMedium,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Your Booking Confirm",
                style: TextStyle(
                  color: hsPrimeOne,
                  fontFamily: FontType.MontserratRegular,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "You will be redirected to the home page shortly\nor click here to return to home page",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14,
                      letterSpacing: 0.5
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.06),
              Flexible(
                child: InkWell(
                  onTap: (){
                    setState(() {
                      controller.index.value = 0;
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsPrime),
                    child: const Text("Home",style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openExitBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AlertDialog(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              content: Container(
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image(image: AppIcons.hsTransparent,width: 150),
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Are you sure you want to exit.?",
                        style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          child: const Text("Stay",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 2),),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: const Text("Exit",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 2),),
                          onPressed: (){
                            exit(0);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}