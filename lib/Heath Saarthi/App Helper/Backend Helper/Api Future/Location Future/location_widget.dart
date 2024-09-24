import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Getx%20Helper/location_getx.dart';

import '../../../Frontend Helper/DropDown Helper/common_dropdown_search.dart';
import 'location_controller.dart';

class LocationPicker extends StatelessWidget {
  const LocationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocationCall());
    return Column(
      children: [
        Obx(() => CommonDropdownSearch(
            suffixIcon: controller.stateLoading.value
                ? Container(
              height: 15,
              width: 15,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
                : null,
            items: controller.stateList.where((state) => state!.stateName != null).map((state) => state!.stateName!).toList(),
            label: 'Select state',
            onChanged: (value) => controller.onChangedState(value),
            selectedItem: controller.selectedState.value == '' ? null : controller.selectedState.value,
            isRequiredField: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select a state';
              }
              return null;
            },
          ),
        ),
        Obx(() => CommonDropdownSearch(
            suffixIcon: controller.cityLoading.value
                ? Container(
              height: 15,
              width: 15,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
                : null,
            items: controller.cityList.where((city) => city!.cityName != null).map((city) => city!.cityName!).toList(),
            label: 'Select city',
            onChanged: (value) => controller.onChangedCity(value),
            selectedItem: controller.selectedCity.value == '' ? null : controller.selectedCity.value,
            isRequiredField: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select a city';
              }
              return null;
            },
          ),
        ),
        Obx(() => CommonDropdownSearch(
            suffixIcon: controller.areaLoading.value
                ? Container(
              height: 15,
              width: 15,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
                : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            items: controller.areaList.map((area) => area!.areaName!).toList(),
            label: 'Select area',
            onChanged: (value) => controller.onChangedArea(value),
            selectedItem: controller.selectedArea.value == '' ? null : controller.selectedArea.value,
            isRequiredField: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select a area';
              }
              return null;
            },
          ),
        ),
        Obx(() => CommonDropdownSearch(
            suffixIcon: controller.branchLoading.value
                ? Container(
              height: 15,
              width: 15,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
                : null,
            items: controller.branchList.map((branch) => branch!.branchName!).toList(),
            label: 'Select branch',
            onChanged: (value) => controller.onChangedBranch(value),
            selectedItem: controller.selectedBranch.value == '' ? null : controller.selectedBranch.value,
            isRequiredField: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select a branch';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}