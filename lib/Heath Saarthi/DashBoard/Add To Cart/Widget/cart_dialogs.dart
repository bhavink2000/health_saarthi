import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Cart%20Future/cart_future.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';

import '../../../App Helper/Backend Helper/Api Future/Data Future/cart_controller.dart';

class CartDialogs {
  static void removeFromCartDialog(testId) {
    final controller = Get.find<CartController>();
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
                          fontFamily: FontType.MontserratRegular,
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
                              fontFamily: FontType.MontserratRegular,
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
                          CartFuture().removeToCartTest(testId).then((value) {
                            controller.fetchCart(controller.sBranchId.value);
                            controller.cartCalculation();
                          });
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                              fontFamily: FontType.MontserratRegular,
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
