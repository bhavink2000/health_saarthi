import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi_getx/Health%20Saarthi/App%20Helper/font_&_color_helper.dart';
import 'package:health_saarthi_getx/Health%20Saarthi/Dashboard/dashboard.dart';

testCartAppbar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      onPressed: () {
        Get.offAll(() => const Dashboard());
      },
      icon: const Icon(Icons.arrow_back),
    ),
    actions: const [
      Text(
        "Cart items",
        style: TextStyle(
            fontFamily: FontHelper.montserratMedium,
            fontSize: 18,
            letterSpacing: 0.5),
      ),
      SizedBox(
        width: 10,
      )
    ],
  );
}
