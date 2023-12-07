// ignore_for_file: use_build_context_synchronously, missing_return

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/File%20Picker/file_image_picker.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Getx%20Helper/patient_details_getx.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Widget%20Helper/appbar_helper.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../../App Helper/Backend Helper/Api Future/Location Future/location_future.dart';
import '../../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Backend Helper/Models/Cart Menu/mobile_number_model.dart';
import '../../../../App Helper/Backend Helper/Models/Location Model/area_model.dart';
import '../../../../App Helper/Backend Helper/Models/Location Model/branch_model.dart';
import '../../../../App Helper/Backend Helper/Models/Location Model/city_model.dart';
import '../../../../App Helper/Backend Helper/Models/Location Model/state_model.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';
import '../../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../../../App Helper/Getx Helper/location_getx.dart';
import '../../../../App Helper/Widget Helper/form_fields.dart';
import '../../../../App Helper/Widget Helper/gender_selection.dart';
import '../../../../App Helper/Widget Helper/location_selection.dart';
import '../../../Add To Cart/test_cart.dart';
import '../../../Notification Menu/notification_menu.dart';
import '../../Test Menu/thank_you_msg.dart';

class AttachPrescription extends StatefulWidget {
  const AttachPrescription({Key? key}) : super(key: key);

  @override
  State<AttachPrescription> createState() => _AttachPrescriptionState();
}

class _AttachPrescriptionState extends State<AttachPrescription> {

  final locationController = Get.put(LocationCall());
  final patientController = Get.put(PatientDetailsGetX());

  GetAccessToken getAccessToken = GetAccessToken();

  final emailId = TextEditingController();
  final address = TextEditingController();
  final pinCode = TextEditingController();
  final collectionDate = TextEditingController();
  final remark = TextEditingController();

  String? selectedGender;
  final pAge = TextEditingController();
  final pDob = TextEditingController();
  final pName = TextEditingController();
  final pMobile = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    collectionDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

    locationController.cityList.clear();
    locationController.areaList.clear();
    locationController.branchList.clear();

    Future.delayed(Duration(seconds: 1), () {
      functionCalling();
    });
  }

  void functionCalling()async{
    await patientController.fetchMobileList();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
    locationController.selectedState?.value = '';
    locationController.selectedCity?.value = '';
    locationController.selectedStateId?.value = '';
    locationController.selectedArea?.value = '';
    locationController.selectedBranch?.value = '';
    super.dispose();
  }

  List<File> prescriptionFiles = [];

  bool isTyping = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBarHelper(appBarLabel: 'Attach Prescription'),
            Divider(color: Colors.grey.withOpacity(0.5),thickness: 1),
            Expanded(
              child: locationController.stateLoading.value == false ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                              var prescriptionFileManager = await FileImagePicker().pickFileManager(context);
                                              setState(() {
                                                prescriptionFiles.add(prescriptionFileManager!);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.file_copy_rounded,
                                              color: Colors.black,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              var prescriptionCamera = await FileImagePicker().pickCamera(context);
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
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          //   child: Container(
                          //       height: MediaQuery.of(context).size.height / 12.h,
                          //       decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                          //       padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          //       child: TypeAheadFormField<MobileData>(
                          //         suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          //           elevation: 0,
                          //         ),
                          //         textFieldConfiguration: TextFieldConfiguration(
                          //           decoration: const InputDecoration(
                          //             hintStyle: TextStyle(
                          //               color: Colors.black54,
                          //               fontFamily: FontType.MontserratRegular,
                          //               fontSize: 14,
                          //             ),
                          //             hintText: ' Select mobile number',
                          //             border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                          //             contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                          //             suffixIcon: Icon(Icons.keyboard_arrow_down_rounded)
                          //           ),
                          //           keyboardType: TextInputType.number,
                          //           inputFormatters: [
                          //             FilteringTextInputFormatter.digitsOnly,
                          //           ],
                          //           style: const TextStyle(
                          //             fontFamily: FontType.MontserratMedium,
                          //             fontSize: 15,
                          //             letterSpacing: 1,
                          //             color: Colors.black87,
                          //           ),
                          //           controller: pMobile, // Assign the controller
                          //         ),
                          //         suggestionsCallback: (pattern) async {
                          //           return patientController.mobileList.where((item) => item.mobileNo!.toLowerCase().contains(pattern.toLowerCase()));
                          //         },
                          //         itemBuilder: (context, MobileData suggestion) {
                          //           return ListTile(
                          //             title: Text("${suggestion.mobileNo!}  - ${suggestion.name}",style: TextStyle(fontFamily: FontType.MontserratRegular),),
                          //           );
                          //         },
                          //         onSuggestionSelected: (MobileData suggestion) {
                          //           setState(() {
                          //             patientController.selectedMobileNo?.value = suggestion.encPharmacyPatientId;
                          //             getPatient(patientController.selectedMobileNo?.value);
                          //             pMobile.text = suggestion.mobileNo!; // Assign the selected mobile number to the controller's text property
                          //             isTyping = true;
                          //           });
                          //         },
                          //         validator: (value) {
                          //           if (value == null) {
                          //             return 'Select a mobile number';
                          //           }
                          //           return null;
                          //         },
                          //         onSaved: (value) => patientController.selectedMobileNo?.value = value!,
                          //       )
                          //   ),
                          // ),
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
                              _formKey.currentState?.validate();
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
                          SizedBox(height: 10.h),
                          Obx(() => LocationDropdowns(
                            items: locationController.stateList.where((state) => state!.stateName! != null).map((state) => state!.stateName!).toList(),
                            loading: locationController.stateLoading.value,
                            selectedItem: locationController.selectedState?.value,
                            label: "Select state",
                            onChanged: (newValue) {
                              final selectedStateObject = locationController.stateList.firstWhere(
                                    (state) => state!.stateName == newValue,
                                orElse: () => StateData(),
                              );
                              if (selectedStateObject != null) {
                                  locationController.cityList.clear();
                                  locationController.selectedCity?.value = '';
                                  locationController.areaList.clear();
                                  locationController.selectedArea?.value = '';
                                  locationController.branchList.clear();
                                  locationController.selectedBranch?.value = '';
                                  locationController.selectedState?.value = newValue!;
                                  locationController.selectedStateId?.value = selectedStateObject.id.toString();
                                locationController.fetchCityList(locationController.selectedStateId?.value);
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select a state';
                              }
                              return null;
                            },
                          ),),
                          SizedBox(height: 10.h),
                          Obx(() => LocationDropdowns(
                            items: locationController.cityList.where((city) => city!.cityName != null).map((city) => city!.cityName!).toList(),
                            loading: locationController.cityLoading.value,
                            selectedItem: locationController.selectedCity?.value,
                            label: "Select city",
                            onChanged: (newValue) {
                              final selectedCityObject = locationController.cityList.firstWhere(
                                    (city) => city!.cityName == newValue,
                                orElse: () => CityData(), // Return an empty instance of StateData
                              );
                              if (selectedCityObject != null) {
                                  locationController.selectedCity?.value = '';
                                  locationController.areaList.clear();
                                  locationController.selectedArea?.value = '';
                                  locationController.branchList.clear();
                                  locationController.selectedBranch?.value = '';
                                  locationController.selectedCity?.value = newValue!;
                                  locationController.selectedCityId?.value = selectedCityObject.id.toString();
                                locationController.fetchAreaList(locationController.selectedStateId?.value, locationController.selectedCityId?.value);
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select a city';
                              }
                              return null;
                            },
                          ),),
                          SizedBox(height: 10.h),
                          Obx(() => LocationDropdowns(
                            items: locationController.areaList.where((area) => area!.areaName != null).map((area) => area!.areaName!).toList(),
                            loading: locationController.areaLoading.value,
                            selectedItem: locationController.selectedArea?.value,
                            label: "Select area",
                            onChanged: (newValue) {
                              final selectedAreaObject = locationController.areaList.firstWhere(
                                    (area) => area!.areaName == newValue,
                                orElse: () => AreaData(), // Return an empty instance of StateData
                              );
                              if (selectedAreaObject != null) {
                                  locationController.branchList.clear();
                                  locationController.selectedBranch?.value = '';
                                  locationController.selectedArea?.value = newValue!;
                                  locationController.selectedAreaId?.value = selectedAreaObject.id.toString();
                                  locationController.fetchBranchList(
                                      locationController.selectedStateId?.value,
                                      locationController.selectedCityId?.value,
                                      locationController.selectedAreaId?.value
                                  );
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select a area';
                              }
                              return null;
                            },
                          ),),
                          SizedBox(height: 10.h),
                          Obx(() => LocationDropdowns(
                            items: locationController.branchList.where((branch) => branch!.branchName != null).map((branch) => branch!.branchName!).toList(),
                            loading: locationController.branchLoading.value,
                            selectedItem: locationController.selectedBranch?.value,
                            label: "Select branch",
                            onChanged: (newValue) {
                              final selectedBranchObject = locationController.branchList.firstWhere(
                                    (branch) => branch!.branchName == newValue,
                                orElse: () => BranchData(), // Return an empty instance of StateData
                              );
                              if (selectedBranchObject != null) {
                                  locationController.selectedBranch?.value = newValue!;
                                  locationController.selectedBranchId?.value = selectedBranchObject.id.toString();
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select a branch';
                              }
                              return null;
                            },
                          ),),
                          SizedBox(height: 10.h),
                          FormTextField(
                            controller: collectionDate,
                            label: " Collection date",
                            mandatoryIcon: '',
                            readOnly: true,
                            prefixIcon: Icons.date_range_rounded,
                          ),
                          FormTextField(
                            controller: remark,
                            label: " Remark",
                            mandatoryIcon: '',
                            readOnly: false,
                            prefixIcon: Icons.note_add_rounded,
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                            child: InkWell(
                              onTap: ()async{
                                if(pName.text.isEmpty){
                                  GetXSnackBarMsg.getWarningMsg(AppTextHelper().patientName);
                                }
                                else if(pMobile.text.isEmpty){
                                  GetXSnackBarMsg.getWarningMsg(AppTextHelper().patientMobile);
                                }
                                else if(locationController.selectedState?.value == null || locationController.selectedState?.value == ''){
                                  GetXSnackBarMsg.getWarningMsg(AppTextHelper().selectState);
                                }
                                else if(locationController.selectedCity?.value == null || locationController.selectedCity?.value == ''){
                                  GetXSnackBarMsg.getWarningMsg(AppTextHelper().selectCity);
                                }
                                else if(locationController.selectedArea?.value == null || locationController.selectedArea?.value == ''){
                                  GetXSnackBarMsg.getWarningMsg(AppTextHelper().selectArea);
                                }
                                else if(locationController.selectedBranch?.value == null || locationController.selectedBranch?.value == ''){
                                  GetXSnackBarMsg.getWarningMsg(AppTextHelper().selectBranch);
                                }
                                else if(prescriptionFiles.isEmpty){
                                  GetXSnackBarMsg.getWarningMsg('Please select prescription');
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
                                  await attachPrescription();
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
                  ],
                ),
              ) : const CenterLoading(),
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

      locationController.selectedState?.value = pModel.patientData!.state!.stateName.toString();
      locationController.selectedCity?.value = pModel.patientData!.city!.cityName.toString();
      locationController.selectedArea?.value = pModel.patientData!.area!.areaName.toString();

      locationController.selectedStateId?.value = pModel.patientData!.state!.id.toString();
      locationController.selectedCityId?.value = pModel.patientData!.city!.id.toString();
      locationController.selectedAreaId?.value = pModel.patientData!.area!.id.toString();

      if(locationController.selectedStateId?.value != null){
        locationController.fetchCityList(locationController.selectedStateId?.value).then((value){
          locationController.fetchAreaList(locationController.selectedStateId?.value, locationController.selectedCityId?.value).then((value){
            locationController.fetchBranchList(locationController.selectedStateId?.value, locationController.selectedCityId?.value, locationController.selectedAreaId?.value);
          });
        });
      }

    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> attachPrescription() async {
    final pGender = selectedGender == 'Male' ? 1 : selectedGender == 'Female' ? 2 : selectedGender == 'Other' ? 3 : 0;

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };

    final Map<String, dynamic> requestBody = {
      "pharmacy_patient_id": patientController.selectedMobileNo?.value ?? '',
      "collection_date": collectionDate.text ?? '',
      "remark": remark.text ?? '',
      "name": pName.text ?? '',
      "email_id": emailId.text ?? '',
      "mobile_no": pMobile.text ?? '',
      "gender": '$pGender',
      "age": pAge.text ?? '',
      "state_id": locationController.selectedStateId?.value ?? '',
      'city_id': locationController.selectedCityId?.value ?? '',
      'area_id': locationController.selectedAreaId?.value ?? '',
      'cost_center_id': locationController.selectedBranchId?.value ?? '',
      'address': address.text ?? '',
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.attachPrescriptionUrls));
      request.headers.addAll(headers);

      requestBody.forEach((key, value) {
        request.fields[key] = value.toString();
      });
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

      var response = await request.send();
      log('----->>>>${response.statusCode} <<<<-----');
      var responseData = await response.stream.bytesToString();

      var parsedResponse = json.decode(responseData);
      var bodyStatus = parsedResponse['status'];
      var bodyMsg = parsedResponse['message'];
      if (bodyStatus == 200) {
        GetXSnackBarMsg.getSuccessMsg('$bodyMsg');
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
        locationController.selectedState?.value = '';
        locationController.selectedCity?.value = '';
        locationController.selectedArea?.value = '';
        locationController.selectedBranch?.value = '';
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ThankYouPage()));
      }
      else if (bodyStatus == 400) {
        var errorMessage = parsedResponse['error']['mobile_no'][0];
        GetXSnackBarMsg.getWarningMsg('$errorMessage');
        Navigator.pop(context);
      }
      else if(bodyStatus == 400){
        var errorMessage = parsedResponse['data']['prescription[]'][0];
        GetXSnackBarMsg.getWarningMsg('$errorMessage');
        Navigator.pop(context);
      }
      else if(response.statusCode == 500){
        GetXSnackBarMsg.getWarningMsg(AppTextHelper().internalServerError);
        Navigator.pop(context);
      }
      else{
        GetXSnackBarMsg.getWarningMsg(AppTextHelper().serverError);
        Navigator.pop(context);
      }
    } catch (error) {
      print("Error: $error");
      GetXSnackBarMsg.getWarningMsg(AppTextHelper().serverError);
      Navigator.pop(context);
    }
  }
}
