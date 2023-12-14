// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/getx_snackbar_msg.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../App Helper/Backend Helper/Api Future/Location Future/location_future.dart';
import '../../../App Helper/Backend Helper/Api Future/Profile Future/profile_future.dart';
import '../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../App Helper/Backend Helper/Device Info/device_info.dart';
import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Backend Helper/Models/Cart Menu/mobile_number_model.dart';
import '../../../App Helper/Backend Helper/Models/Location Model/area_model.dart';
import '../../../App Helper/Backend Helper/Models/Location Model/branch_model.dart';
import '../../../App Helper/Backend Helper/Models/Location Model/city_model.dart';
import '../../../App Helper/Backend Helper/Models/Location Model/state_model.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../../App Helper/Getx Helper/location_getx.dart';
import '../../../App Helper/Getx Helper/patient_details_getx.dart';
import '../../../App Helper/Widget Helper/form_fields.dart';
import '../../../App Helper/Widget Helper/gender_selection.dart';
import '../../../App Helper/Widget Helper/location_selection.dart';
import 'thank_you_msg.dart';

class TestMenu extends StatefulWidget {
  const TestMenu({Key? key}) : super(key: key);

  @override
  State<TestMenu> createState() => _TestMenuState();
}

class _TestMenuState extends State<TestMenu> {

  final locationController = Get.put(LocationCall());
  final patientController = Get.put(PatientDetailsGetX());

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

  bool stateLoading = false;
  bool cityLoading = false;
  bool areaLoading = false;
  bool branchLoading = false;

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    retrieveDeviceToken();
    collectionDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        getUserStatus();
      });
    });
    functionCalling();
  }

  void functionCalling()async{
    await patientController.fetchMobileList();
  }

  final _formKey = GlobalKey<FormState>();

  var userStatus;
  var deviceToken;
  void getUserStatus()async{
    try{
      dynamic userData = await ProfileFuture().fetchProfile(getAccessToken.access_token);
      if (userData != null && userData.data != null) {
        setState(() {
          userStatus = userData.data.status;
        });
        if (userStatus == 0) {
          print("in if userStatus->$userStatus");
        }
      } else {
        print('Failed to fetch user: User data is null');
      }
      print("userStatus ==>>$userStatus");
    }
    catch(e){
      print("get User Status Error->$e");
      if (e.toString().contains('402')) {
        DeviceInfo().logoutUser(context, deviceToken, getAccessToken.access_token);
      }
    }
  }
  Future<void> retrieveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      deviceToken = prefs.getString('deviceToken');
    });
    log("SharedPreferences DeviceToken->$deviceToken");
  }

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

  bool isTyping = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: stateLoading == false ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
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
                        setState(() {
                          locationController.cityList.clear();
                          locationController.selectedCity?.value = '';
                          locationController.areaList.clear();
                          locationController.selectedArea?.value = '';
                          locationController.branchList.clear();
                          locationController.selectedBranch?.value = '';
                          locationController.selectedState?.value = newValue!;
                          locationController.selectedStateId?.value = selectedStateObject.id.toString();
                        });
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
                        setState(() {
                          locationController.selectedCity?.value = '';
                          locationController.areaList.clear();
                          locationController.selectedArea?.value = '';
                          locationController.branchList.clear();
                          locationController.selectedBranch?.value = '';
                          locationController.selectedCity?.value = newValue!;
                          locationController.selectedCityId?.value = selectedCityObject.id.toString();
                          //fetchBranchList(selectedStateId, selectedCityId, '');
                        });
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
                        setState(() {
                          locationController.branchList.clear();
                          locationController.selectedBranch?.value = '';
                          locationController.selectedArea?.value = newValue!;
                          locationController.selectedAreaId?.value = selectedAreaObject.id.toString();
                          locationController.fetchBranchList(
                              locationController.selectedStateId?.value,
                              locationController.selectedCityId?.value,
                              locationController.selectedAreaId?.value
                          );
                        });
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
                        setState(() {
                          locationController.selectedBranch?.value = newValue!;
                          locationController.selectedBranchId?.value = selectedBranchObject.id.toString();
                        });
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
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                    child: InkWell(
                      onTap: ()async{
                        if(userStatus == 0){
                          GetXSnackBarMsg.getWarningMsg(AppTextHelper().inAccount);
                        }
                        else if (userStatus == 1){
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
                            await instantBooking();
                          }
                        }
                        else{
                          GetXSnackBarMsg.getWarningMsg(AppTextHelper().userNotFound);
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
          ) : const CenterLoading(),
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

  Future<void> instantBooking() async {
    final pGender =
    selectedGender == 'Male' ? 1 : selectedGender == 'Female' ? 2 : selectedGender == 'Other' ? 3 : 0;

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
      var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.instantBookingUrls));
      request.headers.addAll(headers);
      requestBody.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      var parsedResponse = json.decode(responseData);
      print("response -> $parsedResponse");

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
      } else if (bodyStatus == 400) {
        var msg = parsedResponse['error']['mobile_no'][0];
        GetXSnackBarMsg.getWarningMsg('$msg');
        Navigator.pop(context);
      }
      else if(response.statusCode == 500){
        GetXSnackBarMsg.getWarningMsg(AppTextHelper().internalServerError);
        Navigator.pop(context);
      }
      else if (bodyStatus == '402') {
        var msg = parsedResponse['message'];
        GetXSnackBarMsg.getWarningMsg('$msg');
        Navigator.pop(context);
      }
      else {
        GetXSnackBarMsg.getWarningMsg(AppTextHelper().serverError);
        Navigator.pop(context);
      }
    } catch (error) {
      print("Error: $error");
      GetXSnackBarMsg.getWarningMsg(AppTextHelper().serverError);
    }
  }
}
