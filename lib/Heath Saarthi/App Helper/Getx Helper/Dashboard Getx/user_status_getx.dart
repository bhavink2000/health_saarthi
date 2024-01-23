import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Dashboard%20Model/profile_model.dart';

import '../../Backend Helper/Api Future/Profile Future/profile_future.dart';
import '../../Backend Helper/Device Info/device_info.dart';

class UserStatusGetX extends GetxController {
  RxBool userCheck = false.obs;
  RxInt userStatus = 0.obs;

  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  BuildContext? context = Get.context;
  ProfileModel? profileModel;


  Future getUserStatus(var deviceToken) async {
    try {
      profileModel = await ProfileFuture().fetchProfile(box.read('accessToken'));
      if (profileModel?.data != null && profileModel?.data != null) {
        userStatus.value = profileModel!.data!.status!;
      } else {
        print('Failed to fetch user: User data is null');
      }
      print("userStatus ==>>$userStatus");
    } catch (e) {
      print("get User Status Error->$e");
      if (e.toString().contains('402')) {
        DeviceInfo().logoutUser(context!, deviceToken, box.read('accessToken'));
      }
    }
  }
}
