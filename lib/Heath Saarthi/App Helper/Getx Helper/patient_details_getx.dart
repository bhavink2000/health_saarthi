import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../Backend Helper/Models/Cart Menu/mobile_number_model.dart';

class PatientDetailsGetX extends GetxController{

  final box = GetStorage();

  List<MobileData> mobileList = [];
  RxString? selectedMobileNo = ''.obs;
  Future<void> fetchMobileList() async {
    try {
      CartFuture cartFuture = CartFuture();
      List<MobileData> list = await cartFuture.getMobileNumber('${box.read('accessToken')}', selectedMobileNo);
       mobileList = list;
    } catch (e) {
      log("Error -> $e");
    }
  }

}