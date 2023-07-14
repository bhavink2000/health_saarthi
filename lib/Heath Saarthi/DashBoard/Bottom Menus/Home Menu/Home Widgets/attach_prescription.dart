//@dart=2.9
// ignore_for_file: use_build_context_synchronously, missing_return

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../../App Helper/Backend Helper/Api Future/Location Future/location_future.dart';
import '../../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Backend Helper/Models/Cart Menu/mobile_number_model.dart';
import '../../../../App Helper/Backend Helper/Models/Location Model/area_model.dart';
import '../../../../App Helper/Backend Helper/Models/Location Model/city_model.dart';
import '../../../../App Helper/Backend Helper/Models/Location Model/state_model.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../../Add To Cart/test_cart.dart';
import '../../../Notification Menu/notification_menu.dart';
import '../../Test Menu/thank_you_msg.dart';

class AttachPrescription extends StatefulWidget {
  const AttachPrescription({Key key}) : super(key: key);

  @override
  State<AttachPrescription> createState() => _AttachPrescriptionState();
}

class _AttachPrescriptionState extends State<AttachPrescription> {

  File fileManger;
  var focusNode = FocusNode();
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
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Row(
                        children: [
                          IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back,color: Colors.black,size: 24)),
                          SizedBox(width: 10.w),
                          Text("Attach Prescription",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.bold),)
                        ],
                      )
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                      }, icon: Icon(Icons.shopping_cart_outlined,color: hsPrescriptionColor,size: 24)),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationMenu()));
                      }, icon: Icon(Icons.circle_notifications_rounded,color: hsPrescriptionColor,size: 24)),
                    ],
                  )
                ],
              ),
            ),
            Divider(color: Colors.grey.withOpacity(0.5),thickness: 1),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  _showFilePick(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2.w,
                                  height: MediaQuery.of(context).size.height / 14.h,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrimeOne),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Upload \nPresciption",
                                          style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),
                                        ),
                                        const Icon(Icons.upload_file_rounded,color: Colors.white,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Text(
                                    fileManger == null ? "No Prescription Select" : 'Prescription Selected',
                                    style: const TextStyle(fontFamily: FontType.MontserratRegular),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
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
                          'Patient name', pName,Icons.person,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter age';
                            }
                            return null;
                          }, // Set the validator function
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter DOB';
                            }
                            return null;
                          },
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
                      showTextField(
                          'Email id', emailId,Icons.email,
                              (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter email id';
                            }
                            return null;
                          }
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
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2.2.w,
                              //height: MediaQuery.of(context).size.height / 14.h,
                              child: DropdownButtonFormField<String>(
                                value: selectedState,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 10, color: Colors.black87),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  border: OutlineInputBorder(),
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
                                onTap: selectedCity == null ? fetchStateList : resetCityAndAreaSelection,
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
                              )
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2.w,
                            //height: MediaQuery.of(context).size.height / 14.h,
                            child: DropdownButtonFormField<String>(
                              value: selectedCity,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              style: const TextStyle(fontSize: 10, color: Colors.black87),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12))),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12))),
                                hintText: 'City',
                                hintStyle: const TextStyle(color: Colors.black54, fontFamily: FontType.MontserratRegular, fontSize: 12),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select a city';
                                }
                                return null;
                              },
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCity = newValue;
                                  selectedArea = null;
                                  fetchAreaList(selectedState, selectedCity); // Replace with your fetchAreaList logic
                                });
                              },
                              onTap: () {
                                if (selectedArea == null) {
                                  fetchCityList(selectedState);
                                } else {
                                  setState(() {
                                    selectedArea = null;
                                  });
                                  fetchAreaList(selectedState, selectedCity);
                                }
                              },
                              items: [
                                DropdownMenuItem(
                                  value: '',
                                  child: Text('Select city'),
                                ),
                                ...cityList?.map((city) {
                                  return DropdownMenuItem<String>(
                                    value: city.id.toString(),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 4,
                                      child: Text(city.cityName),
                                    ),
                                  );
                                })?.toList() ?? []
                              ],
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
                            //height: MediaQuery.of(context).size.height / 14.h,
                            child: DropdownButtonFormField<String>(
                              value: selectedArea,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              style: const TextStyle(fontSize: 10, color: Colors.black87),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12))),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12))),
                                hintText: 'Area',
                                hintStyle: const TextStyle(color: Colors.black54, fontFamily: FontType.MontserratRegular, fontSize: 12),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select an area';
                                }
                                return null;
                              },
                              onChanged: (newValue) {
                                setState(() {
                                  selectedArea = newValue;
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                  value: '',
                                  child: Text('Select area'),
                                ),
                                ... areaList != null
                                    ? areaList.map((area) {
                                  return DropdownMenuItem<String>(
                                    value: area.id.toString(),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 3.5,
                                      child: Text(area.areaName),
                                    ),
                                  );
                                }).toList() : []
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.15.w,
                            //height: MediaQuery.of(context).size.height / 13.h,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  hintText: 'Pin code',
                                  hintStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: FontType.MontserratRegular,
                                      fontSize: 14
                                  ),
                                  prefixIcon: const Icon(Icons.pin, color: hsBlack,size: 20),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Pin code';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: TextFormField(
                          controller: colletionDate,
                          readOnly: true,
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
                            hintText: 'Collection date',
                            hintStyle: const TextStyle(
                                color: Colors.black54,
                                fontFamily: FontType.MontserratRegular,
                                fontSize: 14
                            ),
                            prefixIcon: const Icon(Icons.date_range_rounded, color: hsBlack,size: 20),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter collection date';
                            }
                            return null;
                          },
                          onTap: () async {
                            DateTime pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101)
                            );
                            if(pickedDate != null ){
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                colletionDate.text = formattedDate;
                              });
                            }else{}
                          },
                        ),
                      ),
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

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter remark';
                            }
                            return null;
                          }, // Set the validator function
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: InkWell(
                          onTap: ()async{
                            if (_formKey.currentState.validate()) {
                              FocusScope.of(context).unfocus();
                              if(selectedState == null || selectedCity == null || selectedArea == null){
                                SnackBarMessageShow.warningMSG("Please Select Location Fields", context);
                              }
                              else if(fileManger == null){
                                SnackBarMessageShow.warningMSG('Please Select Prescription', context);
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
                                await attachPrescription();
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsPrescriptionColor),
                            child: Text("Confirm Booking",style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white,fontSize: 18.sp,letterSpacing: 1)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  _showFilePick(BuildContext context){
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
                                      fileManger = file;
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
                                      fileManger = file;
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
  List<MobileData> mobileList = [];
  String selectedMobileNo;
  Future<void> fetchMobileList() async {
    print("fetchMobileCall");
    try {
      CartFuture cartFuture = CartFuture();
      List<MobileData> list = await cartFuture.getMobileNumber(getAccessToken.access_token, selectedMobileNo);
      setState(() {
        mobileList = list;
      });
      print("mobileList->${mobileList} / length${mobileList.length}");
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
      selectedState = pModel.patientData.state.id.toString();
      selectedCity = pModel.patientData.city.id.toString();
      selectedArea = pModel.patientData.area.id.toString();
      pinCode.text = pModel.patientData.pincode.toString();
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

  Widget showTextField(var label, TextEditingController controller, IconData iconData, String Function(String) validator) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(hsPaddingM),
          border: const OutlineInputBorder(),
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

  Future<void> attachPrescription() async {
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
      var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.attachPrescriptionUrls));
      request.headers.addAll(headers);

      requestBody.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      if (fileManger != null) {
        var file = http.MultipartFile.fromBytes(
          'prescription', await fileManger.readAsBytes(),
          filename: fileManger.path.split('/').last,
        );
        request.files.add(file);
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      var parsedResponse = json.decode(responseData);
      print("response -> $parsedResponse");

      var bodyStatus = parsedResponse['status'];
      var bodyMsg = parsedResponse['message'];
      print("bS->$bodyStatus");
      print("bM->$bodyMsg");
      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMsg', context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ThankYouPage()));
      } else if (bodyStatus == 400) {
        var remarkMsg = parsedResponse['data']['remark'];
        SnackBarMessageShow.warningMSG('$remarkMsg', context);
      } else if (bodyStatus == 400) {
        var errorMessage = parsedResponse['error']['mobile_no'];
        SnackBarMessageShow.warningMSG('$errorMessage', context);
      }
      else {
        SnackBarMessageShow.errorMSG('Something went wrong', context);
      }
    } catch (error) {
      print("Error: $error");
      SnackBarMessageShow.errorMSG('Something wrong', context);
    }
  }
}

class MobileItem {
  final int encPharmacyPatientId;
  final String mobileNo;

  MobileItem({this.encPharmacyPatientId, this.mobileNo});
}

class StateGetModel {
  final int id;
  final String stateName;

  StateGetModel(this.id, this.stateName);
}