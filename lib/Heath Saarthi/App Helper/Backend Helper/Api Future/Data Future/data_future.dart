import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Home%20Menu/package_items_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Home%20Menu/test_items_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/getx_snackbar_msg.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import '../../Models/Home Menu/package_model.dart';
import '../../Models/Home Menu/test_model.dart';
import 'package:http/http.dart' as http;

class DataFuture extends GetxController{

  final box = GetStorage();
  getHeader(){
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('accessToken')}',
    };
  }

  @override
  void onInit() {
    super.onInit();
  }

  final testSearch = TextEditingController();
  RxInt testIndex = 0.obs;
  RxBool testLoading = false.obs;
  Rx<TestModel> testModel = TestModel().obs;
  Future<void> fetchTest(int index) async {
    testLoading(true);
    try {
      Map testData = {
        'search': testSearch.text,
      };
      final response = await http.post(
          Uri.parse('${ApiUrls.testListUrls}?page=$index'),
          headers: getHeader(),
          body: testData
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 200) {
          testModel.value = TestModel.fromJson(responseBody);
          testLoading(false);
        }
        else if(responseBody['status'] == 402){
          testLoading(false);
          throw Exception(responseBody['status']);
        }
      }
      else if(response.statusCode == 500){
        testLoading(false);
        GetXSnackBarMsg.getWarningMsg('${AppTextHelper().internalServerError}');
        throw Exception(response.statusCode);
      }
      else {
        log('something went wrong in fetch test status code -> ${response.statusCode}');
        testLoading(false);
      }
    } catch (e) {
      log('error in fetch test list $e');
      testLoading(false);
    }
  }

  final packageSearch = TextEditingController();
  RxInt packageIndex = 0.obs;
  RxBool packageLoading = false.obs;
  Rx<PackageModel> packageModel = PackageModel().obs;
  Future<void> fetchPackage(int index) async {
    packageLoading(true);
    try {
      Map packageData = {
        'search': packageSearch.text,
      };
      final response = await http.post(Uri.parse('${ApiUrls.packageListUrls}?page=$index'),
          headers: getHeader(),
          body: packageData);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 200) {
          packageModel.value = PackageModel.fromJson(responseBody);
          packageLoading(false);
        }
      } else {
        log('something went wrong in fetch package status code -> ${response.statusCode}');
        packageLoading(false);
      }
    } catch (e) {
      log('error in fetch package list $e');
      packageLoading(false);
    }
  }

  RxBool tItemLoading = false.obs;
  Rx<TestItemsDetailsModel> tItemModel = TestItemsDetailsModel().obs;
  Future<void> fetchTestItems(var testId)async{
    tItemLoading(true);
    try {
      final response = await http.get(Uri.parse("${ApiUrls.testItemDetailsUrls}$testId"),
        headers: getHeader(),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 200) {
          tItemModel.value = TestItemsDetailsModel.fromJson(responseBody);
          tItemLoading(false);
        }
      } else {
        log('something went wrong in fetch package status code -> ${response.statusCode}');
        tItemLoading(false);
      }
    } catch (e) {
      log('error in fetch package list $e');
      tItemLoading(false);
    }
  }


  RxBool pItemsLoading = false.obs;
  Rx<PackageItemDetailsModel> pItemModel = PackageItemDetailsModel().obs;
  Future<void> fetchPackageItems(var packageId)async{
    pItemsLoading(true);
    try {
      final response = await http.get(Uri.parse("${ApiUrls.packageItemDetailsUrls}$packageId"),
          headers: getHeader(),
          );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 200) {
          pItemModel.value = PackageItemDetailsModel.fromJson(responseBody);
          pItemsLoading(false);
        }
      } else {
        log('something went wrong in fetch package status code -> ${response.statusCode}');
        pItemsLoading(false);
      }
    } catch (e) {
      log('error in fetch package list $e');
      pItemsLoading(false);
    }
  }
}