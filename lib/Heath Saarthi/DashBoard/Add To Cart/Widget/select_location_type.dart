import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';

import '../../../App Helper/Backend Helper/Api Future/Data Future/cart_controller.dart';
import '../../../App Helper/Backend Helper/Api Future/Location Future/location_widget.dart';


class SelectLocationType extends StatelessWidget {
  const SelectLocationType({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    return Column(
      children: [
        Container(
          width: Get.width,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Obx(
            () => Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: RadioListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Current location',
                        style: TextStyle(
                            fontFamily: FontType.MontserratMedium,
                            fontSize: 12,
                            color: Colors.black)),
                    value: 'cLocation',
                    groupValue: controller.selectLocation.value,
                    onChanged: (value) {
                      controller
                          .fetchCart(controller.sBranchId.value)
                          .then((value) {
                        controller.cartCalculation();
                      });
                      controller.selectLocation.value = value!;
                      controller.showDLocation.value = false;
                      controller.locationController.stateList.clear();
                      controller.locationController.selectedState.value = '';
                      controller.locationController.cityList.clear();
                      controller.locationController.selectedCity.value = '';
                      controller.locationController.areaList.clear();
                      controller.locationController.selectedArea.value = '';
                      controller.locationController.branchList.clear();
                      controller.locationController.selectedBranch.value = '';
                      controller.setLocation.value = true;
                    },
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: RadioListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Different location',
                        style: TextStyle(
                            fontFamily: FontType.MontserratMedium,
                            fontSize: 12,
                            color: Colors.black)),
                    value: 'dLocation',
                    groupValue: controller.selectLocation.value,
                    onChanged: (value) {
                      controller.locationController.fetchStateList();
                      controller.setLocation.value = false;
                      controller.selectLocation.value = value!;
                      controller.showDLocation.value = true;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.showDLocation.value,
            child: Form(
              key: controller.locationFormKey,
              child: ExpansionTile(
                initiallyExpanded: true,
                title: const Text('Choose location',
                    style: TextStyle(fontFamily: FontType.MontserratMedium)),
                childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  const LocationPicker(),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      if (controller.locationFormKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        controller.showDLocation.value = false;
                        controller.setLocation.value = true;
                        controller
                            .fetchCart(
                                controller.locationController.selectedBranchId)
                            .then((value) {
                          controller.cartCalculation();
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                          color: hsPrime,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        'Set location',
                        style: TextStyle(
                            fontFamily: FontType.MontserratMedium,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
