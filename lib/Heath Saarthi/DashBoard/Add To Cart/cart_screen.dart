import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Data%20Future/data_future.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Packages%20List/package_items_getx.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Test%20List/test_item_getx.dart';

import '../../App Helper/Backend Helper/Api Future/Data Future/cart_controller.dart';
import '../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';
import 'Widget/cart_bottomsheet.dart';
import 'Widget/cart_product_list_widgets.dart';
import 'Widget/select_location_type.dart';
import 'Widget/test_cart_appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    //final controller = Get.find<CartController>();
    final homeController = Get.find<DataFuture>();
    return PopScope(
      canPop: true,
      onPopInvoked: (val) {
        homeController.fetchPopularPackages();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: testCartAppbar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SelectLocationType(),
              Obx(() => controller.cartLoading.value
                  ? Column(
                children: [
                  SizedBox(
                    height: Get.height / 4,
                  ),
                  const CenterLoading(),
                ],
              )
                  : SizedBox(
                width: Get.width,
                child: Column(
                  children: [
                    controller.cartModel
                        .value.data!.cartItems!.testItems!.isEmpty &&
                        controller.cartModel.value.data!.cartItems!
                            .packageItems!.isEmpty &&
                        controller.cartModel.value.data!.cartItems!
                            .profileItems!.isEmpty
                        ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height / 4,
                            ),
                            const Text("Cart is empty",
                                style: TextStyle(
                                    fontFamily:
                                    FontType.MontserratMedium,
                                    fontSize: 16),
                                textAlign: TextAlign.center),
                          ],
                        ))
                        : SizedBox(
                      width: Get.width,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(
                            0, 0, 0, Get.height / 4),
                        child: Column(
                          children: [
                            Obx(() => controller.cartModel.value.data!.cartItems!.testItems!.isNotEmpty
                                ? CartItemWidget(
                              cartItem: controller.cartModel.value.data?.cartItems?.testItems,
                              scrollController: controller.testScrollController,
                              cartItemLabel: 'Tests',
                              addOnPressed: () {
                                Get.off(() =>
                                const TestDataNew());
                              },
                              globalSettingItemSlot: controller.cartModel.value.data?.globalSettingTestSlot,
                              itemDiscount: 'Test discount',
                              dropdownValue:
                              controller.testD.value,
                              dropdownOnChange: (newValue) {
                                controller.testD.value =
                                newValue!;
                                controller.cartCalculation();
                              },
                            )
                                : Container()),
                            //profile
                            const SizedBox(height: 10),
                            Obx(
                                  () => controller.cartModel.value.data!.cartItems!.profileItems!.isNotEmpty
                                  ? CartItemWidget(
                                cartItem: controller.cartModel.value.data?.cartItems?.profileItems,
                                scrollController: controller.profileScrollController,
                                cartItemLabel: 'Profile',
                                addOnPressed: () {
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TestListItems()));
                                },
                                globalSettingItemSlot: controller.cartModel.value.data?.globalSettingProfileSlot,
                                itemDiscount:
                                'Profile discount',
                                dropdownValue:
                                controller.profileD.value,
                                dropdownOnChange: (newValue) {
                                  controller.profileD.value = newValue!;controller.cartCalculation();
                                },
                              ) : Container(),
                            ),
                            //package
                            const SizedBox(height: 10),
                            Obx(
                                  () => controller.cartModel.value.data!.cartItems!.packageItems!.isNotEmpty ? CartItemWidget(
                                cartItem: controller.cartModel.value.data?.cartItems?.packageItems,
                                scrollController: controller.packageScrollController,
                                cartItemLabel: 'Package',
                                addOnPressed: () {
                                  Get.off(() =>
                                  const PackageDataNew());
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TestListItems()));
                                },
                                globalSettingItemSlot: controller.cartModel.value.data?.globalSettingPackageSlot,
                                itemDiscount:
                                'Package discount',
                                dropdownValue:
                                controller.packageD.value,
                                dropdownOnChange: (newValue) {
                                  controller.packageD.value = newValue!;controller.cartCalculation();
                                },
                              ) : Container(),
                            ),
                            Obx(
                                  () => controller.cartModel.value.data!.cartItems!.testItems!.isNotEmpty ? Container()
                                  : Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: CommonAddItemsWidget(
                                    label: 'Test',
                                    onTap: () {
                                      Get.off(() =>
                                      const TestDataNew());
                                    }),
                              ),
                            ),
                            Obx(
                                  () => controller.cartModel.value.data!.cartItems!.profileItems!.isNotEmpty
                                  ? Container()
                                  : Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: CommonAddItemsWidget(
                                    label: 'Profile',
                                    onTap: () {}),
                              ),
                            ),
                            Obx(
                                  () => controller.cartModel.value.data!.cartItems!.packageItems!.isNotEmpty
                                  ? Container()
                                  : Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: CommonAddItemsWidget(
                                    label: 'Package',
                                    onTap: () {
                                      Get.off(() =>
                                      const PackageDataNew());
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 50)
            ],
          ),
        ),
        bottomSheet: Obx(() => testCartBottomsheet()),
      ),
    );
  }
}
