// ignore_for_file: use_build_context_synchronously, void_checks

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Cart%20Future/cart_future.dart';
import '../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Backend Helper/Models/Cart Menu/mobile_number_model.dart';
import '../../App Helper/Frontend Helper/File Picker/file_image_picker.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../App Helper/Getx Helper/patient_details_getx.dart';
import '../../App Helper/Getx Helper/user_status_check.dart';
import '../../App Helper/Widget Helper/form_fields.dart';
import '../../App Helper/Widget Helper/gender_selection.dart';
import '../Bottom Menus/Test Menu/thank_you_msg.dart';

class TestBookingScreen extends StatefulWidget {
  var testDis,packageDis,profileDis,promoApply;
  var dStateId,dCityId,dAreaId,dBranchId,dStateNm,dCityNm,dAreaNm,dBranchNm;
  var locationType;
  TestBookingScreen({Key? key,this.testDis,this.packageDis,this.profileDis,this.promoApply,
  this.dStateId,this.dCityId,this.dAreaId,this.dBranchId,this.dStateNm,this.dCityNm,this.dAreaNm,this.dBranchNm,
    this.locationType
  }) : super(key: key);

  @override
  State<TestBookingScreen> createState() => _TestBookingScreenState();
}

class _TestBookingScreenState extends State<TestBookingScreen> {

  final patientController = Get.put(PatientDetailsGetX());
  final userController = Get.put(UserStatusCheckController());

  bool addVendor = false;
  File? fileManger;

  final emailId = TextEditingController();
  final address = TextEditingController();
  final pinCode = TextEditingController();
  final collectionDate = TextEditingController();
  final collectionTime = TextEditingController();
  final remark = TextEditingController();

  String? selectedGender;
  final pAge = TextEditingController();
  final pDob = TextEditingController();
  final pName = TextEditingController();
  final pMobile = TextEditingController();

  List<File> prescriptionFiles = [];
  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    collectionDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    functionCalling();
  }
  void functionCalling()async{
    await patientController.fetchMobileList();
  }

  final _bookingFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    clearData();
    Get.delete<UserStatusCheckController>();
    super.dispose();
  }

  bool isTyping = false;
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final initialTime = TimeOfDay(hour: now.hour, minute: now.minute).replacing(hour: now.hour + 1);
    collectionTime.text = initialTime.format(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Row(
                children: [
                  IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_rounded,color: Colors.black,size: 24)),
                  Text("Booking Form",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16.sp,letterSpacing: 0.5),)
                ],
              ),
            ),
            Divider(color: Colors.grey.withOpacity(0.5),thickness: 1),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _bookingFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: Container(
                              height: MediaQuery.of(context).size.height / 12.h,
                              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                              child: TypeAheadFormField<MobileData>(
                                textFieldConfiguration: TextFieldConfiguration(
                                  decoration: const InputDecoration(
                                    //labelText: 'Select mobile number',
                                    label: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Select mobile number"),
                                        Text(" *", style: TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: FontType.MontserratRegular,
                                      fontSize: 14,
                                    ),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  style: const TextStyle(
                                    fontFamily: FontType.MontserratMedium,
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    color: Colors.black87,
                                  ),
                                  controller: pMobile, // Assign the controller
                                ),
                                suggestionsCallback: (pattern) async {
                                  if(isTyping){
                                    return patientController.mobileList.where((item) => item.mobileNo!.toLowerCase().contains(pattern.toLowerCase()));
                                  }
                                  else{
                                    if(pMobile.text.isNotEmpty){
                                      return patientController.mobileList.where((item) => item.mobileNo!.toLowerCase().contains(pattern.toLowerCase()));
                                    }
                                    else{
                                      return [];
                                    }
                                  }
                                },
                                itemBuilder: (context, MobileData suggestion) {
                                  return ListTile(
                                    title: Text("${suggestion.mobileNo!}  - ${suggestion.name}",style: TextStyle(fontFamily: FontType.MontserratRegular),),
                                  );
                                },
                                onSuggestionSelected: (MobileData suggestion) {
                                  setState(() {
                                    patientController.selectedMobileNo?.value = suggestion.encPharmacyPatientId;
                                    getPatient(patientController.selectedMobileNo?.value);
                                    pMobile.text = suggestion.mobileNo!; // Assign the selected mobile number to the controller's text property
                                    isTyping = true;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Select a mobile number';
                                  }
                                  return null;
                                },
                                onSaved: (value) => patientController.selectedMobileNo?.value = value!,
                              )
                          ),
                        ),

                        FormTextField(
                          controller: pName,
                          label: ' Patient name',
                          mandatoryIcon: ' *',
                          readOnly: false,
                          prefixIcon: Icons.person,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Enter patient name';
                            }
                            return null;
                          },
                        ),
                        FormTextField(
                          controller: pAge,
                          label: " Age",
                          mandatoryIcon: '',
                          maxLength: 3,
                          readOnly: false,
                          prefixIcon: Icons.view_agenda_rounded,
                          keyboardType: TextInputType.number,
                        ),
                        FormTextField(
                          controller: emailId,
                          label: " Email id",
                          mandatoryIcon: '',
                          readOnly: false,
                          prefixIcon: Icons.email,
                          onChanged: (value) {
                            _bookingFormKey.currentState?.validate();
                          },
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (!value.contains('@')) {
                                return 'Email id must contain "@" symbol';
                              }
                            }
                            return null;
                          },
                        ),
                        FormTextField(
                          controller: address,
                          label: " Address",
                          mandatoryIcon: '',
                          readOnly: false,
                          prefixIcon: Icons.location_city_rounded,

                        ),
                        SizedBox(height: 10.h),
                        GenderSelectionWidget(
                          onGenderSelected: (gender) {
                            setState(() {
                              selectedGender = gender;
                            });
                          },
                        ),

                        locationField('${widget.dStateNm == '' ? 'N/A' : widget.dStateNm}'),
                        locationField('${widget.dCityNm == '' ? 'N/A' : widget.dCityNm}'),
                        locationField('${widget.dAreaNm == '' ? 'N/A' : widget.dAreaNm}'),
                        locationField('${widget.dBranchNm == '' ? 'N/A': widget.dBranchNm}'),

                        FormTextField(
                          controller: collectionDate,
                          label: " Collection date",
                          mandatoryIcon: '',
                          readOnly: true,
                          prefixIcon: Icons.date_range_rounded,
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Upload prescription",
                                          style: TextStyle(fontFamily: FontType.MontserratMedium),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () async {
                                            var prescriptionFileManager = await FileImagePicker().pickPrescription();
                                            setState(() {
                                              prescriptionFiles.addAll(prescriptionFileManager!);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.file_copy_rounded,
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            var prescriptionCamera = await FileImagePicker().pickCamera();
                                            setState(() {
                                              prescriptionFiles.add(prescriptionCamera!);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.camera_alt_rounded,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height / 20,
                                      child: prescriptionFiles.isNotEmpty ? ListView.builder(
                                        itemCount: prescriptionFiles.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index){
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                                            child: Container(
                                              // margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                              decoration: BoxDecoration(
                                                  color: hsPrime,
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                              child: GestureDetector(
                                                onTap: (){
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context){
                                                        return Dialog(
                                                          child: Image.file(prescriptionFiles[index]),
                                                        );
                                                      }
                                                  );
                                                },
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        prescriptionFiles[index].path.split('/').last,
                                                        style: const TextStyle(fontFamily: FontType.MontserratLight,color: Colors.white)
                                                    ),
                                                    const SizedBox(width: 10),
                                                    IconButton(
                                                        onPressed: (){
                                                          setState(() {
                                                            prescriptionFiles.remove(prescriptionFiles[index]);
                                                          });
                                                        },
                                                        icon: const Icon(Icons.delete_rounded,color: Colors.white,)
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ) ;
                                        },
                                      ) : const Center(child: Text('No file chosen'),),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        FormTextField(
                          controller: remark,
                          label: " Remark",
                          mandatoryIcon: '',
                          readOnly: false,
                          prefixIcon: Icons.note_add_rounded,
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                          child: InkWell(
                            onTap: ()async{
                              if(userController.userStatus == 0){
                                GetXSnackBarMsg.getWarningMsg(AppTextHelper().inAccount);
                              }
                              else if(userController.userStatus == 1){
                                if(pName.text.isEmpty){
                                  GetXSnackBarMsg.getWarningMsg('${AppTextHelper().patientName}');
                                }
                                else if(pMobile.text.isEmpty){
                                  GetXSnackBarMsg.getWarningMsg('${AppTextHelper().patientMobile}');
                                }
                                else{
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return const Dialog(
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircularProgressIndicator(),
                                              SizedBox(height: 16.0),
                                              Text('Loading...'),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  await bookOrder();
                                }
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsPrime),
                              child: Text("Confirm Booking",style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white,fontSize: 18.sp,letterSpacing: 1)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  var pharmacyId;
  void getPatient(var patientId) async {
    try {
      var pModel = await CartFuture().fetchPatientProfile(getAccessToken.access_token, patientId);
      setState(() {
        pharmacyId = pModel.patientData!.pharmacyId.toString();
        pName.text = pModel.patientData!.name ?? '';
        pDob.text = pModel.patientData!.dateOfBirth ?? '';
        pAge.text = pModel.patientData!.age ?? '';
        pMobile.text = pModel.patientData!.mobileNo ?? '';
        emailId.text = pModel.patientData!.emailId ?? '';
        address.text = pModel.patientData!.address ?? '';
        selectedGender = pModel.patientData!.gender.toString() == '1' ? 'Male'
            : pModel.patientData!.gender.toString() == '2'
            ? 'Female'
            : pModel.patientData!.gender.toString() == '3'
            ? 'Other'
            : '';
        pinCode.text = pModel.patientData!.pincode.toString();
      });
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> bookOrder() async {
    final pGender = selectedGender == 'Male' ? 1 : selectedGender == 'Female' ? 2 : selectedGender == 'Other' ? 3 : 0;

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    final Map<String, dynamic> requestBody = {
      "pharmacy_patient_id": patientController.selectedMobileNo?.toString() ?? '',
      "pharmacy_id": pharmacyId?.toString() ?? '',
      "test_discount_id": '${widget.testDis ?? ''}',
      "package_discount_id": '${widget.packageDis ?? ''}',
      "profile_discount_id": '${widget.profileDis ?? ''}',
      "promo_offer_code": '${widget.promoApply ?? ''}',
      "collection_date": collectionDate.text ?? '',
      "collection_time": collectionTime.text ?? '',
      "remark": remark.text ?? '',
      "name": pName.text ?? '',
      "email_id": emailId.text ?? '',
      "mobile_no": pMobile.text ?? '',
      "gender": '$pGender',
      "age": pAge.text ?? '',
      "state_id": widget.dStateId ?? '',
      'city_id': widget.dCityId ?? '',
      'area_id': widget.dAreaId ?? '',
      'cost_center_id': widget.dBranchId ?? '',
      'address': address.text ?? '',
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.bookOrderUrls));
      request.headers.addAll(headers);
      requestBody.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      if(prescriptionFiles.isNotEmpty){
        await Future.forEach(
          prescriptionFiles, (file) async => {
          request.files.add(http.MultipartFile(
            'prescription[]',
            (http.ByteStream(file.openRead())).cast(),
            await file.length(), filename: file.path.split('/').last,
          ),
          )
        },
        );
      }else{
        log('---- >>> prescription[] not select');
      }
      var response = await request.send();

      log('----->>>>${response.statusCode} <<<<-----');
      var responsData = await response.stream.bytesToString();
      var responseData = json.decode(responsData);
      print("response -> $responseData");

      final bodyStatus = responseData['status'];
      final bodyMsg = responseData['message'];

      if (bodyStatus == 200) {
        GetXSnackBarMsg.getSuccessMsg('$bodyMsg');
        clearData();
        Get.delete<UserStatusCheckController>();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ThankYouPage()));
      }
      else if (bodyStatus == 400) {
        if (responseData['error'] != null) {
          if (responseData['error']['email_id'] != null) {
            final eMsg = responseData['error']['email_id'][0];
            GetXSnackBarMsg.getWarningMsg('$eMsg');
            Navigator.pop(context);
          } else if (responseData['error']['mobile_no'] != null) {
            final mMsg = responseData['error']['mobile_no'][0];
            GetXSnackBarMsg.getWarningMsg('$mMsg');
            Navigator.pop(context);
          } else if (responseData['error']['address'] != null) {
            final aMsg = responseData['error']['address'][0];
            GetXSnackBarMsg.getWarningMsg('$aMsg');
            Navigator.pop(context);
          }
          else if(bodyStatus == 400){
            var errorMessage = responseData['data']['prescription[]'][0];
            GetXSnackBarMsg.getWarningMsg('$errorMessage');
            Navigator.pop(context);
          }
          else {
            GetXSnackBarMsg.getWarningMsg(AppTextHelper().serverError);
            Navigator.pop(context);
          }
        }
      }
      else if(response.statusCode == 500){
        clearData();
        GetXSnackBarMsg.getWarningMsg(AppTextHelper().internalServerError);
        Navigator.pop(context);
      }
      else {
        clearData();
        GetXSnackBarMsg.getWarningMsg(AppTextHelper().serverError);
        Navigator.pop(context);
      }
    } catch (error) {
      clearData();
      GetXSnackBarMsg.getWarningMsg('${AppTextHelper().serverError}');
      Navigator.pop(context);
    }
  }

  Widget showTextField(var label, TextEditingController controller, IconData iconData, String? Function(String?) validator) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(hsPaddingM),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
              borderRadius: BorderRadius.circular(15)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
              borderRadius: BorderRadius.circular(15)
          ),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$label"),
              const Text(" *", style: TextStyle(color: Colors.red)),
            ],
          ),
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontFamily: FontType.MontserratRegular,
            fontSize: 14,
          ),
          prefixIcon: Icon(iconData, color: hsBlack, size: 20),
        ),
        validator: validator, // Set the validator function
      ),
    );
  }

  Widget locationField(var lName){
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(hsPaddingM),
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                borderRadius: BorderRadius.circular(15)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                borderRadius: BorderRadius.circular(15)
            ),
            hintText: '$lName',
            hintStyle: const TextStyle(
              color: Colors.black54,
              fontFamily: FontType.MontserratRegular,
              fontSize: 14,
            ),
          ),
        )
    );
  }

  void clearData(){
    patientController.selectedMobileNo?.value = '';
    selectedGender = '';
    remark.text = '';
    pName.text = '';
    emailId.text = '';
    pMobile.text = '';
    pDob.text = '';
    pAge.text = '';
    pinCode.text = '';
    address.text = '';
    widget.dStateNm = '';
    widget.dCityNm = '';
    widget.dAreaNm = '';
    widget.dBranchNm = '';
  }
}
