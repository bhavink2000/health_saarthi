import 'dart:convert';
import 'dart:ui';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Profile%20Future/profile_future.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../App Helper/Backend Helper/Device Info/device_info.dart';
import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../../../App Helper/Frontend Helper/Error Helper/token_expired_helper.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../../Authentication Screens/Splash Screen/splash_screen.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {

  final firstNm = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final area = TextEditingController();
  final branch = TextEditingController();

  final pincode = TextEditingController();
  var panCard;
  var addressProfe;
  var aadharCardF;
  var aadharCardB;

  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final cPassword = TextEditingController();

  GetAccessToken getAccessToken = GetAccessToken();
  String? deviceToken;
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
  Future<void> retrieveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      deviceToken = prefs.getString('deviceToken');
    });
    print("SharedPreferences DeviceToken->$deviceToken");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.28,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
            showTextField('PinCode', pincode,Icons.code),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  shadowColor: hsPrime.withOpacity(0.5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.upload_file_rounded,color: Colors.black,size: 30),
                        const SizedBox(height: 5,),
                        Text("${panCard ?? 'PanCard'}",
                          style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  shadowColor: hsPrime.withOpacity(0.5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.upload_file_rounded,color: Colors.black,size: 30),
                        const SizedBox(height: 5,),
                        Text(
                          "${addressProfe ?? 'Address Proof'}",
                          style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,
                              fontSize: 12),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  shadowColor: hsPrime.withOpacity(0.5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.upload_file_rounded,color: Colors.black,size: 30),
                        const SizedBox(height: 5,),
                        Text(
                          "${aadharCardF ?? 'Aadhaar Card Front'}",
                          style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,
                              fontSize: 10),)
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  shadowColor: hsPrime.withOpacity(0.5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.upload_file_rounded,color: Colors.black,size: 30),
                        const SizedBox(height: 5,),
                        Text(
                          "${aadharCardB ??'Aadhaar Card Back'}",
                          style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,
                              fontSize:  10),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                      padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
                      child: const Text(
                        "Change Password",
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
    final userDataSession = Provider.of<UserDataSession>(context, listen: false);
    try {
      var pModel;
      try {
        pModel = await ProfileFuture().fetchProfile(getAccessToken.access_token);
        print("Value -> $pModel");
      } catch (e) {
        if (e.toString().contains('Token is Expired')) {
          logoutUser().then((value){
            userDataSession.removeUserData().then((value){
              DeviceInfo().deleteDeviceToken(context, deviceToken,getAccessToken.access_token).then((value){
                if(value == 'success'){
                  print("token is deleted $value");
                }
                else{
                  print("Token is not deleted");
                }
              });
            });
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SplashScreen()), (Route<dynamic> route) => false);
          });
          //SnackBarMessageShow.warningMSG('Token is expired\nPlease logout', context);
        } else {
          print('Error: $e');
        }
      }
      if (pModel != null) {
        setState(() {
          firstNm.text = pModel.data!.name.toString();
          mobile.text = pModel.data!.mobile.toString();
          email.text = pModel.data!.emailId.toString();
          address.text = pModel.data!.address.toString();
          state.text = pModel.data!.state!.stateName.toString();
          city.text = pModel.data!.city!.cityName.toString();
          area.text = pModel.data!.area!.areaName.toString();
          pincode.text = pModel.data!.pincode.toString();
          panCard = pModel.data!.pancard.toString();
          addressProfe = pModel.data!.addressProof.toString();
          aadharCardF = pModel.data!.aadharFront.toString();
          aadharCardB = pModel.data!.aadharBack.toString();

        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  var bodyMsg;
  Future<void> logoutUser() async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.logoutUrl),
        headers: headers,
      );
      final responseData = json.decode(response.body);
      var bodyStatus = responseData['status'];
      bodyMsg = responseData['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMsg', context);
      } else {
        //SnackBarMessageShow.warningMSG('$bodyMsg', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }
}
