import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi_getx/Health%20Saarthi/App%20Helper/Netwok%20Helper/Cart%20Data%20Helper/cart_data_helper.dart';
import 'package:health_saarthi_getx/Health%20Saarthi/Dashboard/Add%20To%20Cart/Test%20Cart/Controller/test_cart_controller.dart';

import '../../../../App Helper/font_&_color_helper.dart';

class CartDialogs {
  static void removeFromCartDialog(testId) {
    final controller = Get.find<TestCartController>();
    Get.dialog(
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            content: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset("assets/health_saarthi_logo_transparent_bg.png",
                      width: 150),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Are you sure would like to\n delete test item?",
                      style: TextStyle(
                          fontFamily: FontHelper.montserratRegular,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        onPressed: () => Get.back(),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontFamily: FontHelper.montserratRegular,
                              letterSpacing: 2),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        onPressed: () {
                          // CartFuture().removeToCartTest(getAccessToken.access_token, cartI.testItemInfo!.id, context).then((value) async {
                          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TestCart()));
                          // });
                          CartDataHelper.removeToCartTest(testId).then((value) {
                            controller.fetchCart(controller.sBranchId.value);
                            controller.cartCalculation();
                          });
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                              fontFamily: FontHelper.montserratRegular,
                              letterSpacing: 2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false);
  }
}
