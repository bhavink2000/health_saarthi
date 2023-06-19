//@dart=2.9
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';

class LoadingLogin extends StatelessWidget {
  const LoadingLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/Gif/loading_one.gif",width: 130)),
            const SizedBox(height: 10),
            const Text('Login...',style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18),)
          ],
        ),
      ),
    );
  }
}

class LoadingOnly extends StatelessWidget {
  const LoadingOnly({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/Gif/loading_one.gif",width: 130)),
          const SizedBox(height: 10),
          const Text('Loading...',style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 15),)
        ],
      ),
    );
  }
}

class CenterLoading extends StatelessWidget {
  const CenterLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset("assets/Gif/loading_one.gif",width: 130));
  }
}