import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/File%20Picker/file_image_picker.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/getx_snackbar_msg.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Sign%20up%20Screen/signup_screen.dart';
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
import '../Splash Screen/splash_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}


// last final update 30-01 as par discuss = vendor name = radhe medical and name = krishna

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? panCardFile;
  File? addressFile;
  File? aadhaarCardFFile;
  File? aadhaarCardBFile;
  File? checkFile;
  File? gstFile;

  bool stateLoading = false;
  bool cityLoading = false;
  bool areaLoading = false;
  bool branchLoading = false;

  final vendorName = TextEditingController();
  final emailId = TextEditingController();
  final pharmacyName = TextEditingController();
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
  final beneficiaryName = TextEditingController();
  final accountNo = TextEditingController();
  final gstNo = TextEditingController();

  String? selectedSales;
  String? selectedB2b;
  var selectedSalesMobileNo;

  @override
  void initState() {
    super.initState();
    functionCalling();
  }

  void functionCalling() async {
    await fetchStateList();
    await getB2bSalesList();
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

  bool _agreedToTOS = false;

  Future<void> storeStateCityAreaBranch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('signupStateId', selectedStateId!);
    await prefs.setString('signupCityId', selectedCityId!);
    await prefs.setString('signupAreaId', selectedAreaId!);
    await prefs.setString('signupBranchId', selectedBranchId!);
    await prefs.setString('signupStateName', selectedState!);
    await prefs.setString('signupCityName', selectedCity!);
    await prefs.setString('signupAreaName', selectedArea!);
    await prefs.setString('signupBranchName', selectedBranch!);
  }

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? hsSpaceM : hsSpaceS;

    return stateLoading == false
        ? Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: DropdownButtonFormField<String>(
                      value: selectedB2b,
                      style: const TextStyle(fontSize: 12, color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
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
                                      )))?.toList() ?? []
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextFormField(
                      controller: vendorName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(hsPaddingM),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Vendor name"),
                            Text(" *", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily: FontType.MontserratRegular,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.person, color: hsBlack, size: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${ValidationText.vendorName}';
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(hsPaddingM),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Email id"),
                            Text(" *", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily: FontType.MontserratRegular,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.email_rounded, color: hsBlack, size: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${ValidationText.emailId}';
                        }
                        if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return '${ValidationText.emailValidation}';
                        }
                        return null;
                      }, // Set the validator function
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextFormField(
                      controller: pharmacyName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(hsPaddingM),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Pharmacy name	"),
                            Text(" *", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily: FontType.MontserratRegular,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.person_pin, color: hsBlack, size: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${ValidationText.pharmacyName}';
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
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(hsPaddingM),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Mobile no"),
                            Text(" *", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily: FontType.MontserratRegular,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.mobile_friendly, color: hsBlack, size: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${ValidationText.mobileNumber}';
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
                            child: const Positioned(
                              top: 10,
                              right: 5,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.dialog(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            items: stateList
                                .where((state) => state!.stateName! != null)
                                .map((state) => state!.stateName!)
                                .toList(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                //labelText: "Select state *",
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Select state"),
                                    Text(" *", style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                                labelStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontFamily: FontType.MontserratRegular,
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                ),
                              ),
                            ),
                            onChanged: (newValue) {
                              final selectedStateObject = stateList.firstWhere(
                                (state) => state!.stateName == newValue,
                                orElse: () => StateData(),
                              );
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
                                return '${ValidationText.stateSelect}';
                              }
                              return null;
                            },
                          )
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
                            child: const Positioned(
                              top: 10,
                              right: 5,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.dialog(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            items: cityList
                                .where((city) => city!.cityName != null)
                                .map((city) => city!.cityName!)
                                .toList(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                //labelText: "Select city *",
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Select city"),
                                    Text(" *", style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                                labelStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontFamily: FontType.MontserratRegular,
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                ),
                              ),
                            ),
                            onChanged: (newValue) {
                              final selectedCityObject = cityList.firstWhere(
                                (city) => city!.cityName == newValue,
                                orElse: () => CityData(), // Return an empty instance of StateData
                              );
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
                                return '${ValidationText.citySelect}';
                              }
                              return null;
                            },
                          )
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
                            child: const Positioned(
                              top: 10,
                              right: 5,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.dialog(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            items: branchList.map((branch) => branch!.branchName!).toList() ?? [],
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                //labelText: "Select branch *",
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Select branch"),
                                    Text(" *", style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                                labelStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontFamily: FontType.MontserratRegular,
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                ),
                              ),
                            ),
                            onChanged: (newValue) {
                              final selectedBranchObject = branchList.firstWhere(
                                (branch) => branch!.branchName == newValue,
                                orElse: () => BranchData(), // Return an empty instance of StateData
                              );
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
                                return '${ValidationText.branchSelect}';
                              }
                              return null;
                            },
                          )
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
                            child: const Positioned(
                              top: 10,
                              right: 5,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.dialog(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            items: areaList.map((area) => area!.areaName!).toList() ?? [],
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                //labelText: "Select area *",
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Select area"),
                                    Text(" *", style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                                labelStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontFamily: FontType.MontserratRegular,
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                ),
                              ),
                            ),
                            onChanged: (newValue) {
                              final selectedAreaObject = areaList.firstWhere(
                                (area) => area!.areaName == newValue,
                                orElse: () => AreaData(), // Return an empty instance of StateData
                              );
                              if (selectedAreaObject != null) {
                                setState(() {
                                  selectedArea = newValue;
                                  selectedAreaId = selectedAreaObject.id.toString();
                                });
                              }
                            },
                            selectedItem: selectedArea,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '${ValidationText.areaSelect}';
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: DropdownButtonFormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      value: selectedSales,
                      style: const TextStyle(fontSize: 10, color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Sales executive"),
                            Text(" *", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily: FontType.MontserratRegular,
                          fontSize: 14,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${ValidationText.salesExecutive}';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        setState(() {
                          showExecutive = true;
                          selectedSales = newValue;
                          final selectedExecutive = salesExecutiveList.firstWhere((executive) => executive['id'].toString() == newValue, orElse: () => null,);
                          if (selectedExecutive != null) {
                            final selectedId = selectedExecutive['id'].toString();
                            selectedSalesMobileNo = selectedExecutive['mobile_no'];
                          }
                          seMobile.text = selectedSalesMobileNo;
                        });
                      },
                      items: salesExecutiveList?.map((sales) =>
                          DropdownMenuItem(
                             value: sales['id'].toString(),
                             child: Container(
                                 width: MediaQuery.of(context).size.width / 1.45.w,
                                 child: Text("${sales['name']} - ${sales['mobile_no']}")),
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
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                          label: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Executive mobile no"),
                              //Text(" *", style: const TextStyle(color: Colors.red)),
                            ],
                          ),
                          labelStyle: const TextStyle(
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
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Pincode"),
                            //Text(" *", style: const TextStyle(color: Colors.red)),
                          ],
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily: FontType.MontserratRegular,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.code_rounded, color: hsBlack, size: 20),
                      ),
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
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                children: [
                                  aadhaarCardFFile == null
                                      ? const Text("Aadhaar card front", style: TextStyle(fontFamily: FontType.MontserratMedium),)
                                      : Container(
                                          alignment: Alignment.centerLeft,
                                          width: aadhaarCardFFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                              ? 200
                                              : 100,
                                          height: 50,
                                          child: aadhaarCardFFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                              ? Text(aadhaarCardFFile!.path.split('/').last.toString(), style: const TextStyle(fontFamily: FontType.MontserratRegular),)
                                              : buildImageDialog(aadhaarCardFFile!, 'Aadhaar card front')),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () async {
                                        var aadhaarCardFrontFile = await FileImagePicker().pickFileManager(context);
                                        setState(() {
                                          aadhaarCardFFile = aadhaarCardFrontFile;
                                        });
                                      },
                                      icon: const Icon(Icons.file_copy_rounded)
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        var aadhaarCardFrontCamera = await FileImagePicker().pickCamera();
                                        setState(() {
                                          aadhaarCardFFile = aadhaarCardFrontCamera;
                                        });
                                      },
                                      icon: const Icon(Icons.camera_alt_rounded)
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                children: [
                                  aadhaarCardBFile == null
                                      ? const Text("Aadhaar card back", style: TextStyle(fontFamily: FontType.MontserratMedium),)
                                      : Container(
                                          alignment: Alignment.centerLeft,
                                          width: aadhaarCardBFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                              ? 200
                                              : 100,
                                          height: 50,
                                          child: aadhaarCardBFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                              ? Text(aadhaarCardBFile!.path.split('/').last.toString(), style: const TextStyle(fontFamily: FontType.MontserratRegular),)
                                              : buildImageDialog(aadhaarCardBFile!, 'Aadhaar card back')
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () async {
                                        var aadhaarCardBack = await FileImagePicker().pickFileManager(context);
                                        setState(() {
                                          aadhaarCardBFile = aadhaarCardBack;
                                        });
                                      },
                                      icon: const Icon(Icons.file_copy_rounded)),
                                  IconButton(
                                      onPressed: () async {
                                        var aadhaarCardBackCamera = await FileImagePicker().pickCamera();
                                        setState(() {
                                          aadhaarCardBFile = aadhaarCardBackCamera;
                                        });
                                      },
                                      icon: const Icon(Icons.camera_alt_rounded)
                                  ),
                                ],
                              ),
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
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12))),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12))),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Address"),
                            Text(" *", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily: FontType.MontserratRegular,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.location_city, color: hsBlack, size: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${ValidationText.address}';
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
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            children: [
                              addressFile == null
                                  ? const Text("Address proof", style: TextStyle(fontFamily: FontType.MontserratMedium),)
                                  : Container(
                                      alignment: Alignment.centerLeft,
                                      width: addressFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                          ? 200
                                          : 100,
                                      height: 50,
                                      child: addressFile!.path.split('/').last.toString().split('.').last =='pdf'
                                          ? Text(addressFile!.path.split('/').last.toString(), style: const TextStyle(fontFamily: FontType.MontserratRegular),)
                                          : buildImageDialog(addressFile!, 'Address proof')),
                              const Spacer(),
                              IconButton(
                                  onPressed: () async {
                                    var addressProof = await FileImagePicker().pickFileManager(context);
                                    setState(() {
                                      addressFile = addressProof;
                                    });
                                  },
                                  icon: const Icon(Icons.file_copy_rounded)),
                              IconButton(
                                  onPressed: () async {
                                    var addressProofCamera = await FileImagePicker().pickCamera();
                                    setState(() {
                                      addressFile = addressProofCamera;
                                    });
                                  },
                                  icon: const Icon(Icons.camera_alt_rounded)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 10,
                        controller: panCardNo,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(hsPaddingM),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                          label: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Pan Card number"),
                              Text(" *", style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                            fontFamily: FontType.MontserratRegular,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(Icons.numbers_rounded,
                              color: hsBlack, size: 20),
                        ),
                        validator: validatePANCard // Set the validator function
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            children: [
                              panCardFile == null
                                  ? const Text("PAN card", style: TextStyle(fontFamily: FontType.MontserratMedium),)
                                  : Container(
                                      alignment: Alignment.centerLeft,
                                      width: panCardFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                          ? 200
                                          : 100,
                                      height: 50,
                                      child: panCardFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                          ? Text(panCardFile!.path.split('/').last.toString(), style: const TextStyle(fontFamily: FontType.MontserratRegular),)
                                          : buildImageDialog(panCardFile!, 'PAN card')),
                              const Spacer(),
                              IconButton(
                                  onPressed: () async {
                                    var panCardFileManger = await FileImagePicker().pickFileManager(context);
                                    setState(() {
                                      panCardFile = panCardFileManger;
                                    });
                                  },
                                  icon: const Icon(Icons.file_copy_rounded)),
                              IconButton(
                                  onPressed: () async {
                                    var panCardCamera = await FileImagePicker().pickCamera();
                                    setState(() {
                                      panCardFile = panCardCamera;
                                    });
                                  },
                                  icon: const Icon(Icons.camera_alt_rounded)),
                            ],
                          ),
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
                      maxLength: 15,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(hsPaddingM),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("GST number"),
                            //Text(" *", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        labelStyle: const TextStyle(color: Colors.black54, fontFamily: FontType.MontserratRegular, fontSize: 14,),
                        prefixIcon: const Icon(Icons.confirmation_number_rounded, color: hsBlack, size: 20),
                      ),
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                      validator: (value) {
                        if(value != null && value.isNotEmpty){
                          if (value?.length != 15) {
                            return '${ValidationText.gstLength}';
                          }
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            children: [
                              gstFile == null
                                  ? const Text("GST img", style: TextStyle(fontFamily: FontType.MontserratMedium),)
                                  : Container(
                                      alignment: Alignment.centerLeft,
                                      width: gstFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                          ? 200
                                          : 100,
                                      height: 50,
                                      child: gstFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                          ? Text(gstFile!.path.split('/').last.toString(), style: const TextStyle(fontFamily: FontType.MontserratRegular),)
                                          : buildImageDialog(gstFile!, 'GST file')),
                              const Spacer(),
                              IconButton(
                                  onPressed: () async {
                                    var gstFileManger = await FileImagePicker().pickFileManager(context);
                                    setState(() {
                                      gstFile = gstFileManger;
                                    });
                                  },
                                  icon: const Icon(Icons.file_copy_rounded)
                              ),
                              IconButton(
                                  onPressed: () async {
                                    var gstFileCamera = await FileImagePicker().pickCamera();
                                    setState(() {
                                      gstFile = gstFileCamera;
                                    });
                                  },
                                  icon: const Icon(Icons.camera_alt_rounded)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextFormField(
                      controller: bankName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(hsPaddingM),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Bank name"),
                            Text(" *", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily: FontType.MontserratRegular,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.account_balance_rounded, color: hsBlack, size: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${ValidationText.bankName}';
                        }
                        return null;
                      }, // Set the validator function
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 11,
                        controller: ifscCode,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(hsPaddingM),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                          label: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("IFSC code"),
                              Text(" *", style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                            fontFamily: FontType.MontserratRegular,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(Icons.code_rounded, color: hsBlack, size: 20),
                        ),
                        validator: validateIFSC // Set the validator function
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            children: [
                              checkFile == null
                                  ? const Text(
                                      "Cheque img",
                                      style: TextStyle(fontFamily: FontType.MontserratMedium),
                                    )
                                  : Container(
                                      alignment: Alignment.centerLeft,
                                      width: checkFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                          ? 200
                                          : 100,
                                      height: 50,
                                      child: checkFile!.path.split('/').last.toString().split('.').last == 'pdf'
                                          ? Text(
                                              checkFile!.path.split('/').last.toString(),
                                              style: const TextStyle(fontFamily: FontType.MontserratRegular),)
                                          : buildImageDialog(checkFile!, 'Cheque img')),
                              const Spacer(),
                              IconButton(
                                  onPressed: () async {
                                    var chequeFileManger = await FileImagePicker().pickFileManager(context);
                                    setState(() {
                                      checkFile = chequeFileManger;
                                    });
                                  },
                                  icon: const Icon(Icons.file_copy_rounded)),
                              IconButton(
                                  onPressed: () async {
                                    var chequeFileCamera = await FileImagePicker().pickCamera();
                                    setState(() {
                                      checkFile = chequeFileCamera;
                                    });
                                  },
                                  icon: const Icon(Icons.camera_alt_rounded)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextFormField(
                      controller: beneficiaryName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(hsPaddingM),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Beneficiary name as par cheque"),
                            Text(" *", style: TextStyle(color: Colors.red),overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                        labelStyle: const TextStyle(
                            color: Colors.black54,
                            fontFamily: FontType.MontserratRegular,
                            fontSize: 13,
                            overflow: TextOverflow.ellipsis),
                        prefixIcon: const Icon(Icons.account_balance_outlined, color: hsBlack, size: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${ValidationText.beneficiaryNm}';
                        }
                        return null;
                      }, // Set the validator function
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: accountNo,
                        maxLength: 20,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(hsPaddingM),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                          label: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Account number"),
                              Text(" *", style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                            fontFamily: FontType.MontserratRegular,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                              Icons.account_balance_wallet_rounded,
                              color: hsBlack,
                              size: 20),
                        ),
                        validator: validateAccountNumber // Set the validator function
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
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Password"),
                            Text(" *", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily: FontType.MontserratRegular,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.lock_open_rounded, color: hsBlack, size: 20),
                        suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            obScured
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
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
                      obscureText: obCScured,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(hsPaddingM),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Confirm password"),
                            Text(" *", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily: FontType.MontserratRegular,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.lock_outline_rounded,
                            color: hsBlack, size: 20),
                        suffixIcon: InkWell(
                          onTap: _toggleCPasswordView,
                          child: Icon(
                            obCScured
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
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
                          return 'Enter a confirm password';
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
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          if (selectedState == null || selectedCity == null || selectedArea == null || selectedState == '' || selectedCity == '' || selectedArea == '') {
                            GetXSnackBarMsg.getWarningMsg('Please select location fields');
                          } else if (panCardFile == null) {
                            GetXSnackBarMsg.getWarningMsg(AppTextHelper().panCardSelect);
                          } else if (addressFile == null) {
                            GetXSnackBarMsg.getWarningMsg(AppTextHelper().addressSelect);
                          } else if (aadhaarCardFFile == null) {
                            GetXSnackBarMsg.getWarningMsg(AppTextHelper().aadhaarCardFSelect);
                          } else if (aadhaarCardBFile == null) {
                            GetXSnackBarMsg.getWarningMsg(AppTextHelper().aadhaarCardBSelect);
                          } else if (checkFile == null) {
                            GetXSnackBarMsg.getWarningMsg(AppTextHelper().chequeImgSelect);
                          } else if (_agreedToTOS == false) {
                            GetXSnackBarMsg.getWarningMsg('Please select term & condition');
                          } else {
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
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: hsBlack),
                        alignment: Alignment.center,
                        child: isSigningUp == true
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Processing : ${loadingProgress.toStringAsFixed(1)}%',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: 15),
                                  const CircularProgressIndicator(color: Colors.white),
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
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Image(
                    image: AssetImage('assets/Gif/HealthSaarthi_GIF.gif')),
              ),
            ],
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
          ? Text("$label",
              style: const TextStyle(fontFamily: FontType.MontserratMedium))
          : Image.file(selectedFilePhoto, fit: BoxFit.cover),
    );
  }

  String? validatePANCard(String? value) {
    // Check if the PAN card value is null or empty
    if (value == null || value.isEmpty) {
      return 'PAN card number is required';
    }

    // Remove any whitespace and convert to uppercase
    value = value.replaceAll(RegExp(r'\s+'), '').toUpperCase();

    // Check if the length of the PAN card number is exactly 10 characters
    if (value.length != 10) {
      return 'PAN card no must be 10 characters long';
    }

    // PAN card pattern to validate: 5 uppercase letters followed by 4 digits and 1 uppercase letter
    RegExp panCardRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

    // Check if the PAN card number follows the specified pattern
    if (!panCardRegExp.hasMatch(value)) {
      return 'Enter a valid PAN no (Example: ABCDE1234F)';
    }

    // If all checks pass, the PAN card number is valid
    return null;
  }


  String? validateIFSC(String? value) {
    if (value == null || value.isEmpty) {
      return 'IFSC code is required';
    }

    // Remove any whitespace and convert to uppercase
    value = value.replaceAll(RegExp(r'\s+'), '').toUpperCase();

    // Check if the length of the IFSC code is exactly 11 characters
    if (value.length != 11) {
      return 'IFSC code must be 11 characters long';
    }

    // Check if the first four characters are letters
    if (!RegExp(r'^[A-Z]{4}').hasMatch(value.substring(0, 4))) {
      return 'Invalid IFSC code format: First four characters must be letters';
    }

    // Check if the fifth character is '0'
    if (value[4] != '0') {
      return 'Fifth character must be "0"';
    }

    // Check if the remaining characters are alphanumeric
    if (!RegExp(r'^[A-Z0-9]{6}$').hasMatch(value.substring(5, 11))) {
      return 'Last six characters must be alphanumeric';
    }

    // You can add additional checks here if needed, such as checking against a list of valid IFSC codes

    // If all checks pass, the IFSC code is valid
    return null; // Return null if the IFSC code is valid
  }


  String? validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Account number is required';
    }
    // Check if the value contains only numeric characters
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Account number must contain only digits';
    }
    // You can add additional checks here based on your specific validation requirements
    // If all checks pass, the account number is considered valid
    return null; // Return null if the account number is valid
  }

  void _setAgreedToTOS(bool? newValue) {
    setState(() {
      _agreedToTOS = newValue!;
    });
  }

  double loadingProgress = 0.0;
  bool isSigningUp = false;

  signUpData() async {
    final dio = Dio();
    var url = ApiUrls.signUpUrl;
    try {
      var formData = FormData();
      formData.fields.addAll([
        MapEntry("vendor_name", vendorName.text ?? ''),
        MapEntry("email_id", emailId.text ?? ''),
        MapEntry("password", password.text ?? ''),
        MapEntry("mobile", mobile.text ?? ''),
        MapEntry("name", pharmacyName.text ?? ''),                              // name = pharmacy name(old) // name = person name (new 30-01)
        MapEntry("state_id", selectedStateId! ?? ''),
        MapEntry("city_id", selectedCityId! ?? ''),
        MapEntry("area_id", selectedAreaId! ?? ''),
        MapEntry("cost_center_id", selectedBranchId! ?? ''),
        MapEntry("address", address.text ?? ''),
        MapEntry("pincode", pincode.text ?? ''),
        MapEntry("pancard_number", panCardNo.text ?? ''),
        MapEntry("sales_executive_admin_id", selectedSales ?? ''),
        MapEntry("b2b_subadmin_id", selectedB2b ?? ''),
        MapEntry("bank_name", bankName.text ?? ''),
        MapEntry("ifsc", ifscCode.text ?? ''),
        MapEntry("beneficiary_name", beneficiaryName.text ?? ''),
        MapEntry("account_number", accountNo.text ?? ''),
        MapEntry("gst_number", gstNo.text ?? ''),
      ]);
      if (panCardFile != null) {
        formData.files.add(MapEntry(
          "pancard",
          await MultipartFile.fromFile(
            panCardFile!.path,
            filename: '${panCardFile!.path.split('/').last.toString()}',
          ),
        ));
      }
      if (addressFile != null) {
        formData.files.add(MapEntry(
          "address_proof",
          await MultipartFile.fromFile(
            addressFile!.path,
            filename: '${addressFile!.path.split('/').last.toString()}',
          ),
        ));
      }
      if (aadhaarCardFFile != null) {
        formData.files.add(MapEntry(
          "aadhar_front",
          await MultipartFile.fromFile(
            aadhaarCardFFile!.path,
            filename: '${aadhaarCardFFile!.path.split('/').last.toString()}',
          ),
        ));
      }
      if (aadhaarCardBFile != null) {
        formData.files.add(MapEntry(
          "aadhar_back",
          await MultipartFile.fromFile(
            aadhaarCardBFile!.path,
            filename: '${aadhaarCardBFile!.path.split('/').last.toString()}',
          ),
        ));
      }
      if (checkFile != null) {
        formData.files.add(MapEntry(
          "cheque_image",
          await MultipartFile.fromFile(
            checkFile!.path,
            filename: '${checkFile!.path.split('/').last.toString()}',
          ),
        ));
      }
      if (gstFile != null) {
        formData.files.add(MapEntry(
          "gst_image",
          await MultipartFile.fromFile(
            gstFile!.path,
            filename: '${gstFile!.path.split('/').last.toString()}',
          ),
        ));
      }

      dio.interceptors.add(InterceptorsWrapper(
          onError: (DioError err, ErrorInterceptorHandler handler) async {
        print("in dio interceptor->${err.response}");
        if (err.response != null) {
          var responseData = err.response!.data;
          if (responseData['status'] == 400) {
            var errorData = responseData['error'];
            if (errorData['email_id'] != null) {
              var errorMessage = errorData['email_id'][0];
              setState(() {
                loadingProgress = 0.0;
                isSigningUp = false;
              });
              GetXSnackBarMsg.getWarningMsg('$errorMessage');
            } else if (errorData['name'] != null) {
              var errorMessage = errorData['name'][0];
              setState(() {
                loadingProgress = 0.0;
                isSigningUp = false;
              });
              GetXSnackBarMsg.getWarningMsg('$errorMessage');
            } else if (errorData['vendor_name'] != null) {
              var errorMessage = errorData['vendor_name'][0];
              setState(() {
                loadingProgress = 0.0;
                isSigningUp = false;
              });
              GetXSnackBarMsg.getWarningMsg('$errorMessage');
            } else if (errorData['mobile'] != null) {
              var errorMessage = errorData['mobile'][0];
              setState(() {
                loadingProgress = 0.0;
                isSigningUp = false;
              });
              GetXSnackBarMsg.getWarningMsg('$errorMessage');
            } else if (errorData['pincode'] != null) {
              var errorMessage = errorData['pincode'][0];
              setState(() {
                loadingProgress = 0.0;
                isSigningUp = false;
              });
              GetXSnackBarMsg.getWarningMsg('$errorMessage');
            } else if (errorData['name'] != null) {
              var errorMessage = errorData['name'][0];
              setState(() {
                loadingProgress = 0.0;
                isSigningUp = false;
              });
              GetXSnackBarMsg.getWarningMsg('$errorMessage');
            } else if (errorData['password'] != null) {
              var errorMessage = errorData['password'][0];
              setState(() {
                loadingProgress = 0.0;
                isSigningUp = false;
              });
              GetXSnackBarMsg.getWarningMsg('$errorMessage');
            } else {
              setState(() {
                loadingProgress = 0.0;
                isSigningUp = false;
              });
            }
          } else {
            setState(() {
              loadingProgress = 0.0;
              isSigningUp = false;
            });
          }
        } else {
          setState(() {
            loadingProgress = 0.0;
            isSigningUp = false;
          });
        }
      }));
      final response = await dio.post(
        url,
        data: formData,
        options: Options(headers: {"Content-Type": "application/json"}),
        onSendProgress: (int sent, int total) {
          print(
              'progress percentage: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');
          double progress = (sent / total) * 100;
          setState(() {
            loadingProgress = progress;
          });
        },
      );
      final jsonData = response.data;
      if (response.statusCode == 200) {
        var bodyMSG = jsonData['message'];
        GetXSnackBarMsg.getSuccessMsg('$bodyMSG');
        storeStateCityAreaBranch();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
        setState(() {
          loadingProgress = 0.0;
          isSigningUp = false;
        });
      } else if (response.statusCode == 400) {
        var errorData = jsonData;
        if (errorData['error']['email_id'] != null) {
          var errorMessage = errorData['error']['email_id'][0];
          GetXSnackBarMsg.getWarningMsg('$errorMessage');
        } else if (errorData['error']['name'] != null) {
          var errorMessage = errorData['error']['name'][0];
          GetXSnackBarMsg.getWarningMsg('$errorMessage');
        } else if (errorData['error']['password'] != null) {
          var errorMessage = errorData['error']['password'][0];
          GetXSnackBarMsg.getWarningMsg('$errorMessage');
        } else {
          GetXSnackBarMsg.getWarningMsg('${AppTextHelper().serverError}');
          Navigator.pop(context);
        }
        Navigator.pop(context);
      } else {
        GetXSnackBarMsg.getWarningMsg('${AppTextHelper().internalServerError}');
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error -> ${e.toString()}');
      GetXSnackBarMsg.getWarningMsg(AppTextHelper().internalServerError);
      Navigator.pop(context);
    }
  }

  List<StateData?> stateList = [];
  String? selectedState;
  String? selectedStateId;
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
      stateLoading = false;
    }
  }

  List<CityData?> cityList = [];
  String? selectedCity;
  String? selectedCityId;
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

  List<AreaData?> areaList = [];
  String? selectedArea;
  String? selectedAreaId;
  Future<void> fetchAreaList(var sState, var sCity) async {
    setState(() {
      areaLoading = true;
    });
    try {
      LocationFuture locationFuture = LocationFuture();
      List<AreaData> list = await locationFuture.getArea(sState, sCity);
      setState(() {
        areaList = list;
        areaLoading = false;
      });
    } catch (e) {
      print("Error -> $e");
    }
  }

  List<BranchData?> branchList = [];
  String? selectedBranch;
  String? selectedBranchId;
  Future<void> fetchBranchList(var sState, var sCity, var sArea) async {
    setState(() {
      branchLoading = true;
    });
    try {
      LocationFuture locationFuture = LocationFuture();
      List<BranchData> list =
          await locationFuture.getBranch(sState, sCity, sArea);
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
        Uri.parse(ApiUrls.b2bSalesUrl),
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
      } else {}
    } catch (e) {
      print("B2b & Sales Error -> $e");
    }
  }
}
