import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi_getx/Health%20Saarthi/App%20Helper/Netwok%20Helper/Cart%20Data%20Helper/cart_data_helper.dart';

import '../../../../App Helper/Model Helper/Cart Menu/cart_model.dart';
import '../../../../App Helper/font_&_color_helper.dart';
import '../Controller/test_cart_controller.dart';

//ignore: must_be_immutable
class CartItemWidget extends StatelessWidget {
  String? cartItemLabel, itemDiscount, dropdownValue;
  final VoidCallback? addOnPressed;
  final ScrollController? scrollController;
  final Function(String?)? dropdownOnChange;
  List<Item>? cartItem;
  List<GlobalSettingSlot>? globalSettingItemSlot;
  CartItemWidget({
    super.key,
    this.cartItemLabel,
    this.itemDiscount,
    this.addOnPressed,
    this.dropdownOnChange,
    this.cartItem,
    this.globalSettingItemSlot,
    this.dropdownValue,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TestCartController>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorHelper.hsPrime.withOpacity(0.1)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 10, 0),
              child: Row(
                children: [
                  //Container(width: 2, height: 18,color: hsTwo,),
                  //const SizedBox(width: 5),
                  Text(
                    "$cartItemLabel",
                    style: const TextStyle(
                        fontFamily: FontHelper.montserratMedium,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: addOnPressed,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorHelper.hsPrime.withOpacity(0.8)),
                      child: const Text(
                        "+ Add",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: FontHelper.montserratMedium,
                            fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.5),
            ),
            SizedBox(
              width: Get.width,
              height: cartItem!.length == 1 ? 50 : 120,
              child: cartItem!.isNotEmpty
                  ? Scrollbar(
                      //thumbVisibility: true,
                      thickness: 5,
                      controller: scrollController,
                      radius: const Radius.circular(50),
                      child: ListView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: cartItem?.length,
                        itemBuilder: (context, pIndex) {
                          var cartI = cartItem?[pIndex].testItemInfo;
                          var cartP = cartItem?[pIndex].packageItemInfo;
                          var cartPr = cartItem?[pIndex].profileItemInfo;
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Get.width / 1.9,
                                      child: Text(
                                          cartItemLabel == 'Tests'
                                              ? "${cartI?.serviceName}"
                                              : cartItemLabel == 'Package'
                                                  ? "${cartP?.serviceName}"
                                                  : "${cartPr?.serviceName}",
                                          style: const TextStyle(
                                              fontFamily:
                                                  FontHelper.montserratLight,
                                              fontSize: 13)),
                                    ),
                                    Text(
                                        "\u{20B9}${cartItemLabel == 'Tests' ? "${cartI?.mrpAmount}" : cartItemLabel == 'Package' ? "${cartP?.mrpAmount}" : "${cartPr?.mrpAmount}"}",
                                        style: const TextStyle(
                                            fontFamily:
                                                FontHelper.montserratLight,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 3, sigmaY: 3),
                                                child: AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      32.0))),
                                                  content: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Image.asset(
                                                            "assets/health_saarthi_logo_transparent_bg.png",
                                                            width: 150),
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(10, 10,
                                                                  10, 10),
                                                          child: Text(
                                                            "Are you sure would like to delete package item?",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    FontHelper
                                                                        .montserratRegular,
                                                                fontSize: 12),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            TextButton(
                                                              child: const Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        FontHelper
                                                                            .montserratRegular,
                                                                    letterSpacing:
                                                                        2),
                                                              ),
                                                              onPressed: () =>
                                                                  Get.back(),
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        FontHelper
                                                                            .montserratRegular,
                                                                    letterSpacing:
                                                                        2),
                                                              ),
                                                              onPressed: () {
                                                                CartDataHelper.removeToCartTest(cartItemLabel ==
                                                                            'Tests'
                                                                        ? cartI
                                                                            ?.id
                                                                        : cartItemLabel ==
                                                                                'Package'
                                                                            ? cartP
                                                                                ?.id
                                                                            : cartPr
                                                                                ?.id)
                                                                    .then(
                                                                        (value) {
                                                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                                                                  controller.fetchCart(
                                                                      controller
                                                                          .sBranchId
                                                                          .value);
                                                                  controller
                                                                      .cartCalculation();
                                                                  log(controller
                                                                      .netAmount
                                                                      .value);
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: SizedBox(
                                        width: Get.width / 6,
                                        child: Icon(
                                            Icons.delete_forever_rounded,
                                            color: ColorHelper.hsPrime,
                                            size: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.white,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text(
                          'No Items Available, \nSo You Need To Shopping.'),
                    ),
            ),
            const SizedBox(height: 5),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: ColorHelper.hsPrime.withOpacity(0.8),
              ),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [
                  Text(
                    "$itemDiscount",
                    style: const TextStyle(
                        fontFamily: FontHelper.montserratMedium,
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Container(
                      width: Get.width / 3,
                      height: Get.height / 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: DropdownButtonFormField<String>(
                        value: dropdownValue,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: FontHelper.montserratMedium),
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Discount',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: FontHelper.montserratRegular,
                            fontSize: 12,
                          ),
                        ),
                        onChanged: dropdownOnChange,
                        items: [
                          const DropdownMenuItem(
                            value: '',
                            child: Text("Discount"),
                          ),
                          ...globalSettingItemSlot
                                  ?.map((itemDrop) => DropdownMenuItem<String>(
                                        value: itemDrop.id.toString(),
                                        child: Text("${itemDrop.slotValue}%"),
                                      ))
                                  .toList() ??
                              []
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonAddItemsWidget extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const CommonAddItemsWidget(
      {super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: ColorHelper.hsPrime.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Add $label",
              style: const TextStyle(
                fontFamily: FontHelper.montserratMedium,
                fontSize: 15,
              )),
          InkWell(
            onTap: onTap,
            child: Container(
              width: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorHelper.hsPrime.withOpacity(0.8)),
              child: Text(
                "+ $label",
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: FontHelper.montserratMedium,
                    fontSize: 14),
              ),
            ),
          )
        ],
      ),
    );
  }
}
