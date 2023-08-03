//@dart=2.9
// ignore_for_file: use_build_context_synchronously, missing_return

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/File%20Picker/file_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:image_picker/image_picker.dart';
import '../../App Helper/Backend Helper/Api Future/Location Future/location_future.dart';
import '../../App Helper/Backend Helper/Models/Location Model/area_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/branch_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/city_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/state_model.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../Login Screen/login_screen.dart';

class SignUpForm extends StatefulWidget {
  var emailId;
  SignUpForm({Key key,this.emailId}) : super(key: key);

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
  
  final createVendor = TextEditingController();
  final firstNm = TextEditingController();
  final emailId = TextEditingController();
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
            showTextField(
                'Full name *', firstNm,Icons.person,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter full name';
                  }
                  return null;
                }
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
               controller: emailId,
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
                    print('Please enter valid email id');
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a email';
                  }
                  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    return 'email id must contain at least one special character';
                  }
                  return null;
                },// Set the validator function
              ),
            ),
            showTextField(
                'Vendor name *', createVendor,Icons.person_pin,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter vendor name';
                  }
                  return null;
                }
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: mobile,
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
                child: DropdownSearch<String>(
                  mode: Mode.DIALOG,
                  showSearchBox: true,
                  showSelectedItem: true,
                  items: stateList.where((state) => state.stateName != null).map((state) => state.stateName).toList(),
                  label: "Select state*",
                  onChanged: (newValue) {
                    final selectedStateObject = stateList.firstWhere((state) => state.stateName == newValue, orElse: () => null);
                    if (selectedStateObject != null) {
                      setState(() {
                        selectedCity = '';
                        selectedArea = '';
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
              ),
            ),
            SizedBox(height: space),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.w,
                //height: MediaQuery.of(context).size.height / 14.h,
                child: DropdownSearch<String>(
                  mode: Mode.DIALOG,
                  showSearchBox: true,
                  showSelectedItem: true,
                  items: cityList.where((city) => city.cityName != null).map((city) => city.cityName).toList(),
                  label: "Select city *",
                  onChanged: (newValue) {
                    final selectedCityObject = cityList.firstWhere((city) => city.cityName == newValue, orElse: () => null);
                    if (selectedCityObject != null) {
                      setState(() {
                        selectedCity = '';
                        selectedArea = '';
                        selectedBranch = '';
                        selectedCity = newValue;
                        selectedCityId = selectedCityObject.id.toString();
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
              ),
            ),
            SizedBox(height: space),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.w,
                //height: MediaQuery.of(context).size.height / 14.h,
                child: DropdownSearch<String>(
                  mode: Mode.DIALOG,
                  showSearchBox: true,
                  showSelectedItem: true,
                  items: areaList?.map((area) => area.areaName)?.toList() ?? [],
                  label: "Select area *",
                  onChanged: (newValue) {
                    final selectedAreaObject = areaList.firstWhere((area) => area.areaName  == newValue, orElse: () => null);
                    if (selectedAreaObject != null) {
                      setState(() {
                        selectedBranch = '';
                        selectedArea = newValue;
                        selectedAreaId = selectedAreaObject.id.toString();
                        fetchBranchList(selectedStateId, selectedCityId, selectedAreaId);
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
              ),
            ),

            SizedBox(height: space),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.w,
                //height: MediaQuery.of(context).size.height / 14.h,
                child: DropdownSearch<String>(
                  mode: Mode.DIALOG,
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
              ),
            ),
           /* SizedBox(
              width: MediaQuery.of(context).size.width / 1.15,
              child: DropdownButtonFormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: selectedBranch,
                isExpanded: true,
                style: const TextStyle(fontSize: 10,color: Colors.black87),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                  hintText: 'Select branch *',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select a branch';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  selectedBranch = newValue;
                },
                items: [
                  const DropdownMenuItem(
                    value: '',
                    child: Text('Select branch'),
                  ),
                  ...branchList?.map((branch) => DropdownMenuItem<String>(
                    value: branch.id.toString() ?? '',
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.5.w,
                        child: Text(branch.branchName)
                    ),
                  ))?.toList() ?? []
                ],
              ),
            ),*/


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
                  hintText: 'Pincode *',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.code_rounded, color: hsBlack, size: 20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter pincode';
                  }
                  return null;
                }, // Set the validator function
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height / 5,
              //color: Colors.green,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                            ? Text("Aadhaar card front",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                            : Container(
                              width: 100,height: 50,
                              child: Image.file(File(aadharCardFFile.path), fit: BoxFit.cover)
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: ()async {
                              var aadhaarCardFront = await FileImagePicker().pickFileManger(context);
                              setState(() {
                                aadharCardFFile = aadhaarCardFront;
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
                              Icons.camera
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
                            ? Text("Aadhaar card back",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                            : Container(
                              width: 100,height: 50,
                              child: Image.file(File(aadharCardBFile.path), fit: BoxFit.cover)
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: ()async {
                              var aadhaarCardBack = await FileImagePicker().pickFileManger(context);
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
                              Icons.camera
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
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      addressFile == null
                          ? Text("Address proof",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                          : Container(
                          width: 100,height: 50,
                          child: Image.file(File(addressFile.path), fit: BoxFit.cover)
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: ()async {
                            var addressProof = await FileImagePicker().pickFileManger(context);
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
                              Icons.camera
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
                  // onChanged: (value){
                  //   if (value.length < 11) {
                  //     print('Pancard length is less than 10 characters.');
                  //   }
                  //   if (!value.contains(RegExp(r'[0-9]'))) {
                  //     print('Pancard does not contain a digit.');
                  //   }
                  // },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter pancard number';
                    }
                    return null;
                  } // Set the validator function
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      panCardFile == null
                          ? Text("PAN card",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                          : Container(
                          width: 100,height: 50,
                          child: Image.file(File(panCardFile.path), fit: BoxFit.cover)
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: ()async {
                            var panCardFileManger = await FileImagePicker().pickFileManger(context);
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
                              Icons.camera
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
                // onChanged: (value){
                //   if (value.length < 16) {
                //     print('GST number length is less than 15 characters.');
                //   }
                //   if (!value.contains(RegExp(r'[0-9]'))) {
                //     print('GST does not contain a digit.');
                //   }
                // },
                // Set the validator function
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      gstFile == null
                          ? Text("GST img",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                          : Container(
                          width: 100,height: 50,
                          child: Image.file(File(gstFile.path), fit: BoxFit.cover)
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: ()async {
                            var gstFileManger = await FileImagePicker().pickFileManger(context);
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
                              Icons.camera
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            showTextField(
                'Bank name *', bankName,Icons.account_balance_rounded,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter bank name';
                  }
                  return null;
                }
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: ifscCode,
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
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      checkFile == null
                          ? Text("Cheque img",style: TextStyle(fontFamily: FontType.MontserratMedium),)
                          : Container(
                          width: 100,height: 50,
                          child: Image.file(File(checkFile.path), fit: BoxFit.cover)
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: ()async {
                            var chequeFileManger = await FileImagePicker().pickFileManger(context);
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
                              Icons.camera
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
                    return 'Please enter a password';
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
            //SizedBox(height: space),
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
                    if(selectedState == null || selectedCity == null || selectedArea == null){
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
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 16.0),
                                  Text('Loading...'),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      await signUpData();
                      //Navigator.pop(context);
                    }
                  }
                  // if(_agreedToTOS == false){
                  //   SnackBarMessageShow.warningMSG('Please select term & condition', context);
                  // }
                  // else{
                  //   if (_formKey.currentState.validate()) {
                  //     FocusScope.of(context).unfocus();
                  //     if(selectedState == null || selectedCity == null || selectedArea == null){
                  //       SnackBarMessageShow.warningMSG("Please select location fields", context);
                  //     }
                  //     else if(panCardFile == null || addressFile == null || aadharCardFFile == null || aadharCardBFile == null || checkFile == null || gstFile == null){
                  //       SnackBarMessageShow.warningMSG("Please select documents", context);
                  //     }
                  //     else{
                  //       showDialog(
                  //         context: context,
                  //         barrierDismissible: false,
                  //         builder: (BuildContext context) {
                  //           return Dialog(
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(16.0),
                  //               child: Column(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: const [
                  //                   CircularProgressIndicator(),
                  //                   SizedBox(height: 16.0),
                  //                   Text('Loading...'),
                  //                 ],
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       );
                  //       await signUpData();
                  //       //Navigator.pop(context);
                  //     }
                  //   }
                  // }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsBlack),
                  alignment: Alignment.center,
                  child: const Text(
                    "Create an account",
                    style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white,fontSize: 16),
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

  void signUpData() async {
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
        var bodyMSG = jsonData['message'];
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else if (response.statusCode == 400) {
        var errorData = jsonData;
        if (errorData['error']['email_id'] != null) {
          var errorMessage = errorData['error']['email_id'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        } else if (errorData['error']['sales_executive_admin_id'] != null) {
          var errorMessage = errorData['error']['sales_executive_admin_id'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        }else if (errorData['error']['password'] != null) {
          var errorMessage = errorData['error']['password'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        }
        else {
          SnackBarMessageShow.warningMSG('Failed to load data', context);
          Navigator.pop(context);
        }
        Navigator.pop(context);
      } else {
        SnackBarMessageShow.warningMSG('Failed to load data', context);
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error -> ${e.toString()}');
      Navigator.pop(context);
    }
  }

  /*void signUpData() async {
    var url = ApiUrls.signUpUrl;
    try {
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      Map<String, dynamic> formData = {
        "name": firstNm.text,
        "email_id": emailId.text,
        "password": password.text,
        "mobile": mobile.text,
        "vendor_name": createVendor.text,
        "state_id": selectedStateId,
        "city_id": selectedCityId,
        "area_id": selectedAreaId,
        "cost_center_id": selectedBranchId,
        "address": address.text,
        "pincode": pincode.text,
        "pancard_number": panCardNo.text,
        "sales_executive_admin_id": selectedSales ?? '',
        "b2b_subadmin_id": selectedB2b ?? '',
        "bank_name": bankName.text ?? '',
        "ifsc": ifscCode.text ?? '',
        "account_number": accountNo.text ?? '',
        "gst_number": gstNo.text ?? '',
      };

      // Add files to the request if they are not null
      if (panCardFile != null) {
        request.files.add(await http.MultipartFile.fromPath('pancard', panCardFile.path));
      }
      if (addressFile != null) {
        request.files.add(await http.MultipartFile.fromPath('address_proof', addressFile.path));
      }
      if (aadharCardFFile != null) {
        request.files.add(await http.MultipartFile.fromPath('aadhar_front', aadharCardFFile.path));
      }
      if (aadharCardBFile != null) {
        request.files.add(await http.MultipartFile.fromPath('aadhar_back', aadharCardBFile.path));
      }
      if (checkFile != null) {
        request.files.add(await http.MultipartFile.fromPath('cheque_image', checkFile.path));
      }
      if (gstFile != null) {
        request.files.add(await http.MultipartFile.fromPath('gst_image', gstFile.path));
      }

      request.fields.addAll(formData);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      final jsonData = jsonDecode(response.body);
      print("sign jsonData-> $jsonData");
      if (response.statusCode == 200) {
        var bodyMSG = jsonData['message'];
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else if (response.statusCode == 400) {
        var errorData = jsonData;
        if (errorData['error']['email_id'] != null) {
          var errorMessage = errorData['error']['email_id'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        } else if (errorData['error']['sales_executive_admin_id'] != null) {
          var errorMessage = errorData['error']['sales_executive_admin_id'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        } else {
          SnackBarMessageShow.warningMSG('Failed to load data', context);
        }
        Navigator.pop(context);
      } else {
        SnackBarMessageShow.warningMSG('Failed to load data', context);
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error -> ${e.toString()}');
      Navigator.pop(context);
    }
  }*/

  /*void signUpData() async {
    var url = ApiUrls.signUpUrl;
    try {
      FormData formData = FormData.fromMap({
        "name": firstNm.text,
        "email_id": emailId.text,
        "password": password.text,
        "mobile": mobile.text,
        "vendor_name": createVendor.text,
        "state_id": selectedStateId,
        'city_id': selectedCityId,
        'area_id': selectedAreaId,
        'cost_center_id': selectedBranchId,
        'address': address.text,
        'pincode': pincode.text,
        'pancard': await MultipartFile.fromFile(panCardFile.path),
        'pancard_number': panCardNo.text,
        'address_proof': await MultipartFile.fromFile(addressFile.path),
        'aadhar_front': await MultipartFile.fromFile(aadharCardFFile.path),
        'aadhar_back': await MultipartFile.fromFile(aadharCardBFile.path),
        'cheque_image': await MultipartFile.fromFile(checkFile.path),
        'gst_image': await MultipartFile.fromFile(gstFile.path),
        'sales_executive_admin_id': selectedSales ?? '',
        'b2b_subadmin_id': selectedB2b ?? '',
        'bank_name': bankName.text ?? '',
        'ifsc': ifscCode.text ?? '',
        'account_number': accountNo.text ?? '',
        'gst_number': gstNo.text ?? '',
      });
      print('Form -> ${formData.fields}');

      var dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));

      var response = await dio.post(url, data: formData);
      print("Sign Response ->$response");
      final jsonData = response.data;

      print("sign jsonData-> $jsonData");

      if (jsonData['status'] == 200) {
        print("in if->${jsonData['status']} / ${jsonData['message']}");
        var bodyMSG = jsonData['message'];
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else if (jsonData['status'] == 400) {
        var errorData = response.data;
        if (errorData['error']['email_id'] != null) {
          var errorMessage = errorData['error']['email_id'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        } else if (errorData['error']['sales_executive_admin_id'] != null) {
          var errorMessage = errorData['error']['sales_executive_admin_id'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        } else {
          SnackBarMessageShow.warningMSG('Failed to load data', context);
        }
        Navigator.pop(context);
      } else {
        SnackBarMessageShow.warningMSG('Failed to load data', context);
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error -> ${e.toString()}');
      Navigator.pop(context);
    }
  }*/
  /*void signUpData() async {
    var url = ApiUrls.signUpUrl;
    try {
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

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

      // Add files as multipart
      request.files.add(await http.MultipartFile.fromPath('pancard', panCardFile.path));
      request.files.add(await http.MultipartFile.fromPath('address_proof', addressFile.path));
      request.files.add(await http.MultipartFile.fromPath('aadhar_front', aadharCardFFile.path));
      request.files.add(await http.MultipartFile.fromPath('aadhar_back', aadharCardBFile.path));
      request.files.add(await http.MultipartFile.fromPath('cheque_image', checkFile.path));
      request.files.add(await http.MultipartFile.fromPath('gst_image', gstFile.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      final jsonData = jsonDecode(response.body);
      print("sign jsonData-> $jsonData");
      if (response.statusCode == 200) {
        var bodyMSG = jsonData['message'];
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else if (response.statusCode == 400) {
        var errorData = jsonData;
        if (errorData['error']['email_id'] != null) {
          var errorMessage = errorData['error']['email_id'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        } else if (errorData['error']['sales_executive_admin_id'] != null) {
          var errorMessage = errorData['error']['sales_executive_admin_id'][0];
          SnackBarMessageShow.warningMSG(errorMessage, context);
        } else {
          SnackBarMessageShow.warningMSG('Failed to load data', context);
        }
        Navigator.pop(context);
      } else {
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
    try {
      LocationFuture locationFuture = LocationFuture();
      List<StateData> list = await locationFuture.getState();
      setState(() {
        stateList = list;
      });
    } catch (e) {
      print("State Error -> $e");
    }
  }

  List<CityData> cityList = [];
  String selectedCity;
  String selectedCityId;
  Future<void> fetchCityList(var sState) async {
    try {
      LocationFuture locationFuture = LocationFuture();
      List<CityData> list = await locationFuture.getCity(sState);
      setState(() {
        cityList = list;
      });
    } catch (e) {
      print("City Error -> $e");
    }
  }

  List<AreaData> areaList = [];
  String selectedArea;
  String selectedAreaId;
  Future<void> fetchAreaList(var sState, var sCity) async {
    try {
      LocationFuture locationFuture = LocationFuture();
      List<AreaData> list = await locationFuture.getArea(sState,sCity);
      setState(() {
        areaList = list;
      });
    } catch (e) {
      print("Area Error -> $e");
    }
  }

  List<BranchData> branchList = [];
  String selectedBranch;
  String selectedBranchId;
  Future<void> fetchBranchList(var sState, var sCity, var sArea) async {
    try {
      LocationFuture locationFuture = LocationFuture();
      List<BranchData> list = await locationFuture.getBranch(sState,sCity,sArea);
      setState(() {
        branchList = list;
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
