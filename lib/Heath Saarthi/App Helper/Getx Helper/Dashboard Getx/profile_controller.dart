import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../../DashBoard/hs_dashboard.dart';
import '../../Backend Helper/Api Future/Profile Future/profile_future.dart';
import '../../Backend Helper/Api Urls/api_urls.dart';
import '../../Backend Helper/Device Info/device_info.dart';
import '../../Backend Helper/Models/Dashboard Model/profile_model.dart';
import '../../Frontend Helper/Loading Helper/loading_helper.dart';
import '../../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../Frontend Helper/Text Helper/test_helper.dart';

class ProfileController extends GetxController{
  final box = GetStorage();
  BuildContext? context;

  ProfileController({this.context});

  String? firstNm, mobileNo,emailId, address, stateNm, cityNm, areaNm, branchNm, bankNm, ifscCode, accountNo, gstNo;
  String? pinCode, panCard, addressNm, aadhaarFNm, aadhaarBNm, chequeNm, gstNm,
      panCardImg, addressImg, aadhaarFImg,aadhaarBImg, chequeImg,gstImg;

  File? panCardFile;
  File? aadhaarBFile;
  File? aadhaarFFile;
  File? chequeFile;
  File? gstFileFile;
  File? addressFile;


  GlobalKey<State> _loadingDialogKey = GlobalKey<State>();

  bool mounted = false;
  var userStatus;

  @override
  void onInit() {
    //getProfile();
    super.onInit();
  }
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            key: _loadingDialogKey,
            child: const CenterLoading(),
          ),
        );
      },
    );
  }


  ProfileModel? profileModel;
  Future<void> getProfile() async {
    log('profile call');
    if (context != null) {
      _showLoadingDialog(context!);
      try {
        profileModel = await ProfileFuture().fetchProfile(box.read('accessToken'));
        log("profileModel: $profileModel");
        log("profileModel?.data: ${profileModel?.data}");
        if (profileModel != null && profileModel?.data != null) {
          log('Entering if block...');
          userStatus = profileModel?.data?.status;
          mounted = false;
          log('userStatus: $userStatus');
        }
      } catch (e) {
        log('---------------------catch Error: $e------------------------');
        if (e is Exception && e.toString().contains('402')) {
          var errorMessage = e.toString();
          var messageIndex = errorMessage.indexOf('message: ');
          if (messageIndex != -1) {
            errorMessage = errorMessage.substring(messageIndex + 'message: '.length);
            errorMessage = errorMessage.trim().replaceAll('}', ''); // Clean up the string
            GetXSnackBarMsg.getWarningMsg(errorMessage);
            DeviceInfo().logoutUser(context!,box.read('deviceToken'), box.read('accessToken'));
            if (Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).canPop()) {
              Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).pop();
            }
          } else {
            log('catch Error: else $e');
            DeviceInfo().logoutUser(context!,box.read('deviceToken'), box.read('accessToken'));
            if (Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).canPop()) {
              Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).pop();
            }
          }
        }
      } finally {
        if (Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).canPop()) {
          Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).pop();
        }
      }
    }
    // try {
    //   _showLoadingDialog(context!);
    //   profileModel = await ProfileFuture().fetchProfile(box.read('accessToken'));
    //   if (mounted && profileModel != null && profileModel?.data != null) {
    //     userStatus = profileModel?.data?.status.toString();
    //     mounted = false;
    //   }
    //   if (Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).canPop()) {
    //     Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).pop();
    //   }
    // } catch (e) {
    //   log('catch Error: $e');
    //   if (e is Exception && e.toString().contains('402')) {
    //     var errorMessage = e.toString();
    //     var messageIndex = errorMessage.indexOf('message: ');
    //     if (messageIndex != -1) {
    //       errorMessage = errorMessage.substring(messageIndex + 'message: '.length);
    //       errorMessage = errorMessage.trim().replaceAll('}', ''); // Clean up the string
    //       GetXSnackBarMsg.getWarningMsg(errorMessage);
    //       DeviceInfo().logoutUser(context!,box.read('deviceToken'), box.read('accessToken'));
    //       if (Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).canPop()) {
    //         Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).pop();
    //       }
    //     } else {
    //       log('catch Error: else $e');
    //       DeviceInfo().logoutUser(context!,box.read('deviceToken'), box.read('accessToken'));
    //       if (Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).canPop()) {
    //         Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).pop();
    //       }
    //     }
    //   }
    // }
  }

  void updateProfileData(BuildContext context) async {
    Dio dio = Dio();
    String apiUrl = ApiUrls.updateProfileUrls;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text('Loading...'),
              ],
            ),
          ),
        ); // Show the loading dialog while waiting for the response.
      },
    );
    try {
      FormData formData = FormData();
      if (panCardFile != null) {
        formData.files.add(MapEntry(
            'pancard', await MultipartFile.fromFile(panCardFile!.path)));
      }
      if (addressFile != null) {
        formData.files.add(MapEntry(
            'address_proof', await MultipartFile.fromFile(addressFile!.path)));
      }
      if (aadhaarFFile != null) {
        formData.files.add(MapEntry(
            'aadhar_front',
            await MultipartFile.fromFile(aadhaarFFile!.path)));
      }
      if (aadhaarBFile != null) {
        formData.files.add(MapEntry(
            'aadhar_back', await MultipartFile.fromFile(aadhaarBFile!.path)));
      }
      if (chequeFile != null) {
        formData.files.add(MapEntry(
            'cheque_image', await MultipartFile.fromFile(chequeFile!.path)));
      }
      if (gstFileFile != null) {
        formData.files.add(MapEntry(
            'gst_image', await MultipartFile.fromFile(gstFileFile!.path)));
      }
      Response response = await dio.post(
        apiUrl,
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('accessToken')}',
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        var data = response.data;
        var msg = data['message'];
        if (data['status'] == 200) {
          GetXSnackBarMsg.getSuccessMsg('$msg');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
        }
      } else if (response.statusCode == 400) {
        var data = response.data;
        var errorMsg = data['message'];
        if (data['status'] == 400) {
          GetXSnackBarMsg.getWarningMsg('$errorMsg');
          Navigator.pop(context);
        }
      }
    } catch (e) {

      print("Error uploading documents: ${e}");
      GetXSnackBarMsg.getWarningMsg('${AppTextHelper().selectDocuments}');
      Navigator.pop(context);
    }
}
}