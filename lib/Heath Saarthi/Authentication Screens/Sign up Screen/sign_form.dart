//@dart=2.9
// ignore_for_file: use_build_context_synchronously, missing_return

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/File%20Picker/file_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../App Helper/Backend Helper/Api Future/Location Future/location_future.dart';
import '../../App Helper/Backend Helper/Models/Location Model/area_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/branch_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/city_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/state_model.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../Splash Screen/splash_screen.dart';

class SignUpForm extends StatefulWidget {
  var dType,dToken;
  SignUpForm({Key key,this.dType,this.dToken}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File panCardFile;
  File addressFile;
  File aadharCardFFile;
  File aadharCardBFile;
  File checkFile;
  File gstFile;

  bool panCardColor = false;
  bool aadhaarCardFColor = false;
  bool aadhaarCardBColor = false;
  bool addressColor = false;
  bool chequeColor = false;
  bool gstColor = false;

  bool stateLoading = false;
  bool cityLoading = false;
  bool areaLoading = false;
  bool branchLoading = false;

  FocusNode fNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode shopFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode pinCodeFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode cPasswordFocusNode = FocusNode();
  FocusNode panCardNoFocusNode = FocusNode();
  FocusNode bankNameFocusNode = FocusNode();
  FocusNode ifscCodeFocusNode = FocusNode();
  FocusNode accountNoFocusNode = FocusNode();

  final fullName = TextEditingController();
  final emailId = TextEditingController();
  final shopeName = TextEditingController();
  final mobile = TextEditingController();
  final address = TextEditingController();
  final seMobile = TextEditingController();
  bool showExecutive = false;
  final pincode = TextEditingController();
  final password = TextEditingController();
  final cPassword = TextEditingController();

  final panCardNo = TextEditingController();
  final bankName = TextEditingController();
  final ifscCode = TextEditingController();
  final accountNo = TextEditingController();
  final gstNo = TextEditingController();

  String selectedSales;
  String selectedB2b;
  var selectedSalesMobileNo;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        getB2bSalesList();
      });
    });
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        fetchStateList();
      });
    });
  }

  @override
  void dispose() {
    fNameFocusNode.dispose();
    emailFocusNode.dispose();
    mobileFocusNode.dispose();
    shopFocusNode.dispose();
    pinCodeFocusNode.dispose();
    addressFocusNode.dispose();
    panCardNoFocusNode.dispose();
    bankNameFocusNode.dispose();
    ifscCodeFocusNode.dispose();
    accountNoFocusNode.dispose();
    passwordFocusNode.dispose();
    cPasswordFocusNode.dispose();
    super.dispose();
  }

  bool obScured = true;
  void _togglePasswordView() {
    setState(() {
      obScured = !obScured;
    });
  }
  bool obCScured = true;
  void _toggleCPasswordView() {
    setState(() {
      obCScured = !obCScured;
    });
  }
  String getMobileNumber(String selectedName) {
    final selectedExecutive = salesExecutiveList.firstWhere(
          (executive) => executive['name'] == selectedName,
      orElse: () => null,
    );
    return selectedExecutive != null ? selectedExecutive['mobile_no'] : '';
  }
  bool isFirstNameFieldTouched = false;
  bool isVendorNameFieldTouched = false;
  bool _agreedToTOS = false;

  Future<void> storeStateCityAreaBranch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('signupStateId', selectedStateId);
    await prefs.setString('signupCityId', selectedCityId);
    await prefs.setString('signupAreaId', selectedAreaId);
    await prefs.setString('signupBranchId', selectedBranchId);
    await prefs.setString('signupStateName', selectedState);
    await prefs.setString('signupCityName', selectedCity);
    await prefs.setString('signupAreaName', selectedArea);
    await prefs.setString('signupBranchName', selectedBranch);
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? hsSpaceM : hsSpaceS;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: DropdownButtonFormField<String>(
                value: selectedB2b,
                style: const TextStyle(fontSize: 12,color: Colors.black87),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'B2B Sub Admin',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 12,
                  ),
                ),
                onChanged: (newValue) {
                  selectedB2b = newValue;
                },
                items: [
                  const DropdownMenuItem(
                    value: '',
                    child: Text('Select B2B subadmin'),
                  ),
                  ...b2bSubAdminList?.map((subAdmin) => DropdownMenuItem(
                    value: subAdmin['id'].toString(),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.5.w,
                        child: Text(subAdmin['name'])
                    ),
                  ))?.toList() ?? []
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                controller: fullName,
                focusNode: fNameFocusNode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Full name *',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.person, color: hsBlack, size: 20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter full name';
                  }
                  return null;
                }, // Set the validator function
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
               controller: emailId,
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Email id *',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.email_rounded, color: hsBlack, size: 20),
                ),
                onChanged: (value) {
                  if (value.contains(RegExp(r'[A-Z]')) && value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    // Password meets all the requirements
                  } else if (!value.contains('gmail.com')) {
                    // If the email does not contain 'gmail.com', show an error message
                    setState(() {
                      return 'Email id must contain "gmail.com"';
                    });
                  }else {
                    print('Enter valid email id');
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a email';
                  }
                  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    return 'email id must contain at least one special character';
                  }
                  return null;
                },// Set the validator function
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                controller: shopeName,
                focusNode: shopFocusNode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Shop name',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.person_pin, color: hsBlack, size: 20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter shop name';
                  }
                  return null;
                }, // Set the validator function
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: mobile,
                focusNode: mobileFocusNode,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 10,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Mobile no *',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.mobile_friendly, color: hsBlack, size: 20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter mobile number';
                  }
                  return null;
                }, // Set the validator function
              ),
            ),
            SizedBox(height: space),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.w,
                //height: MediaQuery.of(context).size.height / 14.h,
                child: Stack(
                  children: [
                    Visibility(
                      visible: stateLoading,
                      child: Positioned(
                        top: 10,
                        right: 5,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    DropdownSearch<String>(
                      mode: Mode.DIALOG,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      showSearchBox: true,
                      showSelectedItem: true,
                      items: stateList.where((state) => state.stateName != null).map((state) => state.stateName).toList(),
                      label: "Select state *",
                      onChanged: (newValue) {
                        final selectedStateObject = stateList.firstWhere((state) => state.stateName == newValue, orElse: () => null);
                        if (selectedStateObject != null) {
                          setState(() {
                            cityList.clear();
                            selectedCity = '';
                            areaList.clear();
                            selectedArea = '';
                            branchList.clear();
                            selectedBranch = '';
                            selectedState = newValue;
                            selectedStateId = selectedStateObject.id.toString();
                          });
                          fetchCityList(selectedStateId);
                        }
                      },
                      selectedItem: selectedState,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select a state';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: space),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.w,
                //height: MediaQuery.of(context).size.height / 14.h,
                child: Stack(
                  children: [
                    Visibility(
                      visible: cityLoading,
                      child: Positioned(
                        top: 10,
                        right: 5,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    DropdownSearch<String>(
                      mode: Mode.DIALOG,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      showSearchBox: true,
                      showSelectedItem: true,
                      items: cityList.where((city) => city.cityName != null).map((city) => city.cityName).toList(),
                      label: "Select city *",
                      onChanged: (newValue) {
                        final selectedCityObject = cityList.firstWhere((city) => city.cityName == newValue, orElse: () => null);
                        if (selectedCityObject != null) {
                          setState(() {
                            selectedCity = '';
                            areaList.clear();
                            selectedArea = '';
                            branchList.clear();
                            selectedBranch = '';
                            selectedCity = newValue;
                            selectedCityId = selectedCityObject.id.toString();
                            fetchBranchList(selectedStateId, selectedCityId, '');
                          });
                          fetchAreaList(selectedStateId, selectedCityId);
                        }
                      },
                      selectedItem: selectedCity,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select a city';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: space),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.w,
                //height: MediaQuery.of(context).size.height / 14.h,
                child: Stack(
                  children: [
                    Visibility(
                      visible: branchLoading,
                      child: Positioned(
                        top: 10,
                        right: 5,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    DropdownSearch<String>(
                      mode: Mode.DIALOG,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      showSearchBox: true,
                      showSelectedItem: true,
                      items: branchList?.map((branch) => branch.branchName)?.toList() ?? [],
                      label: "Select branch *",
                      onChanged: (newValue) {
                        final selectedBranchObject = branchList.firstWhere((branch) => branch.branchName  == newValue, orElse: () => null);
                        if (selectedBranchObject != null) {
                          setState(() {
                            selectedBranch = newValue;
                            selectedBranchId = selectedBranchObject.id.toString();
                          });
                        }
                      },
                      selectedItem: selectedBranch,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select a branch';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: space),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.w,
                //height: MediaQuery.of(context).size.height / 14.h,
                child: Stack(
                  children: [
                    Visibility(
                      visible: areaLoading,
                      child: Positioned(
                        top: 10,
                        right: 5,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    DropdownSearch<String>(
                      mode: Mode.DIALOG,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      showSearchBox: true,
                      showSelectedItem: true,
                      items: areaList?.map((area) => area.areaName)?.toList() ?? [],
                      label: "Select area *",
                      onChanged: (newValue) {
                        final selectedAreaObject = areaList.firstWhere((area) => area.areaName  == newValue, orElse: () => null);
                        if (selectedAreaObject != null) {
                          setState(() {
                            //branchList.clear();
                            //selectedBranch = '';
                            selectedArea = newValue;
                            selectedAreaId = selectedAreaObject.id.toString();
                            //fetchBranchList(selectedStateId, selectedCityId, selectedAreaId);
                          });
                        }
                      },
                      selectedItem: selectedArea,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select a area';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: DropdownButtonFormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: selectedSales,
                style: const TextStyle(fontSize: 10,color: Colors.black87),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Sales executive *',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select a sales executive';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    showExecutive = true;
                    selectedSales = newValue;
                    // Retrieve the selected executive using the ID
                    final selectedExecutive = salesExecutiveList.firstWhere(
                          (executive) => executive['id'].toString() == newValue,
                      orElse: () => null,
                    );
                    if (selectedExecutive != null) {
                      final selectedId = selectedExecutive['id'].toString();
                      selectedSalesMobileNo = selectedExecutive['mobile_no'];
                    }
                    seMobile.text = selectedSalesMobileNo;
                  });
                },
                items: salesExecutiveList?.map((sales) => DropdownMenuItem(
                  value: sales['id'].toString(),
                  child: Container(
                      width: MediaQuery.of(context).size.width / 1.45.w,
                      child: Text("${sales['name']} - ${sales['mobile_no']}")
                  ),
                ))?.toList() ?? [],
              ),
            ),

            SizedBox(height: space),
            Visibility(
              visible: showExecutive,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: seMobile,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(hsPaddingM),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    hintText: 'Executive mobile no',
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(Icons.mobile_friendly, color: hsBlack, size: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: pincode,
                focusNode: pinCodeFocusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Pincode',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.code_rounded, color: hsBlack, size: 20),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Enter pincode';
                //   }
                //   return null;
                // }, // Set the validator function
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height / 5,
              //color: Colors.green,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        children: [
                          aadharCardFFile == null
                            ? const Text("Aadhaar card front",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                            : Container(
                              width: 100,height: 50,
                              child: buildImageDialog(aadharCardFFile, 'Aadhaar card front')
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () async {
                              var aadhaarCardFrontFile = await FileImagePicker().pickFileManager(context);
                              setState(() {
                                aadharCardFFile = aadhaarCardFrontFile;
                              });
                            },
                            icon: const Icon(
                              Icons.file_copy_rounded
                            )
                          ),
                          IconButton(
                            onPressed: () async{
                              var aadhaarCardFrontCamera = await FileImagePicker().pickCamera(context);
                              setState(() {
                                aadharCardFFile = aadhaarCardFrontCamera;
                              });
                            },
                            icon: const Icon(
                                Icons.camera_alt_rounded
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        children: [
                          aadharCardBFile == null
                            ? const Text("Aadhaar card back",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                            : Container(
                              width: 100,height: 50,
                              child: buildImageDialog(aadharCardBFile, 'Aadhaar card back')
                              // GestureDetector(
                              //   onTap: () {
                              //     if (aadharCardBFile != null) {
                              //       showDialog(
                              //         context: context,
                              //         builder: (BuildContext context) {
                              //           return Dialog(
                              //             child: Image.file(File(aadharCardBFile.path)),
                              //           );
                              //         },
                              //       );
                              //     }
                              //   },
                              //   child: Image.file(File(aadharCardBFile.path), fit: BoxFit.cover),
                              // ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: ()async {
                              var aadhaarCardBack = await FileImagePicker().pickFileManager(context);
                              setState(() {
                                aadharCardBFile = aadhaarCardBack;
                              });
                            },
                            icon: const Icon(
                              Icons.file_copy_rounded
                            )
                          ),
                          IconButton(
                            onPressed: ()async{
                              var aadhaarCardBackCamera = await FileImagePicker().pickCamera(context);
                              setState(() {
                                aadharCardBFile = aadhaarCardBackCamera;
                              });
                            },
                            icon: const Icon(
                                Icons.camera_alt_rounded
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                controller: address,
                focusNode: addressFocusNode,
                minLines: 1,
                maxLines: 4,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Address *',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.location_city, color: hsBlack, size: 20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter address';
                  }
                  return null;
                }, // Set the validator function
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      addressFile == null
                       ? const Text("Address proof",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                       : Container(
                          width: 100,height: 50,
                           child: buildImageDialog(addressFile, 'Address proof')

                           // GestureDetector(
                           //   onTap: () {
                           //     if (addressFile != null) {
                           //       showDialog(
                           //         context: context,
                           //         builder: (BuildContext context) {
                           //           return Dialog(
                           //             child: Image.file(File(addressFile.path)),
                           //           );
                           //         },
                           //       );
                           //     }
                           //   },
                           //   child: Image.file(File(addressFile.path), fit: BoxFit.cover),
                           // ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: ()async {
                            var addressProof = await FileImagePicker().pickFileManager(context);
                            setState(() {
                              addressFile = addressProof;
                            });
                          },
                          icon: const Icon(
                              Icons.file_copy_rounded
                          )
                      ),
                      IconButton(
                          onPressed: () async{
                            var addressProofCamera = await FileImagePicker().pickCamera(context);
                            setState(() {
                              addressFile = addressProofCamera;
                            });
                          },
                          icon: const Icon(
                              Icons.camera_alt_rounded
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: panCardNo,
                  focusNode: panCardNoFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(hsPaddingM),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    hintText: 'Pancard number *',
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(Icons.numbers_rounded, color: hsBlack, size: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter pancard number';
                    }
                    return null;
                  } // Set the validator function
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      panCardFile == null
                       ? const Text("PAN card",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                       : Container(
                        width: 100,height: 50,
                        child: buildImageDialog(panCardFile, 'PAN card')
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: ()async {
                            var panCardFileManger = await FileImagePicker().pickFileManager(context);
                            setState(() {
                              panCardFile = panCardFileManger;
                            });
                          },
                          icon: const Icon(
                              Icons.file_copy_rounded
                          )
                      ),
                      IconButton(
                          onPressed: () async{
                            var panCardCamera = await FileImagePicker().pickCamera(context);
                            setState(() {
                              panCardFile = panCardCamera;
                            });
                          },
                          icon: const Icon(
                              Icons.camera_alt_rounded
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: gstNo,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'GST Number',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.confirmation_number_rounded, color: hsBlack, size: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      gstFile == null
                       ? const Text("GST img",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                       : Container(
                        width: 100,height: 50,
                        child: buildImageDialog(gstFile, 'GST file')

                        // GestureDetector(
                        //   onTap: () {
                        //     if (gstFile != null) {
                        //       showDialog(
                        //         context: context,
                        //         builder: (BuildContext context) {
                        //           return Dialog(
                        //             child: Image.file(File(gstFile.path)),
                        //           );
                        //         },
                        //       );
                        //     }
                        //   },
                        //   child: Image.file(File(gstFile.path), fit: BoxFit.cover),
                        // ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: ()async {
                            var gstFileManger = await FileImagePicker().pickFileManager(context);
                            setState(() {
                              gstFile = gstFileManger;
                            });
                          },
                          icon: const Icon(
                              Icons.file_copy_rounded
                          )
                      ),
                      IconButton(
                          onPressed: () async{
                            var gstFileCamera = await FileImagePicker().pickCamera(context);
                            setState(() {
                              gstFile = gstFileCamera;
                            });
                          },
                          icon: const Icon(
                              Icons.camera_alt_rounded
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                controller: bankName,
                focusNode: bankNameFocusNode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Bank name',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.account_balance_rounded, color: hsBlack, size: 20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter bank name';
                  }
                  return null;
                }, // Set the validator function
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: ifscCode,
                  focusNode: ifscCodeFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(hsPaddingM),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    hintText: 'IFSC code *',
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(Icons.code_rounded, color: hsBlack, size: 20),
                  ),
                  // onChanged: (value){
                  //   if (value.length < 12) {
                  //     print('Pancard length is less than 10 characters.');
                  //   }
                  //   if (!value.contains(RegExp(r'[0-9]'))) {
                  //     print('Pancard does not contain a digit.');
                  //   }
                  // },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter IFSC code';
                    }
                    return null;
                  } // Set the validator function
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      checkFile == null
                        ? const Text("Cheque img",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                        : Container(
                        width: 100,height: 50,
                        child: buildImageDialog(checkFile, 'Cheque img')

                        // GestureDetector(
                        //   onTap: () {
                        //     if (checkFile != null) {
                        //       showDialog(
                        //         context: context,
                        //         builder: (BuildContext context) {
                        //           return Dialog(
                        //             child: Image.file(File(checkFile.path)),
                        //           );
                        //         },
                        //       );
                        //     }
                        //   },
                        //   child: Image.file(File(checkFile.path), fit: BoxFit.cover),
                        // ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: ()async {
                            var chequeFileManger = await FileImagePicker().pickFileManager(context);
                            setState(() {
                              checkFile = chequeFileManger;
                            });
                          },
                          icon: const Icon(
                              Icons.file_copy_rounded
                          )
                      ),
                      IconButton(
                          onPressed: () async{
                            var chequeFileCamera = await FileImagePicker().pickCamera(context);
                            setState(() {
                              checkFile = chequeFileCamera;
                            });
                          },
                          icon: const Icon(
                              Icons.camera_alt_rounded
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: accountNo,
                  focusNode: accountNoFocusNode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(hsPaddingM),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                    ),
                    hintText: 'Account number *',
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(Icons.account_balance_wallet_rounded, color: hsBlack, size: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter account number';
                    }
                    return null;
                  } // Set the validator function
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: password,
                focusNode: passwordFocusNode,
                obscureText: obScured,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Password *',
                  hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14
                  ),
                  prefixIcon: const Icon(Icons.lock_open_rounded, color: hsBlack,size: 20),
                  suffixIcon: InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(
                      obScured
                          ?
                      Icons.visibility_off_rounded
                          :
                      Icons.visibility_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.length >= 8 && value.contains(RegExp(r'[A-Z]')) &&
                      value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) && value.contains(RegExp(r'[0-9]'))) {
                    // Password meets all the requirements
                  } else {
                    print('Password does not meet the requirements.');
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a password';
                  }
                  if (value.trim().length < 8) {
                    return 'Password must be at least 8 characters in length';
                  }
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    return 'Password must contain at least one special character';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: cPassword,
                focusNode: cPasswordFocusNode,
                obscureText: obCScured,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Confirm password *',
                  hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14
                  ),
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: hsBlack,size: 20),
                  suffixIcon: InkWell(
                    onTap: _toggleCPasswordView,
                    child: Icon(
                      obCScured
                          ?
                      Icons.visibility_off_rounded
                          :
                      Icons.visibility_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.length >= 8 && value.contains(RegExp(r'[A-Z]')) &&
                      value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) && value.contains(RegExp(r'[0-9]'))) {
                    // Password meets all the requirements
                  } else {
                    print('Password does not meet the requirements.');
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a password';
                  }
                  if (value.trim().length < 8) {
                    return 'Password must be at least 8 characters in length';
                  }
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    return 'Password must contain at least one special character';
                  }
                  if (value != password.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: _agreedToTOS,
                    onChanged: _setAgreedToTOS,
                  ),
                  GestureDetector(
                    onTap: () => _setAgreedToTOS(!_agreedToTOS),
                    child: const Text(
                      'I agree to the Terms of Condition and \nPrivacy Policy',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: InkWell(
                onTap: ()async{
                  if (_formKey.currentState.validate()) {
                    FocusScope.of(context).unfocus();
                    if(selectedState == null || selectedCity == null || selectedArea == null || selectedState == '' || selectedCity == '' || selectedArea == ''){
                      SnackBarMessageShow.warningMSG("Please select location fields", context);
                    }
                    else if(panCardFile == null){
                      SnackBarMessageShow.warningMSG("Please select pancard", context);
                    }
                    else if(addressFile == null){
                      SnackBarMessageShow.warningMSG("Please select address proof", context);
                    }
                    else if(aadharCardFFile == null){
                      SnackBarMessageShow.warningMSG("Please select aadhaar card front", context);
                    }
                    else if(aadharCardBFile == null){
                      SnackBarMessageShow.warningMSG("Please select aadhaar card back", context);
                    }
                    else if(checkFile == null){
                      SnackBarMessageShow.warningMSG("Please select cheque img", context);
                    }
                    else if(_agreedToTOS == false){
                      SnackBarMessageShow.warningMSG('Please select term & condition', context);
                    }
                    else{
                      setState(() {
                        isSigningUp = true;
                      });
                      await signUpData();
                      setState(() {
                        isSigningUp = false;
                      });
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsBlack),
                  alignment: Alignment.center,
                  child: isSigningUp == true
                      ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Processing : ${loadingProgress.toStringAsFixed(1)}%',style: TextStyle(color: Colors.white),),
                          SizedBox(width: 15),
                          CircularProgressIndicator(color: Colors.white),
                        ],
                      ) // Show loading indicator
                      : const Text(
                    "Create an account",
                    style: TextStyle(
                      fontFamily: FontType.MontserratMedium,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: space),
          ],
        ),
      ),
    );
  }
  GestureDetector buildImageDialog(File selectedFilePhoto, var label) {
    return GestureDetector(
      onTap: () {
        if (selectedFilePhoto != null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: Image.file(selectedFilePhoto),
              );
            },
          );
        }
      },
      child: selectedFilePhoto == null
          ? Text("$label", style: TextStyle(fontFamily: FontType.MontserratMedium))
          : Image.file(selectedFilePhoto, fit: BoxFit.cover),
    );
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
  Widget showTextField(var label, TextEditingController controller, IconData iconData, String Function(String) validator) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(hsPaddingM),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
          ),
          hintText: '$label',
          hintStyle: const TextStyle(
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

  double loadingProgress = 0.0;
  bool isSigningUp = false;
  showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState){
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16.0),
                    Text('Loading...'),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
  void signUpData() async {
    final dio = Dio();
    var url = ApiUrls.signUpUrl;
    try {
      var formData = FormData();
      formData.fields.addAll([
        MapEntry("name", fullName.text),
        MapEntry("email_id", emailId.text),
        MapEntry("password", password.text),
        MapEntry("mobile", mobile.text),
        MapEntry("vendor_name", shopeName.text),
        MapEntry("state_id", selectedStateId),
        MapEntry("city_id", selectedCityId),
        MapEntry("area_id", selectedAreaId),
        MapEntry("cost_center_id", selectedBranchId),
        MapEntry("address", address.text),
        MapEntry("pincode", pincode.text),
        MapEntry("pancard_number", panCardNo.text),
        MapEntry("sales_executive_admin_id", selectedSales ?? ''),
        MapEntry("b2b_subadmin_id", selectedB2b ?? ''),
        MapEntry("bank_name", bankName.text ?? ''),
        MapEntry("ifsc", ifscCode.text ?? ''),
        MapEntry("account_number", accountNo.text ?? ''),
        MapEntry("gst_number", gstNo.text ?? ''),
      ]);
      if (panCardFile != null) {
        formData.files.add(MapEntry(
          "pancard",
          await MultipartFile.fromFile(
            panCardFile.path,
            filename: 'pancard.jpg',
          ),
        ));
      }
      if (addressFile != null) {
        formData.files.add(MapEntry(
          "address_proof",
          await MultipartFile.fromFile(
            addressFile.path,
            filename: 'address_proof.jpg',
          ),
        ));
      }
      if (aadharCardFFile != null) {
        formData.files.add(MapEntry(
          "aadhar_front",
          await MultipartFile.fromFile(
            aadharCardFFile.path,
            filename: 'aadhar_front.jpg',
          ),
        ));
      }
      if (aadharCardBFile != null) {
        formData.files.add(MapEntry(
          "aadhar_back",
          await MultipartFile.fromFile(
            aadharCardBFile.path,
            filename: 'aadhar_back.jpg',
          ),
        ));
      }
      if (checkFile != null) {
        formData.files.add(MapEntry(
          "cheque_image",
          await MultipartFile.fromFile(
            checkFile.path,
            filename: 'cheque_image.jpg',
          ),
        ));
      }
      if (gstFile != null) {
        formData.files.add(MapEntry(
          "gst_image",
          await MultipartFile.fromFile(
            gstFile.path,
            filename: 'gst_image.jpg',
          ),
        ));
      }
      dio.interceptors.add(InterceptorsWrapper(
       onError: (DioError err, ErrorInterceptorHandler handler) async {
         print("in dio interceptor->${err.response}");
         if (err.response != null) {
           var responseData = err.response.data;
           if (responseData['status'] == 400) {
             var errorData = responseData['error'];
             if (errorData['email_id'] != null) {
               var errorMessage = errorData['email_id'][0];
               print("errorMessage->$errorMessage");
               setState(() {
                 loadingProgress = 0.0;
                 isSigningUp = false;
               });
               SnackBarMessageShow.warningMSG('$errorMessage', context);
               //Navigator.pop(context);
             }
             else if (errorData['mobile'] != null) {
               var errorMessage = errorData['mobile'][0];
               print("errorMessage->$errorMessage");
               setState(() {
                 loadingProgress = 0.0;
                 isSigningUp = false;
               });
               SnackBarMessageShow.warningMSG(errorMessage, context);
               //Navigator.pop(context);
             }
             else if (errorData['pincode'] != null) {
               var errorMessage = errorData['pincode'][0];
               print("errorMessage->$errorMessage");
               setState(() {
                 loadingProgress = 0.0;
                 isSigningUp = false;
               });
               SnackBarMessageShow.warningMSG(errorMessage, context);
               //Navigator.pop(context);
             }
             else if (errorData['name'] != null) {
               var errorMessage = errorData['name'][0];
               print("errorMessage->$errorMessage");
               setState(() {
                 loadingProgress = 0.0;
                 isSigningUp = false;
               });
               SnackBarMessageShow.warningMSG(errorMessage, context);
               //Navigator.pop(context);
             }
             else if (errorData['password'] != null) {
               var errorMessage = errorData['password'][0];
               print("error Msg->$errorMessage");
               setState(() {
                 loadingProgress = 0.0;
                 isSigningUp = false;
               });
               SnackBarMessageShow.warningMSG('$errorMessage', context);
               //Navigator.pop(context);
             } else {
               print("in sub sub else");
               setState(() {
                 loadingProgress = 0.0;
                 isSigningUp = false;
               });
             }
           } else {
            print("in sub else");
            setState(() {
              loadingProgress = 0.0;
              isSigningUp = false;
            });
           }
         } else {
           print("in main else");
           setState(() {
             loadingProgress = 0.0;
             isSigningUp = false;
           });
         }
       }));
      final response = await dio.post(
        url,
        data: formData,
        options: Options(headers: {"Content-Type":"application/json"}),
        onSendProgress: (int sent, int total) {
          print('progress percentage: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');
          double progress = (sent / total) * 100;
          setState(() {
            loadingProgress = progress;
          });
        },
      );
      final jsonData = response.data;
      print("sign jsonData-> $jsonData");
      if (response.statusCode == 200) {
        print("in if with status->${jsonData['status']}");
        var bodyMSG = jsonData['message'];
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        storeStateCityAreaBranch();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
        setState(() {
          loadingProgress = 0.0;
          isSigningUp = false;
        });
        print("out from if");
      }
      else if (response.statusCode == 400) {
        var errorData = jsonData;
        if (errorData['error']['email_id'] != null) {
          var errorMessage = errorData['error']['email_id'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        } else if (errorData['error']['name'] != null) {
          var errorMessage = errorData['error']['name'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        } else if (errorData['error']['password'] != null) {
          var errorMessage = errorData['error']['password'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        } else {
          print("in sub else");
          SnackBarMessageShow.warningMSG('Failed to load data', context);
          Navigator.pop(context);
        }
        Navigator.pop(context);
      } else {
        print("in main else");
        SnackBarMessageShow.warningMSG('Failed to load data', context);
        Navigator.pop(context);
      }
    }
    catch (e) {
      print('Error -> ${e.toString()}');
      Navigator.pop(context);
    }
  }
  /*void signUpData() async {
    var url = ApiUrls.signUpUrl;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields["name"] = firstNm.text;
      request.fields["email_id"] = emailId.text;
      request.fields["password"] = password.text;
      request.fields["mobile"] = mobile.text;
      request.fields["vendor_name"] = createVendor.text;
      request.fields["state_id"] = selectedStateId;
      request.fields["city_id"] = selectedCityId;
      request.fields["area_id"] = selectedAreaId;
      request.fields["cost_center_id"] = selectedBranchId;
      request.fields["address"] = address.text;
      request.fields["pincode"] = pincode.text;
      request.fields["pancard_number"] = panCardNo.text;
      request.fields["sales_executive_admin_id"] = selectedSales ?? '';
      request.fields["b2b_subadmin_id"] = selectedB2b ?? '';
      request.fields["bank_name"] = bankName.text ?? '';
      request.fields["ifsc"] = ifscCode.text ?? '';
      request.fields["account_number"] = accountNo.text ?? '';
      request.fields["gst_number"] = gstNo.text ?? '';

      if (panCardFile != null) {
        request.files.add(http.MultipartFile('pancard', panCardFile.readAsBytes().asStream(), panCardFile.lengthSync(), filename: 'pancard.jpg'));
      }
      if (addressFile != null) {
        request.files.add(http.MultipartFile('address_proof', addressFile.readAsBytes().asStream(), addressFile.lengthSync(), filename: 'address_proof.jpg'));
      }
      if(aadharCardFFile != null){
        request.files.add(http.MultipartFile('aadhar_front', aadharCardFFile.readAsBytes().asStream(), aadharCardFFile.lengthSync(), filename: 'aadhar_front.jpg'));
      }
      if(aadharCardBFile != null){
        request.files.add(http.MultipartFile('aadhar_back', aadharCardBFile.readAsBytes().asStream(), aadharCardBFile.lengthSync(), filename: 'aadhar_back.jpg'));
      }
      if(checkFile != null){
        request.files.add(http.MultipartFile('cheque_image', checkFile.readAsBytes().asStream(), checkFile.lengthSync(), filename: 'cheque_image.jpg'));
      }
      if(gstFile != null){
        request.files.add(http.MultipartFile('gst_image', gstFile.readAsBytes().asStream(), gstFile.lengthSync(), filename: 'gst_image.jpg'));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      final jsonData = jsonDecode(response.body);
      print("sign jsonData-> $jsonData");
      if (response.statusCode == 200) {
        print("in if with status->${jsonData['status']}");
        var bodyMSG = jsonData['message'];
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        storeStateCityAreaBranch();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      } else if (response.statusCode == 400) {
        var errorData = jsonData;
        if (errorData['error']['email_id'] != null) {
          var errorMessage = errorData['error']['email_id'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        }else if (errorData['error']['name'] != null) {
          var errorMessage = errorData['error']['name'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        }
        else if (errorData['error']['password'] != null) {
          var errorMessage = errorData['error']['password'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        }
        else {
          print("in sub else");
          SnackBarMessageShow.warningMSG('Failed to load data', context);
          Navigator.pop(context);
        }
        Navigator.pop(context);
      } else {
        print("in main else");
        SnackBarMessageShow.warningMSG('Failed to load data', context);
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error -> ${e.toString()}');
      Navigator.pop(context);
    }
  }*/

  List<StateData> stateList = [];
  String selectedState;
  String selectedStateId;
  Future<void> fetchStateList() async {
    setState(() {
      stateLoading = true;
    });
    try {
      LocationFuture locationFuture = LocationFuture();
      List<StateData> list = await locationFuture.getState();
      setState(() {
        stateList = list;
        stateLoading = false;
      });
    } catch (e) {
      print("Error -> $e");
    }
  }

  List<CityData> cityList = [];
  String selectedCity;
  String selectedCityId;
  Future<void> fetchCityList(var sState) async {
    setState(() {
      cityLoading = true;
    });
    try {
      LocationFuture locationFuture = LocationFuture();
      List<CityData> list = await locationFuture.getCity(sState);
      setState(() {
        cityList = list;
        cityLoading = false;
      });
    } catch (e) {
      print("Error -> $e");
    }
  }

  List<AreaData> areaList = [];
  String selectedArea;
  String selectedAreaId;
  Future<void> fetchAreaList(var sState, var sCity) async {
    setState(() {
      areaLoading = true;
    });
    try {
      LocationFuture locationFuture = LocationFuture();
      List<AreaData> list = await locationFuture.getArea(sState,sCity);
      setState(() {
        areaList = list;
        areaLoading = false;
      });
    } catch (e) {
      print("Error -> $e");
    }
  }

  List<BranchData> branchList = [];
  String selectedBranch;
  String selectedBranchId;
  Future<void> fetchBranchList(var sState, var sCity, var sArea) async {
    setState(() {
      branchLoading = true;
    });
    try {
      LocationFuture locationFuture = LocationFuture();
      List<BranchData> list = await locationFuture.getBranch(sState,sCity,sArea);
      setState(() {
        branchList = list;
        branchLoading = false;
      });
    } catch (e) {
      print("Branch Error -> $e");
    }
  }

  List<dynamic> b2bSubAdminList = [];
  List<dynamic> salesExecutiveList = [];
  Future<void> getB2bSalesList() async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.b2b_Saless_Url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {

        final data = json.decode(response.body);
        setState(() {
          b2bSubAdminList = data['data']['b2b_subadmins'];
          salesExecutiveList = data['data']['sales_executive_admins'];
        });
        print("b2b -> $b2bSubAdminList");
        print("sales -> $salesExecutiveList");
      } else {
      }
    } catch (e) {
      print("B2b & Sales Error -> $e");
    }
  }
}
