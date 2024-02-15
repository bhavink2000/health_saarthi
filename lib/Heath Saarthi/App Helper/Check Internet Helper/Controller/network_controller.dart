import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class NetworkController extends GetxController {
  RxBool isConnected = false.obs;
  RxBool dialogVisible = false.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      print('Error initializing connectivity: $e');
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      isConnected.value = false;
      if (!dialogVisible.value) {
        dialogVisible.value = true;
        Get.dialog(
          barrierDismissible: false,
          const AlertDialog(
            icon: Icon(Icons.wifi_off),
            iconColor: Colors.white,
            backgroundColor: Colors.red,
            title: Text('Unable to connect.'),
            titleTextStyle: TextStyle(color: Colors.white),
            content: Text('Please verify your internet connection and try again.',textAlign: TextAlign.center,),
            contentTextStyle: TextStyle(color: Colors.white),
          ),
        );
      }
    } else {
      if(isConnected.value == true){
        isConnected.value = false;
      }
      else{
        isConnected.value = true;
      }
      if (dialogVisible.value) {
        Get.back();
        dialogVisible.value = false;
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}


// class NetworkController extends GetxController {
//
//   RxBool? isConnected;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   RxBool dialog = false.obs;
//   @override
//   void onInit() {
//     super.onInit();
//     initConnectivity();
//     _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }
//
//   Future<void> initConnectivity() async {
//     ConnectivityResult? result;
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       log(e.toString());
//     }
//     return _updateConnectionStatus(result!);
//   }
//
//   _updateConnectionStatus(ConnectivityResult result) {
//
//     if (result == ConnectivityResult.none) {
//       isConnected?.value = false;
//       dialog(true);
//       Get.dialog(
//         const PopScope(
//           canPop: false,
//           child: AlertDialog(
//             icon: Icon(Icons.wifi_off),
//             iconColor: Colors.white,
//             backgroundColor: Colors.red,
//             title: Text('Unable to connect.'),
//             titleTextStyle: TextStyle(color: Colors.white),
//             content: Text('Please verify your internet connection and try again.',textAlign: TextAlign.center,),
//             contentTextStyle: TextStyle(color: Colors.white),
//           ),
//         ),
//       );
//       // update();
//     } else {
//       if(isConnected?.value == true){
//         isConnected?.value = false;
//       }
//       else{
//         isConnected?.value = true;
//       }
//       if (dialog.value) {
//         dialog(false);
//         // Get.closeCurrentSnackbar();
//         Get.back();
//       }
//       // update();
//     }
//   }
// }