import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../App Helper/Backend Helper/Api Future/Profile Future/profile_future.dart';
import '../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  final firstNm = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final area = TextEditingController();
  final branch = TextEditingController();

  final pincode = TextEditingController();
  final panCard = TextEditingController();
  final aadharcard = TextEditingController();

  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final cPassword = TextEditingController();

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState(){
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        getProfile();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hsPrimeOne,
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
                  const Text("Profile",style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                  //Icon(Icons.circle_notifications_rounded,color: hsColorOne,size: 25,)
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        showTextField('First Name', firstNm,Icons.person),
                        showTextField('Mobile', mobile,Icons.mobile_friendly),
                        showTextField('Email', email,Icons.email),
                        showTextField('Address', address,Icons.location_city),
                        showTextField('State', state,Icons.query_stats),
                        showTextField('City', city,Icons.reduce_capacity),
                        showTextField('Area', area,Icons.area_chart),
                        showTextField('Branch', branch,CupertinoIcons.arrow_branch),
                        showTextField('PinCode', pincode,Icons.code),
                        showTextField('PanCard', panCard,Icons.confirmation_number_outlined),
                        showTextField('Aadhaar Card', aadharcard,CupertinoIcons.creditcard_fill),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            color: hsPrimeOne,
                            child: InkWell(
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (context, setState){
                                          return BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                            child: AlertDialog(
                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                              contentPadding: const EdgeInsets.only(top: 10.0),
                                              content: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    const Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: Text("Health Saarthi", style: TextStyle(fontFamily: FontType.MontserratMedium,fontWeight: FontWeight.bold,letterSpacing: 3,fontSize: 18),),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                                      child: TextField(
                                                        controller: currentPassword,
                                                        style: TextStyle(color: hsOne),
                                                        decoration: InputDecoration(
                                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne.withOpacity(0.5))),
                                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne)),
                                                          fillColor: Colors.lightBlueAccent,
                                                          labelText: 'Current Password',
                                                          labelStyle: TextStyle(color: hsPrimeOne.withOpacity(0.5),),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                                      child: TextField(
                                                        controller: newPassword,
                                                        style: TextStyle(color: hsOne),
                                                        decoration: InputDecoration(
                                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne.withOpacity(0.5))),
                                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne)),
                                                          fillColor: Colors.lightBlueAccent,
                                                          labelText: 'New Password',
                                                          labelStyle: TextStyle(color: hsPrimeOne.withOpacity(0.5),),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                                      child: TextField(
                                                        controller: cPassword,
                                                        style: TextStyle(color: hsOne),
                                                        decoration: InputDecoration(
                                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne.withOpacity(0.5))),
                                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: hsPrimeOne)),
                                                          fillColor: Colors.lightBlueAccent,
                                                          labelText: 'Confirm Password',
                                                          labelStyle: TextStyle(color: hsPrimeOne.withOpacity(0.5),),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: <Widget>[
                                                        Container(
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsOne),
                                                          child: TextButton(
                                                            child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 1,color: Colors.white),),
                                                            onPressed: (){
                                                              currentPassword.text = "";
                                                              newPassword.text = "";
                                                              cPassword.text = "";
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsOne),
                                                          child: TextButton(
                                                            child: const Text("Send",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 1,color: Colors.white),),
                                                            onPressed: (){
                                                              if(currentPassword.text.isEmpty || newPassword.text.isEmpty || cPassword.text.isEmpty){
                                                                SnackBarMessageShow.warningMSG('Please Fill All Fields', context);
                                                              }
                                                              else{
                                                                getChangePass(currentPassword.text,newPassword.text,cPassword.text);
                                                                Navigator.pop(context);
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10,)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                );
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: const Text(
                                    "Change Passowrd",
                                    style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white,letterSpacing: 1,fontSize: 16),
                                    textAlign: TextAlign.center,
                                  )
                              ),
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

  void getChangePass(var pass,var nPass, var cPass) async {
    await http.post(
        Uri.parse(ApiUrls.changePasswordUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${getAccessToken.access_token}',
        },
        body: {
          'current_password': pass,
          'password': nPass,
          'confirm_password': cPass,
        }
    ).then((response) {
      print(response.body);
      if(response.statusCode == 200){
        var data = json.decode(response.body);
        var msg = data['message'];
        if (data['status'] == 200) {
          SnackBarMessageShow.successsMSG("$msg", context);
        }
      }
      else{
        if(response.statusCode == 400){
          var data = json.decode(response.body);
          var errorMsg = data['message'];
          if (data['status'] == 400) {
            SnackBarMessageShow.errorMSG("$errorMsg", context);
          }
        }
      }
    });
  }

  void getProfile() async {
    try {
      var pModel = await ProfileFuture().fetchProfile(getAccessToken.access_token);
      mobile.text = pModel.data!.mobile.toString();
      email.text = pModel.data!.emailId.toString();
      address.text = pModel.data!.address.toString();
      state.text = pModel.data!.state!.stateName.toString();
      city.text = pModel.data!.city!.cityName.toString();
      area.text = pModel.data!.area!.areaName.toString();
    } catch (e) {
      print('Error: $e');
    }
  }
}
