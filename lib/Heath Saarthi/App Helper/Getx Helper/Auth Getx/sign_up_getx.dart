// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:get/get_core/get_core.dart';
// import 'package:get/get_instance/get_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:get/state_manager.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Getx%20Helper/location_getx.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import '../../../Authentication Screens/Splash Screen/splash_screen.dart';
// import '../../Backend Helper/Api Urls/api_urls.dart';
// import '../../Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
// import '../../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
// import '../../Frontend Helper/Text Helper/test_helper.dart';
//
// class SignUpGetX extends GetxController {
//   final lController = Get.put(LocationCall());
//
//   final box = GetStorage();
//
//   @override
//   void onInit() {
//     super.onInit();
//     getB2bSalesList();
//   }
//
//
//   RxBool agreedToTOS = false.obs;
//   RxBool showExecutive = false.obs;
//   RxBool isSigningUp = false.obs;
//   RxBool obscured = true.obs;
//   RxBool obCScured = true.obs;
//
//   double loadingProgress = 0.0;
//
//   RxString? selectedSales;
//   RxString? selectedB2b;
//   RxInt? selectedSalesMobileNo;
//
//   File? panCardFile;
//   File? addressFile;
//   File? aadhaarCardFFile;
//   File? aadhaarCardBFile;
//   File? checkFile;
//   File? gstFile;
//
//   final vendorName = TextEditingController();
//   final emailId = TextEditingController();
//   final pharmacyName = TextEditingController();
//   final mobile = TextEditingController();
//   final address = TextEditingController();
//   final seMobile = TextEditingController();
//   final pinCode = TextEditingController();
//   final password = TextEditingController();
//   final cPassword = TextEditingController();
//
//   final panCardNo = TextEditingController();
//   final bankName = TextEditingController();
//   final ifscCode = TextEditingController();
//   final beneficiaryName = TextEditingController();
//   final accountNo = TextEditingController();
//   final gstNo = TextEditingController();
//
//   void togglePasswordView() {
//     obscured = obscured;
//   }
//   void toggleCPasswordView() {
//     obCScured = obCScured;
//   }
//
//   GestureDetector buildImageDialog(File selectedFilePhoto, var label) {
//     return GestureDetector(
//       onTap: () {
//         if (selectedFilePhoto != null) {
//           Get.defaultDialog(
//               content: Dialog(
//             child: Image.file(selectedFilePhoto),
//           ));
//         }
//       },
//       child: selectedFilePhoto == null
//           ? Text("$label",
//               style: const TextStyle(fontFamily: FontType.MontserratMedium))
//           : Image.file(selectedFilePhoto, fit: BoxFit.cover),
//     );
//   }
//   String? validatePANCard(String? value) {
//     // PAN card pattern to validate: 5 uppercase letters followed by 4 digits and 1 uppercase letter
//     RegExp panCardRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
//     if (!panCardRegExp.hasMatch(value!)) {
//       return 'Enter a valid PAN card no(Ex-ABCDE1234F)';
//     }
//     return null;
//   }
//   String? validateIFSC(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'IFSC code is required';
//     }
//     // Remove any whitespace and convert to uppercase
//     value = value.replaceAll(RegExp(r'\s+'), '').toUpperCase();
//     // Check if the length of the IFSC code is exactly 11 characters
//     if (value.length != 11) {
//       return 'IFSC code must be 11 characters long';
//     }
//     // Check if the first four characters are letters
//     if (!RegExp(r'^[A-Z]{4}').hasMatch(value)) {
//       return 'Invalid IFSC code format';
//     }
//     // Check if the fifth character is '0'
//     if (value[4] != '0') {
//       return 'Invalid IFSC code format';
//     }
//     // Check if the remaining characters are alphanumeric
//     if (!RegExp(r'^[A-Z0-9]{6}$').hasMatch(value.substring(5, 11))) {
//       return 'Invalid IFSC code format';
//     }
//     // You can add additional checks here if needed, such as checking against a list of valid IFSC codes
//     // If all checks pass, the IFSC code is valid
//     return null; // Return null if the IFSC code is valid
//   }
//   String? validateAccountNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Account number is required';
//     }
//     // Check if the value contains only numeric characters
//     if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//       return 'Account number must contain only digits';
//     }
//     // You can add additional checks here based on your specific validation requirements
//     // If all checks pass, the account number is considered valid
//     return null; // Return null if the account number is valid
//   }
//   void setAgreedToTOS(bool? newValue) {
//     agreedToTOS.value = newValue!;
//   }
//
//   List<dynamic> b2bSubAdminList = [].obs;
//   List<dynamic> salesExecutiveList = [].obs;
//
//   Future<void> getB2bSalesList() async {
//     try {
//       final response = await http.get(
//         Uri.parse(ApiUrls.b2bSalesUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       );
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         b2bSubAdminList = data['data']['b2b_subadmins'];
//         salesExecutiveList = data['data']['sales_executive_admins'];
//       } else {}
//     } catch (e) {
//       print("B2b & Sales Error -> $e");
//     }
//   }
//
//   void storeLocation()async{
//     await box.write('signUpStateId', lController.selectedStateId);
//     await box.write('signUpCityId', lController.selectedCityId);
//     await box.write('signUpAreaId', lController.selectedAreaId);
//     await box.write('signUpBranchId', lController.selectedBranchId);
//     await box.write('signUpStateName', lController.selectedState);
//     await box.write('signUpCityName', lController.selectedCity);
//     await box.write('signUpAreaName', lController.selectedArea);
//     await box.write('signUpBranchName', lController.selectedBranch);
//   }
//
//   signUpData() async {
//     final dio = Dio();
//     var url = ApiUrls.signUpUrl;
//     try {
//       var formData = FormData();
//       formData.fields.addAll([
//         MapEntry("vendor_name", vendorName.text ?? ''),
//         MapEntry("email_id", emailId.text ?? ''),
//         MapEntry("password", password.text ?? ''),
//         MapEntry("mobile", mobile.text ?? ''),
//         MapEntry("name", pharmacyName.text ?? ''), // name = pharmacy name
//         MapEntry("state_id", lController.selectedStateId!.value ?? ''),
//         MapEntry("city_id", lController.selectedCityId!.value ?? ''),
//         MapEntry("area_id", lController.selectedAreaId!.value ?? ''),
//         MapEntry("cost_center_id", lController.selectedBranchId!.value ?? ''),
//         MapEntry("address", address.text ?? ''),
//         MapEntry("pincode", pinCode.text ?? ''),
//         MapEntry("pancard_number", panCardNo.text ?? ''),
//         MapEntry("sales_executive_admin_id", selectedSales?.value ?? ''),
//         MapEntry("b2b_subadmin_id", selectedB2b?.value ?? ''),
//         MapEntry("bank_name", bankName.text ?? ''),
//         MapEntry("ifsc", ifscCode.text ?? ''),
//         MapEntry("beneficiary_name", beneficiaryName.text ?? ''),
//         MapEntry("account_number", accountNo.text ?? ''),
//         MapEntry("gst_number", gstNo.text ?? ''),
//       ]);
//       if (panCardFile != null) {
//         formData.files.add(MapEntry(
//           "pancard",
//           await MultipartFile.fromFile(
//             panCardFile!.path,
//             filename: panCardFile!.path.split('/').last.toString(),
//           ),
//         ));
//       }
//       if (addressFile != null) {
//         formData.files.add(MapEntry(
//           "address_proof",
//           await MultipartFile.fromFile(
//             addressFile!.path,
//             filename: addressFile!.path.split('/').last.toString(),
//           ),
//         ));
//       }
//       if (aadhaarCardFFile != null) {
//         formData.files.add(MapEntry(
//           "aadhar_front",
//           await MultipartFile.fromFile(
//             aadhaarCardFFile!.path,
//             filename: aadhaarCardFFile!.path.split('/').last.toString(),
//           ),
//         ));
//       }
//       if (aadhaarCardBFile != null) {
//         formData.files.add(MapEntry(
//           "aadhar_back",
//           await MultipartFile.fromFile(
//             aadhaarCardBFile!.path,
//             filename: aadhaarCardBFile!.path.split('/').last.toString(),
//           ),
//         ));
//       }
//       if (checkFile != null) {
//         formData.files.add(MapEntry(
//           "cheque_image",
//           await MultipartFile.fromFile(
//             checkFile!.path,
//             filename: checkFile!.path.split('/').last.toString(),
//           ),
//         ));
//       }
//       if (gstFile != null) {
//         formData.files.add(MapEntry(
//           "gst_image",
//           await MultipartFile.fromFile(
//             gstFile!.path,
//             filename: gstFile!.path.split('/').last.toString(),
//           ),
//         ));
//       }
//
//       dio.interceptors.add(InterceptorsWrapper(onError: (DioError err, ErrorInterceptorHandler handler) async {
//         print("in dio interceptor->${err.response}");
//         if (err.response != null) {
//           var responseData = err.response!.data;
//           if (responseData['status'] == 400) {
//             var errorData = responseData['error'];
//             if (errorData['email_id'] != null) {
//               var errorMessage = errorData['email_id'][0];
//               loadingProgress = 0.0;
//               isSigningUp(false);
//               GetXSnackBarMsg.getWarningMsg('$errorMessage');
//             } else if (errorData['name'] != null) {
//               var errorMessage = errorData['name'][0];
//               loadingProgress = 0.0;
//               isSigningUp(false);
//               GetXSnackBarMsg.getWarningMsg('$errorMessage');
//             } else if (errorData['vendor_name'] != null) {
//               var errorMessage = errorData['vendor_name'][0];
//               loadingProgress = 0.0;
//               isSigningUp(false);
//               GetXSnackBarMsg.getWarningMsg('$errorMessage');
//             } else if (errorData['mobile'] != null) {
//               var errorMessage = errorData['mobile'][0];
//               loadingProgress = 0.0;
//               isSigningUp(false);
//               GetXSnackBarMsg.getWarningMsg('$errorMessage');
//             } else if (errorData['pincode'] != null) {
//               var errorMessage = errorData['pincode'][0];
//               loadingProgress = 0.0;
//               isSigningUp(false);
//               GetXSnackBarMsg.getWarningMsg('$errorMessage');
//             } else if (errorData['password'] != null) {
//               var errorMessage = errorData['password'][0];
//               loadingProgress = 0.0;
//               isSigningUp(false);
//               GetXSnackBarMsg.getWarningMsg('$errorMessage');
//             } else {
//               loadingProgress = 0.0;
//               isSigningUp(false);
//             }
//           } else {
//             loadingProgress = 0.0;
//             isSigningUp(false);
//           }
//         } else {
//           loadingProgress = 0.0;
//           isSigningUp(false);
//         }
//       }));
//       final response = await dio.post(
//         url,
//         data: formData,
//         options: Options(headers: {"Content-Type": "application/json"}),
//         onSendProgress: (int sent, int total) {
//           print('progress percentage: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');
//           double progress = (sent / total) * 100;
//           loadingProgress = progress;
//         },
//       );
//       final jsonData = response.data;
//       if (response.statusCode == 200) {
//         var bodyMSG = jsonData['message'];
//         GetXSnackBarMsg.getSuccessMsg('$bodyMSG');
//         storeLocation();
//         Get.to(SplashScreen());
//         loadingProgress = 0.0;
//         isSigningUp(false);
//       } else if (response.statusCode == 400) {
//         var errorData = jsonData;
//         if (errorData['error']['email_id'] != null) {
//           var errorMessage = errorData['error']['email_id'][0];
//           GetXSnackBarMsg.getWarningMsg('$errorMessage');
//         } else if (errorData['error']['name'] != null) {
//           var errorMessage = errorData['error']['name'][0];
//           GetXSnackBarMsg.getWarningMsg('$errorMessage');
//         } else if (errorData['error']['password'] != null) {
//           var errorMessage = errorData['error']['password'][0];
//           GetXSnackBarMsg.getWarningMsg('$errorMessage');
//         } else {
//           GetXSnackBarMsg.getWarningMsg(AppTextHelper().serverError);
//           Get.back();
//         }
//         Get.back();
//       } else {
//         GetXSnackBarMsg.getWarningMsg(AppTextHelper().internalServerError);
//         Get.back();
//       }
//     } catch (e) {
//       print('Error -> ${e.toString()}');
//       GetXSnackBarMsg.getWarningMsg(AppTextHelper().internalServerError);
//       Get.back();
//     }
//   }
// }
