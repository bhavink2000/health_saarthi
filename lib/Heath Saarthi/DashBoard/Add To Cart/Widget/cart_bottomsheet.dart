import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi_getx/Health%20Saarthi/App%20Helper/snakebar_helper.dart';
import 'package:health_saarthi_getx/Health%20Saarthi/Dashboard/Add%20To%20Cart/Test%20Cart/Controller/test_cart_controller.dart';

import '../../../../App Helper/app_text_helper.dart';
import '../../../../App Helper/font_&_color_helper.dart';

testCartBottomsheet() {
  final controller = Get.find<TestCartController>();
  return Container(
    width: Get.width,
    height: Get.height / 3.8,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(0), topLeft: Radius.circular(0)),
      color: ColorHelper.hsPrime,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: Row(
            children: [
              const Text(
                "Gross amount",
                style: TextStyle(
                    fontFamily: FontHelper.montserratLight,
                    fontSize: 14,
                    color: Colors.white),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.centerRight,
                width: Get.width / 3,
                height: Get.height / 25,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Text(
                    "\u{20B9}${controller.grossAmount.value.isEmpty ? 0 : controller.grossAmount.value}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: FontHelper.montserratRegular,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        Container(
          width: Get.width,
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: Row(
            children: [
              const Text(
                "Total discount",
                style: TextStyle(
                    fontFamily: FontHelper.montserratLight,
                    fontSize: 14,
                    color: Colors.white),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.centerRight,
                width: Get.width / 3,
                height: Get.height / 25,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Text(controller.totalAmount.value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: FontHelper.montserratRegular,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        Container(
          width: Get.width,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 5),
          alignment: Alignment.topLeft,
          child: controller.callPromo.value == true
              ? Row(
                  children: [
                    SizedBox(
                      width: Get.width / 1.5,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                          child: controller.isApplyPromo == 0
                              ? const Text("Invalid promo code",
                                  style: TextStyle(
                                      fontFamily: FontHelper.montserratRegular,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange))
                              : Row(
                                  children: [
                                    const Text("Promo offer applied",
                                        style: TextStyle(
                                            fontFamily:
                                                FontHelper.montserratRegular,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange)),
                                    const Spacer(),
                                    Text(
                                      "\u{20B9}${controller.applyPromo}",
                                      style: const TextStyle(
                                          fontFamily:
                                              FontHelper.montserratMedium),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        controller.promoApply.clear();
                        // _showLoadingDialog();
                        controller.cartCalculation().then((_) {
                          controller.callPromo.value = false;
                          // Navigator.of(context).pop(); // Hide the loading dialog
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontFamily: FontHelper.montserratRegular,
                            color: ColorHelper.hsPrime),
                      ),
                    )
                  ],
                )
              : Row(
                  children: [
                    SizedBox(
                      width: Get.width / 1.5,
                      height: Get.height / 20,
                      child: TextField(
                        controller: controller.promoApply,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: FontHelper.montserratMedium),
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Coupon code',
                          hintStyle: const TextStyle(
                              color: Colors.white,
                              fontFamily: FontHelper.montserratMedium,
                              fontSize: 14),
                          //prefixIcon: Icon(iconData, color: hsBlack,size: 20),
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (controller.promoApply.text.isEmpty) {
                          SnackBarHelper.getWarningMsg(
                              AppTextHelper.couponCode);
                        } else {
                          // _showLoadingDialog();
                          controller.cartCalculation().then((_) {
                            // setState(() {
                            controller.callPromo.value = true;
                            // });
                            // Navigator.of(context).pop();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        "Apply",
                        style: TextStyle(
                            fontFamily: FontHelper.montserratRegular,
                            color: ColorHelper.hsPrime),
                      ),
                    )
                  ],
                ),
        ),
        const Spacer(),
        Container(
          width: Get.width,
          height: Get.height / 14,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0), color: Colors.white),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                child: Row(
                  children: [
                    const Text(
                      "Payable :-",
                      style: TextStyle(
                          fontFamily: FontHelper.montserratMedium,
                          color: Colors.orange,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "\u{20B9}${controller.netAmount.value.isEmpty ? 0.00 : controller.netAmount.value}",
                      style: const TextStyle(
                          fontFamily: FontHelper.montserratMedium,
                          color: Colors.orange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 10, 0),
                child: InkWell(
                  onTap: () {
                    if (controller.userStatus == 0) {
                      SnackBarHelper.getWarningMsg(AppTextHelper.inAccount);
                    } else if (controller.userStatus == 1) {
                      if (controller.bodyMsg == 'There is no item in cart.') {
                        SnackBarHelper.getWarningMsg(AppTextHelper.cartEmpty);
                      } else {
                        if (controller.selectLocation.value == '') {
                          SnackBarHelper.getWarningMsg(
                              AppTextHelper.selectLocation);
                        } else {
                          if (controller.setLocation.value == false) {
                            SnackBarHelper.getWarningMsg(
                                AppTextHelper.setLocation);
                          } else {
                            log("branch->>${controller.locationController.selectedBranch}/${controller.sBranchName}/${controller.locationController.selectedBranch}");
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             TestBookingScreen(
                            //               testDis: testD,
                            //               packageDis: packageD,
                            //               profileDis: profileD,
                            //               promoApply: promoApply.text,
                            //               dStateId: selectLocation ==
                            //                   'cLocation'
                            //                   ? sStateId
                            //                   : selectedStateId,
                            //               dStateNm: selectLocation ==
                            //                   'cLocation'
                            //                   ? sStateName
                            //                   : selectedState,
                            //               dCityId: selectLocation ==
                            //                   'cLocation'
                            //                   ? sCityId
                            //                   : selectedCityId,
                            //               dCityNm: selectLocation ==
                            //                   'cLocation'
                            //                   ? sCityName
                            //                   : selectedCity,
                            //               dAreaId: selectLocation ==
                            //                   'cLocation'
                            //                   ? sAreaId
                            //                   : selectedAreaId,
                            //               dAreaNm: selectLocation ==
                            //                   'cLocation'
                            //                   ? sAreaName
                            //                   : selectedArea,
                            //               dBranchId: selectLocation ==
                            //                   'cLocation'
                            //                   ? sBranchId
                            //                   : selectedBranchId,
                            //               dBranchNm: selectLocation ==
                            //                   'cLocation'
                            //                   ? sBranchName
                            //                   : selectedBranch,
                            //             )));
                          }
                        }
                      }
                    } else {
                      SnackBarHelper.getWarningMsg(AppTextHelper.userNotFound);
                    }
                  },
                  child: Card(
                    elevation: controller.userStatus == 0 ? 0 : 5,
                    shadowColor: controller.userStatus == 0
                        ? Colors.white
                        : Colors.green.withOpacity(0.5),
                    child: Container(
                        width: Get.width / 2.9,
                        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: controller.userStatus == 0
                                ? Colors.orange.withOpacity(0.5)
                                : Colors.orange),
                        child: const Row(
                          children: [
                            Text(
                              "Book now",
                              style: TextStyle(
                                  fontFamily: FontHelper.montserratMedium,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 12,
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
