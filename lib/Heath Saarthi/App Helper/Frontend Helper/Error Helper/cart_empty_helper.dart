//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Font & Color Helper/font_&_color_helper.dart';

class CartEmptyHelper extends StatefulWidget {
  const CartEmptyHelper({Key key}) : super(key: key);

  @override
  State<CartEmptyHelper> createState() => _CartEmptyHelperState();
}

class _CartEmptyHelperState extends State<CartEmptyHelper> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /*Container(
          width: MediaQuery.of(context).size.width / 2.w,
          height: MediaQuery.of(context).size.height / 8.h,
          child: const Image(
            image: AssetImage("assets/Gif/cart_empty.gif"),
            fit: BoxFit.contain,
          ),
        ),*/
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(
            "No Items Available, \nSo You Need To Shopping.",
            style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsOne,fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
