import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi_getx/Health%20Saarthi/Dashboard/Add%20To%20Cart/Test%20Cart/Controller/test_cart_controller.dart';

import '../../../../App Helper/Widget Helper/Common Location Picker/common_location_picker.dart';
import '../../../../App Helper/font_&_color_helper.dart';

class SelectLocationType extends StatelessWidget {
  const SelectLocationType({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TestCartController>();
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
                            fontFamily: FontHelper.montserratMedium,
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
                            fontFamily: FontHelper.montserratMedium,
                            fontSize: 12,
                            color: Colors.black)),
                    value: 'dLocation',
                    groupValue: controller.selectLocation.value,
                    onChanged: (value) {
                      controller.locationController.fetchState();
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
                    style: TextStyle(fontFamily: FontHelper.montserratMedium)),
                childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  const CommonLocationPicker(),
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
                          color: ColorHelper.hsPrime,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        'Set location',
                        style: TextStyle(
                            fontFamily: FontHelper.montserratMedium,
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
