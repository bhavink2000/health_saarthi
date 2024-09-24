import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Device%20Info/device_info.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Drawer%20Menu/booking_history_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Drawer%20Menu/faqs_model.dart';
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
          GetXSnackBarMsg.getWarningMsg(responseBody['message']);
          DeviceInfo().logoutUser();
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


  List popularPackageData = [];
  RxBool popPackageLoad = false.obs;
  Future fetchPopularPackages() async {
    popPackageLoad(true);
    try {
      final response =
      await http.get(
          Uri.parse(ApiUrls.popularPackage),
          headers: getHeader()
      );
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseBody['status'] == 200) {
          popularPackageData = responseBody['data'];
          popPackageLoad(false);
        } else if (responseBody['status'] == 402) {
          popPackageLoad(false);
          GetXSnackBarMsg.getWarningMsg(responseBody['message']);
          //DeviceInfo().logoutUser();
        }
      } else {
        log('error in popular packages');
        log('${response.statusCode}');
        log(response.body);
        popPackageLoad(false);
      }
    } catch (e) {
      log('something went wrong in popular packages $e');
      popPackageLoad(false);
    }
  }


  RxBool bookingLoad = false.obs;
  Rx<BookingHistoryModel> bookingModel = BookingHistoryModel().obs;
  final fromDate = TextEditingController();
  final toDate = TextEditingController();
  Future<void> fetchBooking() async{
    bookingLoad(true);
    try{
      Map data = {
        'from_date': fromDate.text,
        'to_date': toDate.text,
      };
      log('Booking Payload ->$data');
      final response = await http.post(
        Uri.parse("${ApiUrls.bookingHistoryUrls}"),
        headers: getHeader(),
        body: data
      );

      log('Booking response ->${response.body}');
      if(response.statusCode == 200){
        var bookingResponse = json.decode(response.body);
        if(bookingResponse['status'] == 200){
          bookingModel.value = BookingHistoryModel.fromJson(bookingResponse);
          bookingLoad(false);
        }
      }
      else if(response.statusCode == 500){
        bookingLoad(false);
        GetXSnackBarMsg.getWarningMsg('${AppTextHelper().internalServerError}');
        throw Exception(response.statusCode);
      }
    }catch(e){
      log('fetchBooking catch error ->$e');
    }
  }


  var salesPersonNM,superiorNM,customerCareNm,otherNM;
  var salesPersonNo,superiorNo,customerCareNo,otherNo;
  RxBool contactUsLoad = false.obs;
  void fetchContact() async {
    contactUsLoad(false);
    final response = await http.get(
        Uri.parse(ApiUrls.contactUsUrls),
        headers: getHeader(),
    );
    print("response-$response");
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      print("data->$data");
      if(data != null){
          salesPersonNM = data['name'];
          salesPersonNo = data['mobile_no'];
          superiorNM = data['name_two'];
          superiorNo = data['mobile_no_two'];
          customerCareNm = data['name_three'];
          customerCareNo = data['mobile_no_three'];
          otherNM = data['name_other'];
          otherNo = data['mobile_no_other'];
          contactUsLoad(true);
      }
      else{
        contactUsLoad(true);
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      contactUsLoad(true);
    }
  }

  Rx<FaqsModel> faqModel = FaqsModel().obs;
  RxBool faqLoad = false.obs;
  Future<void> fetchFaqs() async {
    faqLoad(true);
    final response = await http.get(Uri.parse(ApiUrls.faqsUrls), headers: getHeader());
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['status'] == 200) {
        faqModel = FaqsModel.fromJson(responseBody).obs;
        faqLoad(false);
      } else if (responseBody['status' == '402']) {
        GetXSnackBarMsg.getWarningMsg(responseBody['message']);
        faqLoad(false);
      }
    }
    else if(response.statusCode == 400){
      faqModel = FaqsModel.fromJson(responseBody).obs;
      faqLoad(false);
    }
    else {
      log('something went wrong :-< status code ${response.statusCode}');
      faqLoad(false);
    }
  }
}