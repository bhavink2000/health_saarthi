//@dart=2.9
import 'dart:convert';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/hs_dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {

  final fName = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final message = TextEditingController();
  final description = TextEditingController();

  bool complain = false;
  bool help = false;
  bool rating = false;
  bool reason = false;
  String dropdownValue;
  String reasonValue;
  var ratingValue = 0.0;

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hsPrimeOne,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,color: Colors.white,size: 25,),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text("Support",style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                  //Icon(Icons.circle_notifications_rounded,color: hsColorOne,size: 25,)
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 18,
                          child: TextField(
                            controller: fName,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'First Name',
                              prefixIcon: Icon(Icons.person,color: Colors.black,size: 24)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 18,
                          child: TextField(
                            controller: mobile,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mobile Number',
                              prefixIcon: Icon(Icons.phone_android_rounded,color: Colors.black,size: 24)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 18,
                          child: TextField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email Id',
                              prefixIcon: Icon(Icons.email_rounded,color: Colors.black,size: 24)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 15,
                          child: DropdownButtonFormField<String>(
                            value: dropdownValue,
                            style: const TextStyle(fontSize: 10, color: Colors.black87),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(hsPaddingM),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              ),
                              hintText: 'Select Option',
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                                fontFamily: FontType.MontserratRegular,
                                fontSize: 12,
                              ),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                if (dropdownValue == 'Complaint') {
                                  complain = true;
                                  help = false;
                                  rating = false;
                                  reason = false;
                                } else if (dropdownValue == 'Help') {
                                  complain = false;
                                  rating = false;
                                  reason = false;
                                  help = true;
                                } else if (dropdownValue == 'Reason') {
                                  rating = false;
                                  help = false;
                                  reason = true;
                                  complain = false;
                                }
                                else {
                                  complain = false;
                                  help = false;
                                  rating = true;
                                  reason = false;
                                }
                              });
                            },
                            items: <String>['Complaint', 'Rating', 'Help','Reason']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: complain,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: Column(
                            children: [
                              TextField(
                                controller: message,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Write Message',
                                ),
                              ),
                              SizedBox(height: 15.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      fName.clear();mobile.clear();email.clear();message.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                      child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      if(fName.text.isEmpty || mobile.text.isEmpty || email.text.isEmpty || message.text.isEmpty || dropdownValue == ''){
                                        SnackBarMessageShow.warningMSG('Please Fill All Field', context);
                                      }
                                      else{
                                        sendSupport();
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                      child: const Text("Submit",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: help,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: Column(
                            children: [
                              TextField(
                                controller: message,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Write Message',
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      fName.clear();mobile.clear();email.clear();message.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                      child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      if(fName.text.isEmpty || mobile.text.isEmpty || email.text.isEmpty || message.text.isEmpty || dropdownValue == ''){
                                        SnackBarMessageShow.warningMSG('Please Fill All Field', context);
                                      }
                                      else{
                                        sendSupport();
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                      child: const Text("Submit",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: rating,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: Column(
                            children: [
                              TextField(
                                controller: message,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Write Message',
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      SmoothStarRating(
                                        rating: ratingValue,
                                        color: hsPrimeOne,
                                        borderColor: hsPrime,
                                        size: 45,
                                        starCount: 5,
                                        onRated: (value) {
                                          setState(() {
                                            ratingValue = value;
                                            print("Rating->$ratingValue");
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: (){
                                      if(fName.text.isEmpty || mobile.text.isEmpty || email.text.isEmpty || message.text.isEmpty || dropdownValue == ''){
                                        SnackBarMessageShow.warningMSG('Please Fill All Field', context);
                                      }
                                      else{
                                        sendSupport();
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                      child: const Text("Submit",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: reason,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height / 15,
                                  child: DropdownButtonFormField<String>(
                                    value: reasonValue,
                                    style: const TextStyle(fontSize: 10, color: Colors.black87),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(hsPaddingM),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                                      ),
                                      hintText: 'Select Option',
                                      hintStyle: const TextStyle(
                                        color: Colors.black54,
                                        fontFamily: FontType.MontserratRegular,
                                        fontSize: 12,
                                      ),
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        reasonValue = newValue;
                                      });
                                    },
                                    items: <String>['Payment', 'Booking']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: description,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Write Description',
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      description.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                      child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      if(description.text.isEmpty || reasonValue == ''){
                                        SnackBarMessageShow.warningMSG('Please All Field', context);
                                      }
                                      else{
                                        sendRequestManagement();
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                      child: const Text("Submit",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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

  void sendSupport() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    var type = dropdownValue == 'Complaint' ? 0 : dropdownValue == 'Help' ? 1 : 2;
    await http.post(
        Uri.parse(ApiUrls.supportUrls),
        headers: headers,
        body: {
          'name': fName?.text ?? '',
          'mobile_no': mobile?.text ?? '',
          'email_id': email?.text ?? '',
          'type': type.toString() ?? '',
          'massage': message?.text ?? '',
          'rating_count': ratingValue.toString() ?? '',
        }
    ).then((response) {
      print(response.body);
      if(response.statusCode == 200){
        var data = json.decode(response.body);
        var msg = data['message'];
        if (data['status'] == 200) {
          SnackBarMessageShow.successsMSG("$msg", context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
        }
      }
      else{
        if(response.statusCode == 400){
          var data = json.decode(response.body);
          var errorMsg = data['error']['email_id'][0];
          if (data['status'] == 400) {
            SnackBarMessageShow.errorMSG("$errorMsg", context);
          }
        }
      }
    });
  }

  void sendRequestManagement() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    var reasonType = reasonValue == 'Payment' ? 0 : 1;
    await http.post(
        Uri.parse(ApiUrls.requestManagementUrls),
        headers: headers,
        body: {
          'reason': reasonType.toString() ?? '',
          'description': description?.text ?? '',
        }
    ).then((response) {
      print(response.body);
      if(response.statusCode == 200){
        var data = json.decode(response.body);
        var msg = data['message'];
        if (data['status'] == 200) {
          SnackBarMessageShow.successsMSG("$msg", context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
        }
      }
      else{
        if(response.statusCode == 400){
          var data = json.decode(response.body);
          var errorMsg = data['error']['email_id'][0];
          if (data['status'] == 400) {
            SnackBarMessageShow.errorMSG("$errorMsg", context);
          }
        }
      }
    });
  }
}
