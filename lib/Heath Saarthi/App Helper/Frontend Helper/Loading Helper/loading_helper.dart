import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';


class LoadingOnly extends StatelessWidget {
  const LoadingOnly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/Gif/loader.gif",width: 70,color: hsPrime)),
          const SizedBox(height: 10),
          const Text('Loading...',style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 15),)
        ],
      ),
    );
  }
}

class CenterLoading extends StatelessWidget {
  const CenterLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset("assets/Gif/loader.gif",width: 70,color: hsPrime));
  }
}