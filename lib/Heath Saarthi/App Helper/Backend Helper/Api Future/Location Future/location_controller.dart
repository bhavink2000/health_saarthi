import 'dart:developer';

import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Location%20Future/location_future.dart';

import '../../Models/Location Model/area_model.dart';
import '../../Models/Location Model/branch_model.dart';
import '../../Models/Location Model/city_model.dart';
import '../../Models/Location Model/state_model.dart';

// class LocationController extends GetxController {
//
//   LocationFuture locationFuture = LocationFuture();
//
//   List<StateData?> stateList = [];
//   RxString selectedState = ''.obs;
//   RxString selectedStateId = ''.obs;
//   RxBool stateLoading = false.obs;
//   Future<void> fetchState() async {
//     stateLoading(true);
//     try {
//       stateList = await locationFuture.getState();
//       stateLoading(false);
//     } catch (e) {
//       log('Error in state load :-< $e');
//       stateLoading(false);
//     }
//   }
//
//   void onChangedState(value) {
//     final selectedStateObject = stateList.firstWhere(
//           (state) => state!.stateName == value,
//       orElse: () => StateData(),
//     );
//     if (selectedStateObject != null) {
//       cityList.clear();
//       selectedCity.value = '';
//       areaList.clear();
//       selectedArea.value = '';
//       branchList.clear();
//       selectedBranch.value = '';
//       selectedState.value = value;
//       selectedStateId.value = '${selectedStateObject.id}';
//       fetchCity(selectedStateId.value);
//     }
//   }
//
//   List<CityData?> cityList = [];
//   RxString selectedCity = ''.obs;
//   RxString selectedCityId = ''.obs;
//   RxBool cityLoading = false.obs;
//   Future<void> fetchCity(stateId) async {
//     cityLoading(true);
//     try {
//       cityList = await locationFuture.getCity(stateId);
//       cityLoading(false);
//     } catch (e) {
//       log('Error in city load :-< $e');
//       cityLoading(false);
//     }
//   }
//
//   void onChangedCity(value) {
//     final selectedCityObject = cityList.firstWhere(
//           (city) => city!.cityName == value,
//       orElse: () => CityData(), // Return an empty instance of StateData
//     );
//     if (selectedCityObject != null) {
//       selectedCity.value = '';
//       areaList.clear();
//       selectedArea.value = '';
//       branchList.clear();
//       selectedBranch.value = '';
//       selectedCity.value = value;
//       selectedCityId.value = selectedCityObject.id.toString();
//
//       // fetchBranch(selectedStateId, selectedCityId, '');
//
//       fetchArea(selectedStateId, selectedCityId);
//     }
//   }
//
//   List<AreaData?> areaList = [];
//   RxString selectedArea = ''.obs;
//   RxString selectedAreaId = ''.obs;
//   RxBool areaLoading = false.obs;
//   Future<void> fetchArea(stateId, cityId) async {
//     areaLoading(true);
//     try {
//       areaList = await locationFuture.getArea(stateId, cityId);
//       areaLoading(false);
//     } catch (e) {
//       log('Error in area load :-< $e');
//       areaLoading(false);
//     }
//   }
//
//   void onChangedArea(value) {
//     final selectedAreaObject = areaList.firstWhere(
//           (area) => area!.areaName == value,
//       orElse: () => AreaData(), // Return an empty instance of StateData
//     );
//     if (selectedAreaObject != null) {
//       selectedArea.value = value;
//       selectedAreaId.value = selectedAreaObject.id.toString();
//       fetchBranch(selectedStateId, selectedCityId, selectedAreaId);
//     }
//   }
//
//   List<BranchData?> branchList = [];
//   RxString selectedBranch = ''.obs;
//   RxString selectedBranchId = ''.obs;
//   RxBool branchLoading = false.obs;
//   Future<void> fetchBranch(stateId, cityId, areaId) async {
//     branchLoading(true);
//     try {
//       branchList = await locationFuture.getBranch(stateId, cityId, areaId);
//       branchLoading(false);
//     } catch (e) {
//       log('Error in branch load :-< $e');
//       branchLoading(false);
//     }
//   }
//
//   void onChangedBranch(value) {
//     final selectedBranchObject = branchList.firstWhere(
//           (branch) => branch!.branchName == value,
//       orElse: () => BranchData(), // Return an empty instance of StateData
//     );
//     if (selectedBranchObject != null) {
//       selectedBranch.value = value;
//       selectedBranchId.value = selectedBranchObject.id.toString();
//     }
//   }
// }