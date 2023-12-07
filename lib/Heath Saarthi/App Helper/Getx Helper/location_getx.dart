import 'dart:developer';

import 'package:get/get.dart';

import '../Backend Helper/Api Future/Location Future/location_future.dart';
import '../Backend Helper/Models/Location Model/area_model.dart';
import '../Backend Helper/Models/Location Model/branch_model.dart';
import '../Backend Helper/Models/Location Model/city_model.dart';
import '../Backend Helper/Models/Location Model/state_model.dart';

class LocationCall extends GetxController{

  List<StateData> stateList = [];
  RxString? selectedState = ''.obs;
  RxString? selectedStateId = ''.obs;
  RxBool stateLoading = false.obs;

  @override
  void onInit() async{
    super.onInit();
    fetchStateList();
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
  RxString? selectedCity = ''.obs;
  RxString? selectedCityId = ''.obs;
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
  RxString? selectedArea = ''.obs;
  RxString? selectedAreaId = ''.obs;
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
  RxString? selectedBranch = ''.obs;
  RxString? selectedBranchId = ''.obs;
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

}