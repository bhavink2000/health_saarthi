import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/hs_dashboard.dart';


testCartAppbar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      onPressed: () {
        Get.offAll(() => const Home());
      },
      icon: const Icon(Icons.arrow_back),
    ),
    actions: const [
      Text(
        "Cart items",
        style: TextStyle(
            fontFamily: FontType.MontserratMedium,
            fontSize: 18,
            letterSpacing: 0.5),
      ),
      SizedBox(
        width: 10,
      )
    ],
  );
}
