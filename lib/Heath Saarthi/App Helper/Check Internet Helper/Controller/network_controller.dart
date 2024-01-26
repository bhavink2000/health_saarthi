import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Getx%20Helper/location_getx.dart';

import '../../Getx Helper/patient_details_getx.dart';

class NetworkController extends GetxController {
  // var connectionStatus = 0.obs ;

  bool? isConnected;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  RxBool? dialog = false.obs;
  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult? result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log(e.toString());
    }
    return _updateConnectionStatus(result!);
  }

  _updateConnectionStatus(ConnectivityResult result) {

    if (result == ConnectivityResult.none) {
      isConnected = false;
      dialog!(true);
      Get.dialog(
        const PopScope(
          canPop: false,
          child: AlertDialog(
            icon: Icon(Icons.wifi_off),
            iconColor: Colors.white,
            backgroundColor: Colors.red,
            title: Text('Unable to connect.'),
            titleTextStyle: TextStyle(color: Colors.white),
            content: Text('Please verify your internet connection and try again.',textAlign: TextAlign.center,),
            contentTextStyle: TextStyle(color: Colors.white),
          ),
        ),
      );
      update();
    } else {
      if(isConnected == true){
        isConnected = false;
      }
      else{
        isConnected = true;
      }
      if (dialog == true) {
        dialog!(false);
        Get.closeCurrentSnackbar();
        Get.back();
      }
      update();
    }
  }

  @override
  void onClose() {}
}
