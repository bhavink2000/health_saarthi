//@dart=2.9
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_choices/search_choices.dart';
import 'package:intl/intl.dart';
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
import '../../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../../Add To Cart/test_cart.dart';
import '../../../Notification Menu/notification_menu.dart';
import '../../Test Menu/thank_you_msg.dart';

class InstantBooking extends StatefulWidget {
  const InstantBooking({Key key}) : super(key: key);

  @override
  State<InstantBooking> createState() => _InstantBookingState();
}

class _InstantBookingState extends State<InstantBooking> {

  final emailId = TextEditingController();
  final address = TextEditingController();
  final pinCode = TextEditingController();
  final colletionDate = TextEditingController();
  final remark = TextEditingController();

  String selectedGender;
  final pAge = TextEditingController();
  final pDob = TextEditingController();
  final pName = TextEditingController();
  final pMobile = TextEditingController();

  bool stateLoading = false;
  bool areaLoading = false;
  bool cityLoading = false;
  bool branchLoading = false;

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    colletionDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // Future.delayed(const Duration(seconds: 1),(){
    //   setState(() {
    //     fetchMobileList();
    //   });
    // });
    // Future.delayed(const Duration(seconds: 2),(){
    //   setState(() {
    //     fetchStateList();
    //   });
    // });
    functionCalling();
  }

  void functionCalling()async{
    await fetchStateList();
    await fetchMobileList();
  }

  final _formKey = GlobalKey<FormState>();
  void resetCityAndAreaSelection() {
    setState(() {
      selectedCity = null;
      selectedArea = null;
    });
    fetchStateList();
  }

  @override
  void dispose() {
    selectedMobileNo = '';
    selectedGender = '';
    remark.text = '';
    pName.text = '';
    emailId.text = '';
    pMobile.text = '';
    pDob.text = '';
    pAge.text = '';
    pinCode.text = '';
    address.text = '';
    selectedState = '';
    selectedCity = '';
    selectedArea = '';
    selectedBranch = '';
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                            }, icon: const Icon(Icons.arrow_back,color: Colors.black,size: 24)),
                          SizedBox(width: 10.w),
                          Text("Instant Booking",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.bold),)
                        ],
                      )
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                      }, icon: Icon(Icons.shopping_cart_outlined,color: hsInstantBookingColor,size: 24)),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationMenu()));
                      }, icon: Icon(Icons.circle_notifications_rounded,color: hsInstantBookingColor,size: 24)),
                    ],
                  )
                ],
              ),
            ),
            Divider(color: Colors.grey.withOpacity(0.5),thickness: 1),
            Expanded(
              child: stateLoading == false ? SingleChildScrollView(
                primary: false,
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
                                  labelText: 'Select mobile number',
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
                                return mobileList.where((item) => item.mobileNo.toLowerCase().contains(pattern.toLowerCase()));
                              },
                              itemBuilder: (context, MobileData suggestion) {
                                return ListTile(
                                  title: Text(suggestion.mobileNo),
                                );
                              },
                              onSuggestionSelected: (MobileData suggestion) {
                                setState(() {
                                  selectedMobileNo = suggestion.encPharmacyPatientId;
                                  getPatient(selectedMobileNo);
                                  pMobile.text = suggestion.mobileNo; // Assign the selected mobile number to the controller's text property
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Select a mobile number';
                                }
                                return null;
                              },
                              onSaved: (value) => this.selectedMobileNo = value,
                            )
                        ),
                      ),
                      showTextField(
                          'Patient name *', pName,Icons.person,
                              (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter patient name';
                            }
                            return null;
                          }
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          controller: pAge,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(hsPaddingM),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            hintText: 'Age',
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                              fontFamily: FontType.MontserratRegular,
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(Icons.view_agenda_rounded, color: hsBlack, size: 20),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Enter age';
                          //   }
                          //   return null;
                          // }, // Set the validator function
                        ),
                      ),
                      /*Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          controller: pDob,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(hsPaddingM),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            hintText: 'DOB',
                            hintStyle: const TextStyle(
                                color: Colors.black54,
                                fontFamily: FontType.MontserratRegular,
                                fontSize: 14
                            ),
                            prefixIcon: const Icon(Icons.calendar_month_rounded, color: hsBlack,size: 20),
                          ),
                          onTap: () async {
                            DateTime pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if(pickedDate != null ){
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                pDob.text = formattedDate;
                              });
                            }else{}
                          },
                        ),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          controller: emailId,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(hsPaddingM),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            hintText: 'Email id',
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                              fontFamily: FontType.MontserratRegular,
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(Icons.email, color: hsBlack, size: 20),
                          ),
                          onChanged: (value) {
                            _formKey.currentState?.validate(); // Trigger validation manually
                          },
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (!value.contains('@')) {
                                return 'Email id must contain "@" symbol';
                              }
                            }
                            return null; // Return null if no validation error
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          controller: address,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(hsPaddingM),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            hintText: 'Address',
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                              fontFamily: FontType.MontserratRegular,
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(Icons.location_city_rounded, color: hsBlack, size: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          children: [
                            Flexible(
                              child: RadioListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                title: const Text('Female',style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                value: 'Female',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                title: const Text('Male',style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                value: 'Male',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                title: const Text('Other',style: TextStyle(fontFamily: FontType.MontserratRegular),),
                                value: 'Other',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    setState((){
                                      selectedGender = value;
                                    });
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),

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
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.w,
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
                      const SizedBox(height: 15,),
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
                                      branchList.clear();
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
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

                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          controller: colletionDate,
                          readOnly: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(hsPaddingM),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: 'Collection date',
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                              fontFamily: FontType.MontserratRegular,
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(Icons.date_range_rounded, color: hsBlack, size: 20),
                          ),
                          onTap: () async {
                            DateTime pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                colletionDate.text = formattedDate;
                              });
                            }
                          },
                        ),
                      ),
                      /*Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          controller: pinCode,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.all(hsPaddingM),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            hintText: 'Pin code',
                            hintStyle: const TextStyle(
                                color: Colors.black54,
                                fontFamily: FontType.MontserratRegular,
                                fontSize: 14
                            ),
                            prefixIcon: const Icon(Icons.pin, color: hsBlack,size: 20),
                          ),
                        ),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          controller: remark,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(hsPaddingM),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            hintText: 'Remark',
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                              fontFamily: FontType.MontserratRegular,
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(Icons.note_add_rounded, color: hsBlack, size: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                        child: InkWell(
                          onTap: ()async{
                            if(pName.text.isEmpty){
                              GetXSnackBarMsg.getWarningMsg('${AppTextHelper().patientName}');
                            }
                            else if(pMobile.text.isEmpty){
                              GetXSnackBarMsg.getWarningMsg('${AppTextHelper().patientMobile}');
                            }
                            else if(selectedState == null || selectedState == ''){
                              GetXSnackBarMsg.getWarningMsg('${AppTextHelper().selectState}');
                            }
                            else if(selectedCity == null || selectedCity == ''){
                              GetXSnackBarMsg.getWarningMsg('${AppTextHelper().selectCity}');
                            }
                            else if(selectedArea == null || selectedArea == ''){
                              GetXSnackBarMsg.getWarningMsg('${AppTextHelper().selectArea}');
                            }
                            else if(selectedBranch == null || selectedBranch == ''){
                              GetXSnackBarMsg.getWarningMsg('${AppTextHelper().selectBranch}');
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
                              await instantBooking();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsInstantBookingColor),
                            child: Text("Confirm Booking",style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white,fontSize: 18.sp,letterSpacing: 1)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ) : CenterLoading(),
            )
          ],
        ),
      ),
    );
  }
  Widget showTextField(var label, TextEditingController controller, IconData iconData, String Function(String) validator) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(hsPaddingM),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
              borderRadius: BorderRadius.circular(15)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
              borderRadius: BorderRadius.circular(15)
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

  List<MobileData> mobileList = [];
  String selectedMobileNo;
  Future<void> fetchMobileList() async {
    try {
      CartFuture cartFuture = CartFuture();
      List<MobileData> list = await cartFuture.getMobileNumber(getAccessToken.access_token, selectedMobileNo);
      setState(() {
        mobileList = list;
      });
    } catch (e) {
      print("Error -> $e");
    }
  }
  var pharmacyId;
  void getPatient(var patientId) async {
    try {
      var pModel = await CartFuture().fetchPatientProfile(getAccessToken.access_token, patientId);
      pharmacyId = pModel.patientData.pharmacyId.toString();
      pName.text = pModel.patientData.name.toString();
      pDob.text = pModel.patientData.dateOfBirth.toString();
      pAge.text = pModel.patientData.age.toString();
      pMobile.text = pModel.patientData.mobileNo.toString();
      emailId.text = pModel.patientData.emailId.toString();
      address.text = pModel.patientData.address.toString();
      selectedGender = pModel.patientData.gender.toString() == '1' ? 'Male' : pModel.patientData.gender.toString() == '2' ? 'Female' : 'Other';
      selectedState = pModel.patientData.state.stateName.toString();
      selectedCity = pModel.patientData.city.cityName.toString();
      selectedArea = pModel.patientData.area.areaName.toString();
      selectedStateId = pModel.patientData.state.id.toString();
      selectedCityId = pModel.patientData.city.id.toString();
      selectedAreaId = pModel.patientData.area.id.toString();
      pinCode.text = pModel.patientData.pincode.toString();
    } catch (e) {
      print('Error: $e');
    }
  }

  final GlobalKey<State> _loadingDialogKey = GlobalKey<State>();
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
  List<StateData> stateList = [];
  String selectedState;
  String selectedStateId;
  Future<void> fetchStateList() async {
    //_showLoadingDialog(context);
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
      //Navigator.of(_loadingDialogKey.currentContext, rootNavigator: true).pop();
    } catch (e) {
      print("Error -> $e");
      //Navigator.of(_loadingDialogKey.currentContext, rootNavigator: true).pop();
    }
  }

  List<CityData> cityList = [];
  String selectedCity;
  String selectedCityId;
  Future<void> fetchCityList(var sState) async {
    //_showLoadingDialog(context);
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
      //Navigator.of(_loadingDialogKey.currentContext, rootNavigator: true).pop();
    } catch (e) {
      print("Error -> $e");
      //Navigator.of(_loadingDialogKey.currentContext, rootNavigator: true).pop();
    }
  }

  List<AreaData> areaList = [];
  String selectedArea;
  String selectedAreaId;
  Future<void> fetchAreaList(var sState, var sCity) async {
    //_showLoadingDialog(context);
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
      //Navigator.of(_loadingDialogKey.currentContext, rootNavigator: true).pop();
    } catch (e) {
      print("Error -> $e");
      //Navigator.of(_loadingDialogKey.currentContext, rootNavigator: true).pop();
    }
  }

  List<BranchData> branchList = [];
  String selectedBranch;
  String selectedBranchId;
  Future<void> fetchBranchList(var sState, var sCity, var sArea) async {
    //_showLoadingDialog(context);
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
      //Navigator.of(_loadingDialogKey.currentContext, rootNavigator: true).pop();
    } catch (e) {
      print("Branch Error -> $e");
      //Navigator.of(_loadingDialogKey.currentContext, rootNavigator: true).pop();
    }
  }

  Future<void> instantBooking() async {
    final pGender = selectedGender == 'Male' ? 1 : selectedGender == 'Female' ? 2 : selectedGender == 'Other' ? 3 : 0;

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    final Map<String, dynamic> requestBody = {
      "pharmacy_patient_id": selectedMobileNo ?? '',
      "collection_date": colletionDate.text ?? '',
      "remark": remark?.text ?? '',
      "name": pName?.text ?? '',
      "email_id": emailId?.text ?? '',
      "mobile_no": pMobile?.text ?? '',
      "gender": '$pGender',
      //"date_of_birth": pDob?.text ?? '',
      "age": pAge?.text ?? '',
      "state_id": selectedStateId ?? '',
      'city_id': selectedCityId ?? '',
      'area_id': selectedAreaId ?? '',
      'cost_center_id': selectedBranchId ?? '',
      //'pincode': pinCode?.text ?? '',
      'address': address?.text ?? '',
    };
    print("Body ->$requestBody");
    try {
      print("in try");

      final response = await http.post(
        Uri.parse(ApiUrls.instantBookingUrls),
        headers: headers,
        body: requestBody,
      );

      final responseData = json.decode(response.body);
      print("response -> $responseData");

      final bodyStatus = responseData['status'];
      final bodyMsg = responseData['message'];

      if (bodyStatus == 200) {
        GetXSnackBarMsg.getSuccessMsg('$bodyMsg');
        selectedMobileNo = '';
        selectedGender = '';
        remark.text = '';
        pName.text = '';
        emailId.text = '';
        pMobile.text = '';
        pDob.text = '';
        pAge.text = '';
        pinCode.text = '';
        address.text = '';
        selectedState = '';
        selectedCity = '';
        selectedArea = '';
        selectedBranch = '';
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ThankYouPage()));
      } else if (bodyStatus == 400) {
        final msg = responseData['error']['mobile_no'][0];
        GetXSnackBarMsg.getWarningMsg('$msg');
        Navigator.pop(context);
      } else {
        GetXSnackBarMsg.getWarningMsg('${AppTextHelper().bookingProblem}');
      }
    } catch (error) {
      print("Error: $error");
      GetXSnackBarMsg.getWarningMsg('${AppTextHelper().serverError}');
      Navigator.pop(context);
      //SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }
}
