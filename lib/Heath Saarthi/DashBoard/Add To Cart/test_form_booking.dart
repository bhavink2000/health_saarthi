// ignore_for_file: use_build_context_synchronously, void_checks

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Cart%20Future/cart_future.dart';
import '../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Backend Helper/Models/Cart Menu/mobile_number_model.dart';
import '../../App Helper/Frontend Helper/File Picker/file_image_picker.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../Bottom Menus/Test Menu/thank_you_msg.dart';

class TestBookingScreen extends StatefulWidget {
  var testDis,packageDis,profileDis,promoApply;
  var dStateId,dCityId,dAreaId,dBranchId,dStateNm,dCityNm,dAreaNm,dBranchNm;
  var locationType;
  TestBookingScreen({Key? key,this.testDis,this.packageDis,this.profileDis,this.promoApply,
  this.dStateId,this.dCityId,this.dAreaId,this.dBranchId,this.dStateNm,this.dCityNm,this.dAreaNm,this.dBranchNm,
    this.locationType
  }) : super(key: key);

  @override
  State<TestBookingScreen> createState() => _TestBookingScreenState();
}

class _TestBookingScreenState extends State<TestBookingScreen> {

  bool addVendor = false;
  File? fileManger;
  //final mobileNo = TextEditingController();
  final emailId = TextEditingController();
  final address = TextEditingController();
  final pinCode = TextEditingController();
  final collectionDate = TextEditingController();
  final collectionTime = TextEditingController();
  final remark = TextEditingController();

  String? selectedGender;
  final pAge = TextEditingController();
  final pDob = TextEditingController();
  final pName = TextEditingController();
  final pMobile = TextEditingController();

  List<File> prescriptionFiles = [];
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
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    selectedMobileNo = '';
    selectedGender = '';
    collectionDate.text = '';
    remark.text = '';
    pName.text = '';
    emailId.text = '';
    pMobile.text = '';
    pDob.text = '';
    pAge.text = '';
    pinCode.text = '';
    address.text = '';
    widget.dStateNm = '';
    widget.dCityNm = '';
    widget.dAreaNm = '';
    widget.dBranchNm = '';
    super.dispose();
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
                                  return mobileList.where((item) => item.mobileNo!.toLowerCase().contains(pattern.toLowerCase()));
                                },
                                itemBuilder: (context, MobileData suggestion) {
                                  return ListTile(
                                    title: Text(suggestion.mobileNo!),
                                  );
                                },
                                onSuggestionSelected: (MobileData suggestion) {
                                  setState(() {
                                    selectedMobileNo = suggestion.encPharmacyPatientId!;
                                    getPatient(selectedMobileNo);
                                    pMobile.text = suggestion.mobileNo!; // Assign the selected mobile number to the controller's text property
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Select a mobile number';
                                  }
                                  return null;
                                },
                                onSaved: (value) => this.selectedMobileNo = value!,
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
                       /* Padding(
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
                            // Set the validator function
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

                        locationField('${widget.dStateNm == '' ? 'N/A' : widget.dStateNm}'),
                        locationField('${widget.dCityNm == '' ? 'N/A' : widget.dCityNm}'),
                        locationField('${widget.dAreaNm == '' ? 'N/A' : widget.dAreaNm}'),
                        locationField('${widget.dBranchNm == '' ? 'N/A': widget.dBranchNm}'),

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
                              DateTime? pickedDate = await showDatePicker(
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
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Upload prescription",
                                        style: TextStyle(fontFamily: FontType.MontserratMedium),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () async {
                                          var prescriptionFileManager = await FileImagePicker().pickFileManager(context);
                                          setState(() {
                                            prescriptionFiles.add(prescriptionFileManager!);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.file_copy_rounded,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          var prescriptionCamera = await FileImagePicker().pickCamera(context);
                                          setState(() {
                                            prescriptionFiles.add(prescriptionCamera!);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt_rounded,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 20,
                                    child: prescriptionFiles.isNotEmpty ? ListView.builder(
                                      itemCount: prescriptionFiles.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index){
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                                          child: Container(
                                            // margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                            decoration: BoxDecoration(
                                                color: hsPrime,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: GestureDetector(
                                              onTap: (){
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context){
                                                      return Dialog(
                                                        child: Image.file(prescriptionFiles[index]),
                                                      );
                                                    }
                                                );
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      prescriptionFiles[index].path.split('/').last,
                                                      style: TextStyle(fontFamily: FontType.MontserratLight,color: Colors.white)
                                                  ),
                                                  SizedBox(width: 10),
                                                  IconButton(
                                                      onPressed: (){
                                                        setState(() {
                                                          prescriptionFiles.remove(prescriptionFiles[index]);
                                                        });
                                                      },
                                                      icon: const Icon(Icons.delete_rounded,color: Colors.white,)
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ) ;
                                      },
                                    ) : const Center(child: Text('No file chosen'),),
                                  ),
                                ],
                              ),
                            ),
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
  String? selectedMobileNo;
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
      setState(() {
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
      });
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> bookOrder() async {
    final pGender = selectedGender == 'Male' ? 1 : selectedGender == 'Female' ? 2 : selectedGender == 'Other' ? 3 : 0;

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
      "remark": remark.text ?? '',
      "name": pName.text ?? '',
      "email_id": emailId.text ?? '',
      "mobile_no": pMobile.text ?? '',
      "gender": '$pGender',
      "age": pAge.text ?? '',
      "state_id": widget.dStateId ?? '',
      'city_id': widget.dCityId ?? '',
      'area_id': widget.dAreaId ?? '',
      'cost_center_id': widget.dBranchId ?? '',
      'address': address.text ?? '',
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.bookOrderUrls));
      request.headers.addAll(headers);
      requestBody.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      if(prescriptionFiles.isNotEmpty){
        await Future.forEach(
          prescriptionFiles, (file) async => {
          request.files.add(http.MultipartFile(
            'prescription[]',
            (http.ByteStream(file.openRead())).cast(),
            await file.length(), filename: file.path.split('/').last,
          ),
          )
        },
        );
      }
      var response = await request.send();
      var responsData = await response.stream.bytesToString();
      var responseData = json.decode(responsData);
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
        widget.dStateNm = '';
        widget.dCityNm = '';
        widget.dAreaNm = '';
        widget.dBranchNm = '';
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ThankYouPage()));
      }
      else if (bodyStatus == 400) {
        if (responseData['error'] != null) {
          if (responseData['error']['email_id'] != null) {
            final eMsg = responseData['error']['email_id'][0];
            GetXSnackBarMsg.getWarningMsg('$eMsg');
            Navigator.pop(context);
          } else if (responseData['error']['mobile_no'] != null) {
            final mMsg = responseData['error']['mobile_no'][0];
            GetXSnackBarMsg.getWarningMsg('$mMsg');
            Navigator.pop(context);
          } else if (responseData['error']['address'] != null) {
            final aMsg = responseData['error']['address'][0];
            GetXSnackBarMsg.getWarningMsg('$aMsg');
            Navigator.pop(context);
          }
          else if(bodyStatus == 400){
            var errorMessage = responseData['data']['prescription[]'][0];
            GetXSnackBarMsg.getWarningMsg('$errorMessage');
            Navigator.pop(context);
          }
          else {
            GetXSnackBarMsg.getWarningMsg(AppTextHelper().serverError);
            Navigator.pop(context);
          }
        }
      }
      else if(response.statusCode == 500){
        GetXSnackBarMsg.getWarningMsg(AppTextHelper().internalServerError);
        Navigator.pop(context);
      }
      else {
        GetXSnackBarMsg.getWarningMsg(AppTextHelper().serverError);
        Navigator.pop(context);
      }
    } catch (error) {
      print("Error: $error");
      GetXSnackBarMsg.getWarningMsg('${AppTextHelper().serverError}');
      Navigator.pop(context);
    }
  }

  Widget showTextField(var label, TextEditingController controller, IconData iconData, String? Function(String?) validator) {
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

  Widget locationField(var lName){
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: TextField(
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
            hintText: '$lName',
            hintStyle: const TextStyle(
              color: Colors.black54,
              fontFamily: FontType.MontserratRegular,
              fontSize: 14,
            ),
            //prefixIcon: Icon(iconData, color: hsBlack, size: 20),
          ),
        )
    );
  }
}
