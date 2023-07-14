//@dart=2.9
// ignore_for_file: use_build_context_synchronously, missing_return

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
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

  final createVendor = TextEditingController();
  final firstNm = TextEditingController();
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
  bool _agreedToTOS = true;
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
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: '${widget.emailId}',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.email_rounded, color: hsBlack, size: 20),
                ), // Set the validator function
              ),
            ),
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
                  DropdownMenuItem(
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
                'Full name', firstNm,Icons.person,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter full name';
                  }
                  return null;
                }
            ),
            showTextField(
                'Vendor name', createVendor,Icons.person_pin,
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
                  hintText: 'Mobile no',
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
            showTextField(
                'Address', address,Icons.location_city,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter address';
                  }
                  return null;
                }
            ),
            SizedBox(height: space),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.15,
              child: DropdownButtonFormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: selectedState,
                style: const TextStyle(fontSize: 10, color: Colors.black87),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12))),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12))),
                  hintText: 'State',
                  hintStyle: const TextStyle(color: Colors.black54, fontFamily: FontType.MontserratRegular, fontSize: 12),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select a state';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    selectedState = newValue;
                  });
                  fetchCityList(selectedState);
                },
                onTap: () {
                  if (selectedCity == null) {
                    fetchStateList();
                  } else {
                    setState(() {
                      selectedCity = null;
                      selectedArea = null;
                      selectedBranch = null;
                    });
                    fetchStateList();
                  }
                },
                items: [
                  DropdownMenuItem(
                    value: '',
                    child: Text('Select state'),
                  ),
                  ...stateList.map((state) => DropdownMenuItem<String>(
                    value: state.id?.toString() ?? '',
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3.8,
                      child: Text(state.stateName ?? ''),
                    ),
                  )).toList()
                ],
              ),
            ),
            SizedBox(height: space),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.15,
              child: DropdownButtonFormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: selectedCity,
                style: const TextStyle(fontSize: 10,color: Colors.black87),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                  hintText: 'City',
                  hintStyle: const TextStyle(color: Colors.black54, fontFamily: FontType.MontserratRegular, fontSize: 12,),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select a city';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  selectedCity = newValue;
                  fetchAreaList(selectedState, selectedCity);
                },
                onTap: (){
                  if(selectedArea == null){
                    fetchCityList(selectedState);
                  }
                  else{
                    setState(() {
                      selectedArea = null;
                      selectedBranch = null;
                    });
                    fetchAreaList(selectedState, selectedCity);
                  }
                },
                items: [
                  DropdownMenuItem(
                    value: '',
                    child: Text('Select city'),
                  ),
                  ...cityList?.map((city) => DropdownMenuItem<String>(
                    value: city.id.toString() ?? '',
                    child: Container(
                        width: MediaQuery.of(context).size.width / 4.w,
                        child: Text(city.cityName)
                    ),
                  ))?.toList() ?? []
                ],
              ),
            ),
            SizedBox(height: space),
            Container(
              width: MediaQuery.of(context).size.width / 1.15,
              //height: MediaQuery.of(context).size.height / 18,
              child: DropdownButtonFormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: selectedArea,
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
                  hintText: 'Area',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select a area';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  selectedArea = newValue;
                  fetchBranchList(selectedState, selectedCity, selectedArea);
                },
                onTap: (){
                  if(selectedBranch == null){
                    fetchAreaList(selectedState, selectedCity);
                  }
                  else{
                    setState(() {
                      selectedBranch = null;
                    });
                    fetchBranchList(selectedState, selectedCity,selectedArea);
                  }
                },
                items: [
                  DropdownMenuItem(
                    value: '',
                    child: Text('Select area'),
                  ),
                  ...areaList?.map((area) => DropdownMenuItem<String>(
                    value: area.id.toString() ?? '',
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.5.w,
                        child: Text(area.areaName)
                    ),
                  ))?.toList() ?? []
                ],
              ),
            ),
            SizedBox(height: space),
            SizedBox(
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
                  hintText: 'Branch',
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
                  DropdownMenuItem(
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
                  hintText: 'Sales executive',
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
                  hintText: 'Pincode',
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    shadowColor: hsPrime.withOpacity(0.5),
                    child: InkWell(
                      onTap: () {
                        _showFilePick(context, 'panCard');
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            panCardFile == null
                                ? Icon(
                              Icons.upload_file_rounded,
                              color: Colors.black,
                              size: 30,
                            )
                                : const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 30,
                            ),
                            SizedBox(height: 5),
                            Text(
                              panCardFile == null ? "Pan card" : "Pan card picked",
                              style: TextStyle(
                                fontFamily: FontType.MontserratRegular,
                                color: Colors.black87,
                                fontSize: panCardFile == null ? 14 : 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    shadowColor: hsPrime.withOpacity(0.5),
                    child: InkWell(
                      onTap: () {
                        _showFilePick(context, 'address');
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            addressFile == null
                                ? Icon(
                              Icons.upload_file_rounded,
                              color: Colors.black,
                              size: 30,
                            )
                                : const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 30,
                            ),
                            SizedBox(height: 5),
                            Text(
                              addressFile == null ? "Address proof" : "Address proof picked",
                              style: TextStyle(
                                fontFamily: FontType.MontserratRegular,
                                color: Colors.black87,
                                fontSize: addressFile == null ? 14 : 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    shadowColor: hsPrime.withOpacity(0.5),
                    child: InkWell(
                      onTap: () {
                        _showFilePick(context, 'aadhaarF');
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            aadharCardFFile == null
                                ? Icon(
                              Icons.upload_file_rounded,
                              color: Colors.black,
                              size: 30,
                            )
                                : const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 30,
                            ),
                            SizedBox(height: 5),
                            Text(
                              aadharCardFFile == null ? "Aadhaar card front" : "Aadhaar card front picked",
                              style: TextStyle(
                                fontFamily: FontType.MontserratRegular,
                                color: Colors.black87,
                                fontSize: aadharCardFFile == null ? 14 : 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    shadowColor: hsPrime.withOpacity(0.5),
                    child: InkWell(
                      onTap: () {
                        _showFilePick(context, 'aadhaarB');
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            aadharCardBFile == null
                                ? Icon(
                              Icons.upload_file_rounded,
                              color: Colors.black,
                              size: 30,
                            )
                                : const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 30,
                            ),
                            SizedBox(height: 5),
                            Text(
                              aadharCardBFile == null ? "Aadhaar card back" : "Aadhaar card back picked",
                              style: TextStyle(
                                fontFamily: FontType.MontserratRegular,
                                color: Colors.black87,
                                fontSize: aadharCardBFile == null ? 14 : 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    shadowColor: hsPrime.withOpacity(0.5),
                    child: InkWell(
                      onTap: () {
                        _showFilePick(context, 'checkFile');
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            checkFile == null
                                ? Icon(
                              Icons.upload_file_rounded,
                              color: Colors.black,
                              size: 30,
                            )
                                : const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 30,
                            ),
                            SizedBox(height: 5),
                            Text(
                              checkFile == null ? "Cheque photo" : "Cheque picked",
                              style: TextStyle(
                                fontFamily: FontType.MontserratRegular,
                                color: Colors.black87,
                                fontSize: checkFile == null ? 14 : 10,
                              ),
                              textAlign: TextAlign.center,
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
                  hintText: 'Pancard number',
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
            showTextField(
                'Bank name', bankName,Icons.account_balance_rounded,
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
                    hintText: 'IFSC code',
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
                    hintText: 'Account number',
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
                  hintText: 'Password',
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
                  hintText: 'Confirm password',
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
                      'I agree to the Terms of Condition and Privacy Policy',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: InkWell(
                onTap: ()async{
                  if(_agreedToTOS == false){
                    SnackBarMessageShow.warningMSG('Please select term & condition', context);
                  }
                  else{
                    if (_formKey.currentState.validate()) {
                      FocusScope.of(context).unfocus();
                      if(selectedState == null || selectedCity == null || selectedArea == null){
                        SnackBarMessageShow.warningMSG("Please select location fields", context);
                      }
                      else if(panCardFile == null || addressFile == null || aadharCardFFile == null || aadharCardBFile == null || checkFile == null){
                        SnackBarMessageShow.warningMSG("Please select documents", context);
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
                  }
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
              /*child: CustomButton(
                color: hsBlack,
                textColor: hsWhite,
                text: 'Create an account',
                onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    FocusScope.of(context).unfocus();
                    if(selectedState == null || selectedCity == null || selectedArea == null){
                      SnackBarMessageShow.warningMSG("Please Select Location Fields", context);
                    }
                    else if(panCardFile == null || addressFile == null || aadharCardFFile == null || aadharCardBFile == null){
                      SnackBarMessageShow.warningMSG("Please Select Documents", context);
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
                },
              ),*/
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

  _showFilePick(BuildContext context,var type){
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),),),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState){
              return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                          child: Text("Attach File",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsOne,fontSize: 20),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              color: hsTwo,
                              child: InkWell(
                                onTap: () async {
                                  try {
                                    final pickedFile = await FilePicker.platform.pickFiles(type: FileType.any);
                                    if (pickedFile == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: hsOne,
                                          content: const Text(
                                            'File picker canceled',
                                            style: TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    final file = File(pickedFile.files.single.path);
                                    setState(() {
                                      switch (type) {
                                        case 'panCard':
                                          panCardFile = file;
                                          break;
                                        case 'address':
                                          addressFile = file;
                                          break;
                                        case 'aadhaarF':
                                          aadharCardFFile = file;
                                          break;
                                        case 'checkFile':
                                          checkFile = file;
                                          break;
                                        default:
                                          aadharCardBFile = file;
                                          break;
                                      }
                                    });
                                    Navigator.pop(context);
                                  } on PlatformException catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: hsOne,
                                        content: Text(
                                          'Failed to pick file: ${e.message}',
                                          style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),
                                        ),
                                      ),
                                    );
                                    print("platForm-> $e");
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: hsOne,
                                        content: Text(
                                          'Unknown error: $e',
                                          style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),
                                        ),
                                      ),
                                    );
                                    print("error -> $e");
                                  }
                                  //fileOpen(context, setState,type);
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  height: MediaQuery.of(context).size.height / 8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.file_copy_rounded,color: Colors.white,size: 30,),
                                      SizedBox(height: 10),
                                      Text("File Manger",style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              color: hsTwo,
                              child: InkWell(
                                onTap: () async {
                                  try {
                                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                                    if (pickedFile == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: hsOne,
                                          content: const Text(
                                            'File picker canceled',
                                            style: TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    final file = File(pickedFile.path);
                                    setState(() {
                                      switch (type) {
                                        case 'panCard':
                                          panCardFile = file;
                                          break;
                                        case 'address':
                                          addressFile = file;
                                          break;
                                        case 'aadhaarF':
                                          aadharCardFFile = file;
                                          break;
                                        case 'checkFile':
                                          checkFile = file;
                                          break;
                                        default:
                                          aadharCardBFile = file;
                                          break;
                                      }
                                    });
                                    Navigator.pop(context);
                                  } on PlatformException catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: hsOne,
                                        content: Text(
                                          'Failed to pick file: ${e.message}',
                                          style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),
                                        ),
                                      ),
                                    );
                                    print("platForm-> $e");
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: hsOne,
                                        content: Text(
                                          'Unknown error: $e',
                                          style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),
                                        ),
                                      ),
                                    );
                                    print("error -> $e");
                                  }
                                  //cameraOpen(context, setState,type);
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  height: MediaQuery.of(context).size.height / 8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.camera_alt_rounded,color: Colors.white,size: 30,),
                                      SizedBox(height: 10),
                                      Text("Camera",style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
              );
            },
          );
        }
    );
  }

  void signUpData() async {
    var url = ApiUrls.signUpUrl;
    try {
      FormData formData = FormData.fromMap({
        "name": firstNm.text,
        "email_id": widget.emailId,
        "password": password.text,
        "mobile": mobile.text,
        "vendor_name": createVendor.text,
        "state_id": selectedState,
        'city_id': selectedCity,
        'area_id': selectedArea,
        'cost_center_id': selectedBranch,
        'address': address.text,
        'pincode': pincode.text,
        'pancard': await MultipartFile.fromFile(panCardFile.path),
        'pancard_number': panCardNo.text,
        'address_proof': await MultipartFile.fromFile(addressFile.path),
        'aadhar_front': await MultipartFile.fromFile(aadharCardFFile.path),
        'aadhar_back': await MultipartFile.fromFile(aadharCardBFile.path),
        'cheque_image': await MultipartFile.fromFile(checkFile.path),
        'sales_executive_admin_id': selectedSales ?? '',
        'b2b_subadmin_id': selectedB2b ?? '',
        'bank_name': bankName.text ?? '',
        'ifsc': ifscCode.text ?? '',
        'account_number': accountNo.text ?? '',
        'gst_number': gstNo.text ?? '',
      });
      print('Form -> ${formData.fields}');

      var dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true)); // Enable detailed logging

      var response = await dio.post(url, data: formData);
      print("Sign Response ->$response");
      final jsonData = response.data;

      print("sign jsonData-> $jsonData");

      if (jsonData['status'] == 200) {
        print("in if->${jsonData['status']} / ${jsonData['message']}");
        var bodyMSG = jsonData['message'];
          SnackBarMessageShow.successsMSG('$bodyMSG', context);
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
      } else if (jsonData['status'] == 400) {
        var errorData = response.data;
        var errorMessages = [];
        errorData['error'].forEach((field, messages) {
          messages.forEach((message) {
            errorMessages.add("$field: $message");
          });
        });
        var errorMessage = errorMessages.join("\n");
        SnackBarMessageShow.warningMSG(errorMessage, context);
      }
      else if (jsonData['status'] == 400) {
        var errorData = response.data;
        var errorMessage = errorData['error']['email_id'][0];
        SnackBarMessageShow.warningMSG(errorMessage, context);
      }
      else if (jsonData['status'] == 400) {
        var errorData = response.data;
        var errorMessage = errorData['error']['sales_executive_admin_id'][0];
        SnackBarMessageShow.warningMSG(errorMessage, context);
      }
      else {
        SnackBarMessageShow.errorMSG('Faild to load data', context);
      }
    } catch (e) {
      print('Error -> ${e.toString()}');
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }

  List<StateData> stateList = [];
  String selectedState;
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
