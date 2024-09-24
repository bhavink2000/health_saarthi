import 'dart:developer';

import 'package:get/get.dart';

import '../Backend Helper/Api Future/Location Future/location_future.dart';
import '../Backend Helper/Models/Location Model/area_model.dart';
import '../Backend Helper/Models/Location Model/branch_model.dart';
import '../Backend Helper/Models/Location Model/city_model.dart';
import '../Backend Helper/Models/Location Model/state_model.dart';

class LocationCall extends GetxController{

  List<StateData> stateList = [];
  RxString selectedState = ''.obs;
  RxString selectedStateId = ''.obs;
  RxBool stateLoading = false.obs;

  @override
  void onInit() async{
    super.onInit();
    fetchStateList();
  }

  void clearFunction(){
    stateList.clear();
    cityList.clear();
    areaList.clear();
    branchList.clear();
  }
  Future<void> fetchStateList() async {
    stateLoading(true);
    try {
      LocationFuture locationFuture = LocationFuture();
      List<StateData> list = await locationFuture.getState();
        stateList = list;
        stateLoading(false);
    } catch (e) {
      print("Error -> $e");
    }
  }



  List<CityData?> cityList = [];
  RxString selectedCity = ''.obs;
  RxString selectedCityId = ''.obs;
  RxBool cityLoading = false.obs;

  Future<void> fetchCityList(var sState) async {
    cityLoading(true);
    try {
      LocationFuture locationFuture = LocationFuture();
      List<CityData> list = await locationFuture.getCity(sState);
        cityList = list;
        cityLoading(false);
    } catch (e) {
      print("Error -> $e");
    }
  }


  List<AreaData?> areaList = [];
  RxString selectedArea = ''.obs;
  RxString selectedAreaId = ''.obs;
  RxBool areaLoading = false.obs;

  Future<void> fetchAreaList(var sState, var sCity) async {
    areaLoading(true);
    try {
      LocationFuture locationFuture = LocationFuture();
      List<AreaData> list = await locationFuture.getArea(sState,sCity);
        areaList = list;
        areaLoading(false);
    } catch (e) {
      print("Error -> $e");
    }
  }


  List<BranchData?> branchList = [];
  RxString selectedBranch = ''.obs;
  RxString selectedBranchId = ''.obs;
  RxBool branchLoading = false.obs;

  Future<void> fetchBranchList(var sState, var sCity, var sArea) async {
      branchLoading(true);
    try {
      LocationFuture locationFuture = LocationFuture();
      List<BranchData> list = await locationFuture.getBranch(sState,sCity,sArea);
        branchList = list;
        branchLoading(false);
    } catch (e) {
      print("Branch Error -> $e");
    }
  }

  void onChangedState(value) {
    final selectedStateObject = stateList.firstWhere(
          (state) => state!.stateName == value,
      orElse: () => StateData(),
    );
    if (selectedStateObject != null) {
      cityList.clear();
      selectedCity.value = '';
      areaList.clear();
      selectedArea.value = '';
      branchList.clear();
      selectedBranch.value = '';
      selectedState.value = value;
      selectedStateId.value = '${selectedStateObject.id}';
      fetchCityList(selectedStateId.value);
    }
  }

  void onChangedCity(value) {
    final selectedCityObject = cityList.firstWhere(
          (city) => city!.cityName == value,
      orElse: () => CityData(), // Return an empty instance of StateData
    );
    if (selectedCityObject != null) {
      selectedCity.value = '';
      areaList.clear();
      selectedArea.value = '';
      branchList.clear();
      selectedBranch.value = '';
      selectedCity.value = value;
      selectedCityId.value = selectedCityObject.id.toString();

      // fetchBranch(selectedStateId, selectedCityId, '');

      fetchAreaList(selectedStateId, selectedCityId);
    }
  }

  void onChangedArea(value) {
    final selectedAreaObject = areaList.firstWhere(
          (area) => area!.areaName == value,
      orElse: () => AreaData(), // Return an empty instance of StateData
    );
    if (selectedAreaObject != null) {
      selectedArea.value = value;
      selectedAreaId.value = selectedAreaObject.id.toString();
      fetchBranchList(selectedStateId, selectedCityId, selectedAreaId);
    }
  }
  void onChangedBranch(value) {
    final selectedBranchObject = branchList.firstWhere(
          (branch) => branch!.branchName == value,
      orElse: () => BranchData(), // Return an empty instance of StateData
    );
    if (selectedBranchObject != null) {
      selectedBranch.value = value;
      selectedBranchId.value = selectedBranchObject.id.toString();
    }
  }
}