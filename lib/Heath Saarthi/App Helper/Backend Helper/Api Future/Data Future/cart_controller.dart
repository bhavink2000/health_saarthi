import 'dart:convert';
import 'dart:developer';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Location%20Future/location_controller.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Getx%20Helper/location_getx.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Device%20Info/device_info.dart';

import '../../Models/Cart Menu/cart_calculation.dart';
import '../../Models/Cart Menu/cart_model.dart';
import '../Profile Future/profile_future.dart';

class CartController extends GetxController {

  final box = GetStorage();
  getHeader(){
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('accessToken')}',
    };
  }


  final locationController = Get.find<LocationCall>();

  @override
  void onInit() {
    getUserStatus();
    log('cart sBranchId -------->>>>>>>>>>>${sBranchId.value}');
    fetchCart(sBranchId.value);
    cartCalculation();
    super.onInit();
  }

  @override
  void onClose() {
    locationController.selectedState.value = '';
    locationController.selectedStateId.value = '';
    locationController.selectedCity.value = '';
    locationController.selectedCityId.value = '';
    locationController.selectedArea.value = '';
    locationController.selectedAreaId.value = '';
    locationController.selectedBranch.value = '';
    locationController.selectedBranchId.value = '';
    super.onClose();
  }

  final testScrollController = ScrollController();
  final profileScrollController = ScrollController();
  final packageScrollController = ScrollController();

  RxString selectLocation = ''.obs;

  RxString sStateName = ''.obs;
  RxString sCityName = ''.obs;
  RxString sAreaName = ''.obs;
  RxString sBranchName = ''.obs;
  RxString sStateId = ''.obs;
  RxString sCityId = ''.obs;
  RxString sAreaId = ''.obs;
  RxString sBranchId = ''.obs;

  RxBool setLocation = false.obs;
  RxBool showDLocation = false.obs;
  RxBool showExpantile = false.obs;

  final promoApply = TextEditingController();
  GlobalKey<FormState> locationFormKey = GlobalKey<FormState>();
  var grossAmount = ''.obs;
  var totalAmount = ''.obs;
  var netAmount = ''.obs;
  RxBool callPromo = false.obs;
  var isApplyPromo;
  var applyPromo;
  RxString testD = ''.obs;
  RxString packageD = ''.obs;
  RxString profileD = ''.obs;

  var userStatus;
  getUserStatus() async {
    try {
      dynamic userData = await ProfileFuture().fetchProfile();
      userStatus = userData.data.status;
      sStateId.value = userData.data.state.id.toString();
      sCityId.value = userData.data.city.id.toString();
      sAreaId.value = userData.data.area.id.toString();
      sBranchId.value = userData.data.costCenter.id.toString();
      sStateName.value = userData.data.state.stateName.toString();
      sCityName.value = userData.data.city.cityName.toString();
      sAreaName.value = userData.data.area.areaName.toString();
      sBranchName.value = userData.data.costCenter.branchName.toString();
    } catch (e) {
      log("get User Status Error->$e");
      if (e.toString().contains('402')) {
        DeviceInfo().logoutUser();
      }
    }
  }

  Rx<CartModel> cartModel = CartModel().obs;
  RxBool cartLoading = false.obs;
  Future<void> fetchCart(data) async {
    log('in fetch cart');
    cartLoading(true);
    try {
      Map sendData = {'cost_center_id': data.toString()};
      final response = await http.post(Uri.parse(ApiUrls.cartItemsUrls),
          headers: getHeader(),
          body: sendData);
      var responseBody = jsonDecode(response.body);

      log('cart response -->$responseBody');

      if (response.statusCode == 200) {
        if (responseBody['status'] == 200) {
          cartModel.value = CartModel.fromJson(responseBody);
          cartLoading(false);
        } else {
          log('error in fetch cart :-< ${responseBody['message']}');
          cartLoading(false);
        }
      }
    } catch (e) {
      log('something went wrong in fetching cart ');
      cartLoading(false);
    }
  }

  var bodyMsg;
  RxBool cartCalculationLoading = false.obs;
  Future<CartCalculationModel?> cartCalculation() async {
    cartCalculationLoading(true);
    Map<String, String> headers = getHeader();
    try {
      final response = await http.post(Uri.parse(ApiUrls.cartCalculationUrls),
          headers: headers,
          body: {
            'test_discount_id': testD.value.toString(),
            'package_discount_id': packageD.value.toString(),
            'profile_discount_id': profileD.value.toString(),
            'promo_offer_code': promoApply.text
          });
      final responseData = json.decode(response.body);
      log("--------->>>>responsedata->$responseData");
      var bodyStatus = responseData['status'];
      bodyMsg = responseData['message'];
      if (response.statusCode == 200) {
        if (bodyStatus == 200) {
          isApplyPromo = responseData['data']['isApplyPromo'];
          applyPromo = responseData['data']['applyPromo'];
          netAmount.value = responseData['data']['netAmount'].toString();
          grossAmount.value = responseData['data']['grossAmount'].toString();
          totalAmount.value = responseData['data']['discountAmount'].toString();
          cartCalculationLoading(false);
        } else if (bodyStatus == 400) {
          isApplyPromo = responseData['data']['isApplyPromo'];
          applyPromo = responseData['data']['applyPromo'];
          netAmount.value = responseData['data']['netAmount'].toString();
          grossAmount.value = responseData['data']['grossAmount'].toString();
          totalAmount.value = responseData['data']['discountAmount'].toString();
          promoApply.text = '';
          cartCalculationLoading(false);
        } else if (bodyStatus == '402') {
          DeviceInfo().logoutUser();
          DeviceInfo().logoutUser();
          cartCalculationLoading(false);
        }
      } else if (response.statusCode == 400) {
        if (bodyStatus == 400) {
          isApplyPromo = responseData['data']['isApplyPromo'];
          applyPromo = responseData['data']['applyPromo'];
          netAmount.value = responseData['data']['netAmount'].toString();
          grossAmount.value = responseData['data']['grossAmount'].toString();
          totalAmount.value = responseData['data']['discountAmount'].toString();
          promoApply.text = '';
          cartCalculationLoading(false);
        }
      }
    } catch (error) {
      log("cart Calculation Error->$error");
      cartCalculationLoading(false);
    }
    return null;
  }
}
