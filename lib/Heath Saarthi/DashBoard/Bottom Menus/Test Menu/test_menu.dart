//@dart=2.9
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_choices/search_choices.dart';
import '../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../App Helper/Backend Helper/Api Future/Location Future/location_future.dart';
import '../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Backend Helper/Models/Cart Menu/mobile_number_model.dart';
import '../../../App Helper/Backend Helper/Models/Location Model/area_model.dart';
import '../../../App Helper/Backend Helper/Models/Location Model/city_model.dart';
import '../../../App Helper/Backend Helper/Models/Location Model/state_model.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import 'thank_you_msg.dart';

class TestMenu extends StatefulWidget {
  const TestMenu({Key key}) : super(key: key);

  @override
  State<TestMenu> createState() => _TestMenuState();
}

class _TestMenuState extends State<TestMenu> {

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

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                child: Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 12.h,
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: SearchChoices.single(
                      dropDownDialogPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      items: mobileList.map((number) {
                        return DropdownMenuItem<String>(
                          value: number.encPharmacyPatientId.toString() ?? '',
                          child: Text(number.mobileNo),
                        );
                      }).toList() ?? [],
                      value: selectedMobileNo,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 15,letterSpacing: 1,color: Colors.black87),
                      hint: "Select Mobile Number",
                      searchHint: "Select Number",
                      onChanged: (value) {
                        setState(() {
                          selectedMobileNo = value;
                          getPatient(selectedMobileNo);
                        });
                      },
                      isExpanded: true,
                    ),
                  ),
                ),
              ),
              showTextField('Patient Name', pName,Icons.person),
              showTextField('Patient Mobile No', pMobile,Icons.mobile_friendly_rounded),
              showTextField('Patient Age', pAge,Icons.view_agenda),
              showTextField('DOB', pDob,Icons.calendar_month_rounded),
              showTextField('Email', emailId,Icons.email),
              showTextField('Address', address,Icons.location_city),
              Row(
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
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 2.2.w,
                      height: MediaQuery.of(context).size.height / 18.h,
                      child: DropdownButtonFormField<String>(
                        value: selectedState,
                        style: const TextStyle(fontSize: 10, color: Colors.black87),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(hsPaddingM),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12))),
                          hintText: 'State',
                          hintStyle: const TextStyle(color: Colors.black54, fontFamily: FontType.MontserratRegular, fontSize: 12),
                        ),
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
                            });
                            fetchStateList();
                          }
                        },
                        items: stateList.map((state) => DropdownMenuItem<String>(
                          value: state.id?.toString() ?? '',
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3.8,
                            child: Text(state.stateName ?? ''),
                          ),
                        )).toList(),
                      )
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2.w,
                    height: MediaQuery.of(context).size.height / 18.h,
                    child: DropdownButtonFormField<String>(
                      value: selectedCity,
                      style: const TextStyle(fontSize: 10,color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(hsPaddingM),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                        hintText: 'City',
                        hintStyle: const TextStyle(color: Colors.black54, fontFamily: FontType.MontserratRegular, fontSize: 12,),
                      ),
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
                          });
                          fetchAreaList(selectedState, selectedCity);
                        }
                      },
                      items: cityList?.map((city) => DropdownMenuItem<String>(
                        value: city.id.toString() ?? '',
                        child: Container(
                            width: MediaQuery.of(context).size.width / 3.5.w,
                            child: Text(city.cityName)
                        ),
                      ))?.toList() ?? [],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2.w,
                    height: MediaQuery.of(context).size.height / 18.h,
                    child: DropdownButtonFormField<String>(
                      value: selectedArea,
                      style: const TextStyle(fontSize: 10,color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(hsPaddingM),
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
                      onChanged: (newValue) {
                        selectedArea = newValue;
                      },
                      onTap: (){
                        fetchAreaList(selectedState, selectedCity);
                      },
                      items: areaList?.map((area) => DropdownMenuItem<String>(
                        value: area.id.toString() ?? '',
                        child: Container(
                            width: MediaQuery.of(context).size.width / 3.5.w,
                            child: Text(area.areaName)
                        ),
                      ))?.toList() ?? [],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2.w,
                    height: MediaQuery.of(context).size.height / 15.h,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: TextField(
                        controller: pinCode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(10, 2, 5, 2),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          hintText: 'Pincode',
                          hintStyle: const TextStyle(
                              color: Colors.black54,
                              fontFamily: FontType.MontserratRegular,
                              fontSize: 14
                          ),
                          prefixIcon: Icon(Icons.pin, color: hsBlack,size: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              showTextField('Collection Date', colletionDate,Icons.date_range_rounded),
              showTextField('Remark', remark,Icons.markunread_mailbox),

              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                child: InkWell(
                  onTap: (){
                    if(pName.text.isEmpty || pMobile.text.isEmpty || pAge.text.isEmpty || address.text.isEmpty ||
                        pDob.text.isEmpty || emailId.text.isEmpty || colletionDate.text.isEmpty){
                      SnackBarMessageShow.warningMSG('Please Fill All Field', context);
                    }
                    else{
                      instantBooking();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsPrime),
                    child: Text("Processed",style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white,fontSize: 18.sp,letterSpacing: 1)),
                  ),
                ),
              )
            ],
          ),
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
    } catch (e) {
      print('Error: $e');
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
      print("Error -> $e");
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
      print("Error -> $e");
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
      print("Error -> $e");
    }
  }
  Widget showTextField(var lebal, TextEditingController controller, IconData iconData){
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(hsPaddingM),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
              borderRadius: BorderRadius.circular(15)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
              borderRadius: BorderRadius.circular(15)
          ),
          hintText: '$lebal',
          hintStyle: const TextStyle(
              color: Colors.black54,
              fontFamily: FontType.MontserratRegular,
              fontSize: 14
          ),
          prefixIcon: Icon(iconData, color: hsBlack,size: 20),
        ),
      ),
    );
  }

  Future<void> instantBooking() async {
    final pGender =
    selectedGender == 'Male' ? 1 : selectedGender == 'Female' ? 2 : selectedGender == 'Other' ? 3 : 0;

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
      "date_of_birth": pDob?.text ?? '',
      "age": pAge?.text ?? '',
      "state_id": selectedState ?? '',
      'city_id': selectedCity ?? '',
      'area_id': selectedArea ?? '',
      'pincode': pinCode?.text ?? '',
      'address': address?.text ?? '',
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.instantBookingUrls));
      request.headers.addAll(headers);

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      var parsedResponse = json.decode(responseData);
      print("response -> $parsedResponse");

      var bodyStatus = parsedResponse['status'];
      var bodyMsg = parsedResponse['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMsg', context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ThankYouPage()));
      } else if (bodyStatus == 400) {
        SnackBarMessageShow.warningMSG('$bodyMsg', context);
      } else {
        SnackBarMessageShow.errorMSG('Something went wrong', context);
      }
    } catch (error) {
      print("Error: $error");
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }
}
