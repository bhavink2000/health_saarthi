//@dart=2.9
// ignore_for_file: use_build_context_synchronously, void_checks

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Cart%20Future/cart_future.dart';
import 'package:search_choices/search_choices.dart';
import '../../App Helper/Backend Helper/Api Future/Location Future/location_future.dart';
import '../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Backend Helper/Models/Cart Menu/book_order_model.dart';
import '../../App Helper/Backend Helper/Models/Cart Menu/mobile_number_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/area_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/city_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/state_model.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../Bottom Menus/Test Menu/thank_you_msg.dart';

class TestBookingScreen extends StatefulWidget {
  var testDis,packageDis,profileDis,promoApply;
  TestBookingScreen({Key key,this.testDis,this.packageDis,this.profileDis,this.promoApply}) : super(key: key);

  @override
  State<TestBookingScreen> createState() => _TestBookingScreenState();
}

class _TestBookingScreenState extends State<TestBookingScreen> {

  bool addVendor = false;
  File fileManger;
  //final mobileNo = TextEditingController();
  final emailId = TextEditingController();
  final address = TextEditingController();
  final pinCode = TextEditingController();
  final collectionDate = TextEditingController();
  final collectionTime = TextEditingController();
  final remark = TextEditingController();

  String selectedGender;
  final pAge = TextEditingController();
  final pDob = TextEditingController();
  final pName = TextEditingController();
  final pMobile = TextEditingController();

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    collectionDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        fetchMobileList();
      });
    });
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        fetchStateList();
      });
    });
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
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Padding(
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
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Enter DOB';
                            //   }
                            //   return null;
                            // },
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
                        ),
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
                            // Set the validator function
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              Flexible(
                                child: RadioListTile(
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

                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.w,
                            //height: MediaQuery.of(context).size.height / 14.h,
                            child: DropdownSearch<String>(
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              mode: Mode.DIALOG,
                              showSearchBox: true,
                              showSelectedItem: true,
                              items: stateList.where((state) => state.stateName != null).map((state) => state.stateName).toList(),
                              label: "Select state *",
                              onChanged: (newValue) {
                                final selectedStateObject = stateList.firstWhere((state) => state.stateName == newValue, orElse: () => null);
                                if (selectedStateObject != null) {
                                  setState(() {
                                    selectedCity = '';
                                    selectedArea = '';
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
                        SizedBox(height: 15,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.w,
                            //height: MediaQuery.of(context).size.height / 14.h,
                            child: DropdownSearch<String>(
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
                                    selectedArea = '';
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
                        SizedBox(height: 15,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.w,
                            //height: MediaQuery.of(context).size.height / 14.h,
                            child: DropdownSearch<String>(
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              mode: Mode.DIALOG,
                              showSearchBox: true,
                              showSelectedItem: true,
                              items: areaList?.map((area) => area.areaName)?.toList() ?? [],
                              label: "Select area *",
                              onChanged: (newValue) {
                                final selectedAreaObject = areaList.firstWhere((area) => area.areaName  == newValue, orElse: () => null);
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
                                  return 'Select a area';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: TextFormField(
                            controller: collectionDate,
                            readOnly: true,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(hsPaddingM),
                              border: OutlineInputBorder(),
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
                                  collectionDate.text = formattedDate;
                                });
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                              hintText: 'Pin code *',
                              hintStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontFamily: FontType.MontserratRegular,
                                  fontSize: 14
                              ),
                              prefixIcon: const Icon(Icons.pin, color: hsBlack,size: 20),
                            ),
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Enter pin code';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: TextFormField(
                            controller: remark,
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
                              hintText: 'Remark *',
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                                fontFamily: FontType.MontserratRegular,
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(Icons.note_add_rounded, color: hsBlack, size: 20),
                            ),

                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter Remark';
                            //   }
                            //   return null;
                            // }, // Set the validator function
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                          child: InkWell(
                            onTap: ()async{
                              if (_formKey.currentState.validate()) {
                                FocusScope.of(context).unfocus();
                                if(selectedState == null || selectedCity == null || selectedArea == null){
                                  SnackBarMessageShow.warningMSG("Please Select Location Fields", context);
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
      print("Error -> $e");
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
      print("Error -> $e");
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
      print("Error -> $e");
    }
  }

  var pharmacyId;
  void getPatient(var patientId) async {
    try {
      var pModel = await CartFuture().fetchPatientProfile(getAccessToken.access_token, patientId);
      setState(() {
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
      });
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> bookOrder() async {
    final pGender = selectedGender == 'Male' ? 1 : selectedGender == 'Female' ? 2 : selectedGender == 'Other' ? 3 : 0;

    print("test->${widget.testDis}/${widget.packageDis}.${widget.profileDis}/${widget.promoApply}");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    final Map<String, dynamic> requestBody = {
      "pharmacy_patient_id": selectedMobileNo?.toString() ?? '',
      "pharmacy_id": pharmacyId?.toString() ?? '',
      "test_discount_id": '${widget.testDis ?? ''}',
      "package_discount_id": '${widget.packageDis ?? ''}',
      "profile_discount_id": '${widget.profileDis ?? ''}',
      "promo_offer_code": '${widget.promoApply ?? ''}',
      "collection_date": collectionDate.text ?? '',
      "collection_time": collectionTime.text ?? '',
      "remark": remark?.text ?? '',
      "name": pName?.text ?? '',
      "email_id": emailId?.text ?? '',
      "mobile_no": pMobile?.text ?? '',
      "gender": '$pGender',
      "date_of_birth": pDob?.text ?? '',
      "age": pAge?.text ?? '',
      "state_id": selectedStateId ?? '',
      'city_id': selectedCityId ?? '',
      'area_id': selectedAreaId ?? '',
      'pincode': pinCode?.text ?? '',
      'address': address?.text ?? '',
    };
    print("Body ->$requestBody");
    try {
      print("in try");

      final response = await http.post(
        Uri.parse(ApiUrls.bookOrderUrls),
        headers: headers,
        body: requestBody,
      );

      final responseData = json.decode(response.body);
      print("response -> $responseData");

      final bodyStatus = responseData['status'];
      final bodyMsg = responseData['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMsg', context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ThankYouPage()));
      } else if (bodyStatus == 400) {
        if (responseData['error'] != null) {
          if (responseData['error']['email_id'] != null) {
            final bodyMsg = responseData['error']['email_id'][0];
            SnackBarMessageShow.warningMSG('$bodyMsg', context);
            Navigator.pop(context);
          } else if (responseData['error']['pincode'] != null) {
            final bodyMsg = responseData['error']['pincode'][0];
            SnackBarMessageShow.warningMSG('$bodyMsg', context);
            Navigator.pop(context);
          } else if (responseData['error']['address'] != null) {
            final bodyMsg = responseData['error']['address'][0];
            SnackBarMessageShow.warningMSG('$bodyMsg', context);
            Navigator.pop(context);
          } else {
            SnackBarMessageShow.warningMSG('Something went wrong', context);
          }
        }
      }
      else {
        SnackBarMessageShow.warningMSG('Something went wrong', context);
      }
    } catch (error) {
      print("Error: $error");
    }
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
}
