import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/UI%20Helper/app_icons_helper.dart';


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
          Center(child: Image(image: AppIcons.loader,width: 70,color: hsPrime,)),
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
    return Center(child: Image(image: AppIcons.loader,width: 70,color: hsPrime,));
  }
}


class BookingLoading extends StatelessWidget {
  const BookingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white
        ),
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(strokeWidth: 2,),
            SizedBox(height: 10),
            DefaultTextStyle(
                style: TextStyle(fontFamily: FontType.MontserratLight,fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),
                child: Text('Loading....')
            )
          ],
        ),
      ),
    );
  }
}
