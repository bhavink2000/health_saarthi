import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';

class GetXSnackBarMsg{

  static getWarningMsg(var warningMsg){
    return Get.snackbar(
        'Warning', '$warningMsg',
        backgroundColor: hsPrime,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.warning_amber_rounded,color: Colors.white,),
        colorText: Colors.white
    );
  }

  static getSuccessMsg(var successMsg){
    return Get.snackbar(
        'Success', '$successMsg',
        backgroundColor: hsPrime,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.done_all_rounded,color: Colors.white,),
        colorText: Colors.white
    );
  }
}