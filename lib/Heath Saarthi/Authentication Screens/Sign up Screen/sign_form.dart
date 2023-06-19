//@dart=2.9
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Providers/Location%20Provider/location_provider.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../App Helper/Backend Helper/Api Future/Location Future/location_future.dart';
import '../../App Helper/Backend Helper/Models/Location Model/area_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/branch_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/city_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/state_model.dart';
import '../../App Helper/Backend Helper/Providers/Authentication Provider/sign_up_provider.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../Login Screen/Login Widgets/custom_button.dart';
import '../Login Screen/Login Widgets/fade_slide_transition.dart';
import '../Login Screen/login_screen.dart';

class SignUpForm extends StatefulWidget {
  final Animation<double> animation;
  var screenH;
  SignUpForm({Key key,this.animation,this.screenH}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  File panCardFile;
  File addressFile;
  File aadharCardFFile;
  File aadharCardBFile;

  final createVendor = TextEditingController();
  final firstNm = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  bool showOTP = false;

  final otpVerify = TextEditingController();
  final address = TextEditingController();
  final seMobile = TextEditingController();
  bool showExecutive = false;
  final pincode = TextEditingController();
  final password = TextEditingController();
  final cPassword = TextEditingController();

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


  String getMobileNumber(String selectedName) {
    final selectedExecutive = salesExecutiveList.firstWhere(
          (executive) => executive['name'] == selectedName,
      orElse: () => null,
    );
    return selectedExecutive != null ? selectedExecutive['mobile_no'] : '';
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? hsSpaceM : hsSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: space,
              child: DropdownButtonFormField<String>(
                value: selectedB2b,
                style: const TextStyle(fontSize: 12,color: Colors.black87),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
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
                items: b2bSubAdminList?.map((subAdmin) => DropdownMenuItem(
                  value: subAdmin['id'].toString(),
                  child: Container(
                      width: MediaQuery.of(context).size.width / 1.5.w,
                      child: Text(subAdmin['name'])
                  ),
                ))?.toList() ?? [],
              ),
            ),
          ),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 0.0,
            child: showTextField('Full Name', firstNm,Icons.person),
          ),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 0.0,
            child: showTextField('Vendor Name', createVendor,Icons.person_pin),
          ),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            child: Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width / 1.35.w,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(hsPaddingM),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                          ),
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                              color: Colors.black54,
                              fontFamily: FontType.MontserratRegular,
                              fontSize: 14
                          ),
                          prefixIcon: const Icon(Icons.email, color: hsBlack,size: 20),
                        ),
                      ),
                    )
                ),
                InkWell(
                  onTap: (){
                    if(email.text.isEmpty){
                      SnackBarMessageShow.warningMSG('Please Enter Email Id', context);
                    }
                    else{
                      verifyEmailId(email.text);
                      setState(() {
                        showOTP = true;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black87),
                    child: Text(showOTP == true ? "Resend" : "Verify",style: TextStyle(color: Colors.white70,fontFamily: FontType.MontserratRegular),),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: showOTP,
            child: FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: space,
              child: Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 1.35.w,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: TextField(
                          controller: otpVerify,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(hsPaddingM),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                            ),
                            hintText: 'OTP',
                            hintStyle: const TextStyle(
                                color: Colors.black54,
                                fontFamily: FontType.MontserratRegular,
                                fontSize: 14
                            ),
                            prefixIcon: const Icon(Icons.code_rounded, color: hsBlack,size: 20),
                          ),
                        ),
                      )
                  ),
                  InkWell(
                    onTap: (){
                      if(otpVerify.text.isEmpty){
                        SnackBarMessageShow.warningMSG('Please Enter OTP', context);
                      }
                      else{
                        submitOtp(email.text, otpVerify.text);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black87),
                      child: const Text("Submit",style: TextStyle(color: Colors.white70,fontFamily: FontType.MontserratRegular),),
                    ),
                  )
                ],
              ),
            ),
          ),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            child: showTextField('Mobile', mobile,Icons.mobile_friendly),
          ),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            child: showTextField('Address', address,Icons.location_city),
          ),
          SizedBox(height: space),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.3,
                //height: MediaQuery.of(context).size.height / 18,
                child: FadeSlideTransition(
                  animation: widget.animation,
                  additionalOffset: space,
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
                          selectedBranch = null;
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
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.3,
                child: FadeSlideTransition(
                  animation: widget.animation,
                  additionalOffset: space,
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
                          selectedBranch = null;
                        });
                        fetchAreaList(selectedState, selectedCity);
                      }
                    },
                    items: cityList?.map((city) => DropdownMenuItem<String>(
                      value: city.id.toString() ?? '',
                      child: Container(
                        width: MediaQuery.of(context).size.width / 4.w,
                        child: Text(city.cityName)
                      ),
                    ))?.toList() ?? [],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              //height: MediaQuery.of(context).size.height / 18,
              child: FadeSlideTransition(
                animation: widget.animation,
                additionalOffset: space,
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
                  items: areaList?.map((area) => DropdownMenuItem<String>(
                    value: area.id.toString() ?? '',
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5.w,
                      child: Text(area.areaName)
                    ),
                  ))?.toList() ?? [],
                ),
              ),
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: FadeSlideTransition(
                animation: widget.animation,
                additionalOffset: space,
                child: DropdownButtonFormField<String>(
                  value: selectedBranch,
                  style: const TextStyle(fontSize: 10,color: Colors.black87),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),),
                    hintText: 'Branch',
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 12,
                    ),
                  ),
                  onChanged: (newValue) {
                    selectedBranch = newValue;
                  },
                  items: branchList?.map((branch) => DropdownMenuItem<String>(
                    value: branch.id.toString() ?? '',
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5.w,
                      child: Text(branch.branchName)
                    ),
                  ))?.toList() ?? [],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: space,
              child: DropdownButtonFormField<String>(
                value: selectedSales,
                style: const TextStyle(fontSize: 10,color: Colors.black87),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Sales Executive',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: FontType.MontserratRegular,
                    fontSize: 12,
                  ),
                ),
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
          ),

          SizedBox(height: space),
          Visibility(
            visible: showExecutive,
            child: FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: space,
              child: showTextField('Executive Mobile ', seMobile,Icons.mobile_friendly),
            ),
          ),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            child: showTextField('PinCode No', pincode,Icons.code),
          ),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            child: SizedBox(
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
                      onTap: (){
                        _showFilePick(context,'panCard');
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.upload_file_rounded,color: Colors.black,size: 30),
                            const SizedBox(height: 5,),
                            Text(
                              panCardFile == null
                                  ? "Pan Card"
                                  :  panCardFile.path.split('/').last,
                              style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,fontSize: panCardFile == null ? 14 : 10),)
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
                      onTap: (){
                        _showFilePick(context,'address');
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.upload_file_rounded,color: Colors.black,size: 30),
                            const SizedBox(height: 5,),
                            Text(
                              addressFile == null
                                  ? "Address Proof"
                                  : addressFile.path.split('/').last,
                              style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,fontSize: addressFile == null ? 14 : 10),)
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: space,
              child: SizedBox(
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
                        onTap: (){
                          _showFilePick(context,'aadhaarF');
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: MediaQuery.of(context).size.height / 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.upload_file_rounded,color: Colors.black,size: 30),
                              const SizedBox(height: 5,),
                              Text(
                                aadharCardFFile == null
                                    ? "Aadhaar Card Front"
                                    : aadharCardFFile.path.split('/').last,
                                style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,fontSize: aadharCardFFile == null ? 14 : 10),)
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
                        onTap: (){
                          _showFilePick(context,'aadhaarB');
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: MediaQuery.of(context).size.height / 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.upload_file_rounded,color: Colors.black,size: 30),
                              const SizedBox(height: 5,),
                              Text(
                                aadharCardBFile == null
                                    ? "Aadhaar Card Back"
                                    : aadharCardBFile.path.split('/').last,
                                style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,fontSize:  aadharCardBFile == null ? 14 : 10),)
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )
          ),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
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
                  suffixIcon: const Icon(Icons.remove_red_eye_sharp, color: hsBlack,size: 20),
                ),
              ),
            ),
          ),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextField(
                controller: cPassword,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(hsPaddingM),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                  ),
                  hintText: 'Confirm Password',
                  hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: FontType.MontserratRegular,
                      fontSize: 14
                  ),
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: hsBlack,size: 20),
                  suffixIcon: const Icon(Icons.remove_red_eye_sharp, color: hsBlack,size: 20),
                ),
              ),
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 4 * space,
            child: CustomButton(
              color: hsBlack,
              textColor: hsWhite,
              text: 'Create a Account',
              onPressed: () {
                signUpData();
              },
            ),
          ),
          SizedBox(height: space),
        ],
      ),
    );
  }

  Widget showTextField(var lebal, TextEditingController controller, IconData iconData){
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(hsPaddingM),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
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
                                      type == 'panCard'
                                          ? panCardFile = file
                                          : type == 'address'
                                          ? addressFile = file
                                          : type == 'aadhaarF'
                                          ? aadharCardFFile = file
                                          : aadharCardBFile = file;
                                    });
                                    Navigator.pop(context);
                                  } on PlatformException catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      backgroundColor: hsOne,
                                      content: Text('Failed to pick file: ${e.message}', style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),),
                                    ),);
                                    print("platForm-> $e");
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: hsOne,
                                        content: Text('Unknown error: $e', style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),),
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
                                onTap: ()async{
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
                                      type == 'panCard'
                                          ? panCardFile = file
                                          : type == 'address'
                                          ? addressFile = file
                                          : type == 'aadhaarF'
                                          ? aadharCardFFile = file
                                          : aadharCardBFile = file;
                                    });
                                    Navigator.pop(context);
                                  } on PlatformException catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      backgroundColor: hsOne,
                                      content: Text('Failed to pick file: ${e.message}', style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),),
                                    ),);
                                    print("platForm-> $e");
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: hsOne,
                                        content: Text('Unknown error: $e', style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),),
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
        "email_id": email.text,
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
        'address_proof': await MultipartFile.fromFile(addressFile.path),
        'aadhar_front': await MultipartFile.fromFile(aadharCardFFile.path),
        'aadhar_back': await MultipartFile.fromFile(aadharCardBFile.path),
        'sales_executive_admin_id': selectedSales ?? '',
        'b2b_subadmin_id': selectedB2b ?? '',
      });
      print('Form -> ${formData.fields}');

      var dio = Dio();
      //dio.interceptors.add(LogInterceptor(responseBody: true)); // Enable detailed logging

      var response = await dio.post(url, data: formData);
      print("Sign Response ->$response");
      if (response.statusCode == 200) {
        final jsonData = response.data;
        var bodyStatus = jsonData['status'];
        var bodyMSG = jsonData['message'];
        if (bodyStatus == 200) {
          SnackBarMessageShow.successsMSG('$bodyMSG', context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
        } else if(bodyStatus == 400){
          var errorData = response.data;
          var errorMsg = errorData['0']['b2b_subadmin_id'][0]; // Extract the error message
          SnackBarMessageShow.errorMSG(errorMsg, context);
        }
        else {
          SnackBarMessageShow.errorMSG('$bodyMSG', context);
        }
      }
      else if (response.statusCode == 400) {
        var errorData = response.data;
        var errorMessage = errorData['0']['email_id'][0];
        SnackBarMessageShow.errorMSG(errorMessage, context);
      } else {
        SnackBarMessageShow.errorMSG('Failed to load data', context);
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
      print("Error -> $e");
    }
  }

  List<dynamic> b2bSubAdminList = [];
  List<dynamic> salesExecutiveList = [];
  Future<void> getB2bSalesList() async {
    print("calling");
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
      print("Error -> $e");
    }
  }

  var getOtp;
  var getEmail;
  Future<String> verifyEmailId(var emailId) async {
    print("Calling Url->${showOTP == true ? ApiUrls.reSendOtpUrl : ApiUrls.sendOtpUrl}");
    await http.post(
        Uri.parse(
          showOTP == true ? ApiUrls.reSendOtpUrl : ApiUrls.sendOtpUrl
        ),
        body: {
          'email_id': emailId,
        }
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      if(data['status'] == 200){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("${data['success']}")
          )
        );
        setState(() {
          getOtp = data['otp'];
          getEmail = data['email_id'];
        });
        print("OTP ->$getOtp / Email -> $getEmail");
      }else if(data['status'] == 400){
        var errorMsg = data['error']['email_id'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red.withOpacity(0.8),
              content: Text("$errorMsg")
          )
        );
      }
    });
  }

  Future<String> submitOtp(var emailId,var otp) async {
    print("Email ->$emailId / Otp -> $otp");
    await http.post(
        Uri.parse(ApiUrls.verifyOtpUrl),
        body: {
          'email_id': getEmail.toString(),
          'otp': getOtp.toString(),
          'provided_email_id': emailId,
          'provided_otp': otp,
        }
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      if(data['status'] == 200){
        SnackBarMessageShow.warningMSG('message', context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            dismissDirection: DismissDirection.up,
            backgroundColor: Colors.green,
            content: Text("${data['message']}")
          )
        );
      }
      else if(data['status'] == 400){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                dismissDirection: DismissDirection.up,
                backgroundColor: Colors.red.withOpacity(0.8),
                content: Text("${data['message']}")
            )
        );
      }
      else{
        print("error");
      }
    });
  }
}
