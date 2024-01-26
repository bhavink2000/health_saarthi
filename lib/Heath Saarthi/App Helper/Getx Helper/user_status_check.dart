// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Backend Helper/Api Future/Profile Future/profile_future.dart';
import '../Backend Helper/Device Info/device_info.dart';
import '../Backend Helper/Models/Dashboard Model/profile_model.dart';
import '../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';

class UserStatusCheckController extends GetxController{

  final box = GetStorage();
  Timer? timer;
  BuildContext? context = Get.context;
  @override
  void onInit() async{
    super.onInit();
    await retrieveDeviceToken();
   timer =  Timer.periodic(const Duration(seconds: 1), (Timer t) {
      getUserStatus();
    });
  }

  @override
  void onClose() {
    timer!.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }


  var userStatus;
  var deviceToken;

  ProfileModel? profileModel;
  Future<void> getUserStatus() async {
    try {
      profileModel = await ProfileFuture().fetchProfile(box.read('accessToken'));
      if (profileModel?.data != null && profileModel?.data != null) {
          userStatus = profileModel?.data?.status;
          log('UserStatus -> $userStatus');
      }
    } catch (e) {
      log("get User Status Error->$e");
      if (e is SocketException && e.osError!.errorCode == 111) {
        GetXSnackBarMsg.getWarningMsg('Connection refused. \nCheck server availability.');
      } else if (e.toString().contains('402')) {
        DeviceInfo().logoutUser(context!, deviceToken, box.read('accessToken'));
      } else {
        log("Unhandled error: $e");
      }
    }
  }
  Future<void> retrieveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      deviceToken = prefs.getString('deviceToken');
  }
}