import 'package:flutter/material.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50,),
            const Image(image: AssetImage("assets/health_saarthi_logo.png"),width: 200,),
            const SizedBox(height: 50,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              child: const Image(image: AssetImage("assets/Gif/thank_you.gif"),width: 200,),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
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
    );
  }
}