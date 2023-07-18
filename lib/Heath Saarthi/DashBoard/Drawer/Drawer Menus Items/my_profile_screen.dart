import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../App Helper/Backend Helper/Api Future/Profile Future/profile_future.dart';
import '../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../App Helper/Backend Helper/Device Info/device_info.dart';
import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../../Authentication Screens/Splash Screen/splash_screen.dart';
import '../../Bottom Menus/Profile Menu/change_password.dart';

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

  final bankNm = TextEditingController();
  final ifscCode = TextEditingController();
  final accountNo = TextEditingController();
  final gstNo = TextEditingController();

  final pincode = TextEditingController();
  var panCard;
  var addressProfe;
  var aadharCardF;
  var aadharCardB;
  var chequeFile;
  var panCardImg;
  var addressProfeImg;
  var aadharCardFImg;
  var aadharCardBImg;
  var chequeImg;

  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final cPassword = TextEditingController();

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState(){
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    retrieveDeviceToken();
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        getProfile();
      });
    });
  }
  String? deviceToken;
  Future<void> retrieveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      deviceToken = prefs.getString('deviceToken');
    });
    print("SharedPreferences DeviceToken->$deviceToken");
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
                  const Text("Profile",style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
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
                        showTextField('PinCode', pincode,Icons.code),
                        showTextField('Bank name', bankNm,Icons.account_balance_rounded),
                        showTextField('IFSC code', ifscCode,Icons.account_tree_rounded),
                        showTextField('Account number', accountNo,Icons.account_balance_wallet_rounded),
                        showTextField('GST no', gstNo,Icons.app_registration_rounded),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ExpansionTile(
                                tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                title: const Text("Pancard",style: TextStyle(fontFamily: FontType.MontserratMedium)),
                                subtitle: Text("${panCard ?? 'Pancard'}",
                                  style: const TextStyle(
                                      fontFamily: FontType.MontserratRegular,
                                      color: Colors.black87,
                                      fontSize: 12),
                                ),
                                trailing: const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                children: [
                                  panCardImg == null ? Text("Image not found") :Image(
                                    image: NetworkImage("$panCardImg"),
                                  ),
                                ],
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ExpansionTile(
                                tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                title: const Text("Aadhaar card front",style: TextStyle(fontFamily: FontType.MontserratMedium)),
                                subtitle: Text("${aadharCardF ?? 'Aadhaar card front'}",
                                  style: const TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,
                                      fontSize: 12),
                                ),
                                trailing: const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                children: [
                                  aadharCardFImg == null ? const Text("Image not found") :Image(
                                    image: NetworkImage("$aadharCardFImg"),
                                  ),
                                ],
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ExpansionTile(
                                tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                title: const Text("Aadhaar card back",style: TextStyle(fontFamily: FontType.MontserratMedium)),
                                subtitle: Text("${aadharCardB ?? 'Aadhaar card back'}",
                                  style: const TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,
                                      fontSize: 12),
                                ),
                                trailing: const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                children: [
                                  aadharCardBImg == null ? const Text("Image not found") : Image(
                                    image: NetworkImage("$aadharCardBImg"),
                                  ),
                                ],
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ExpansionTile(
                                tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                title: const Text("Address proof",style: TextStyle(fontFamily: FontType.MontserratMedium)),
                                subtitle: Text("${addressProfe ?? 'Address proof'}",
                                  style: const TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,
                                      fontSize: 12),
                                ),
                                trailing: const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                children: [
                                  addressProfeImg == null ? const Text("Image not found") : Image(
                                    image: NetworkImage("$addressProfeImg"),
                                  ),
                                ],
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ExpansionTile(
                                tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                title: const Text("Cheque image",style: TextStyle(fontFamily: FontType.MontserratMedium)),
                                subtitle: Text("${chequeFile ?? 'Cheque'}",
                                  style: const TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,
                                      fontSize: 12),
                                ),
                                trailing: const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                children: [
                                  chequeImg == null ? const Text("Image not found") :Image(
                                    image: NetworkImage("$chequeImg"),
                                  ),
                                ],
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen(accessToken: getAccessToken.access_token)));
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: const ListTile(
                                title: Text("Change password",style: TextStyle(fontFamily: FontType.MontserratMedium)),
                                trailing: Icon(Icons.keyboard_arrow_right_rounded),
                              ),
                            ),
                          ),
                        ),
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
            SnackBarMessageShow.warningMSG("$errorMsg", context);
          }
        }
      }
    });
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
  void getProfile() async {
    final userDataSession = Provider.of<UserDataSession>(context, listen: false);
    try {
      _showLoadingDialog(context);
      var pModel;
      pModel = await ProfileFuture().fetchProfile(getAccessToken.access_token);
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
          bankNm.text = pModel.data!.bankName.toString();
          ifscCode.text = pModel.data!.ifsc.toString();
          accountNo.text = pModel.data!.accountNumber.toString();
          gstNo.text = pModel.data!.gstNumber.toString();
          panCard = pModel.data!.pancard.toString();
          addressProfe = pModel.data!.addressProof.toString();
          aadharCardF = pModel.data!.aadharFront.toString();
          aadharCardB = pModel.data!.aadharBack.toString();
          chequeFile = pModel.data!.chequeImage.toString();
          panCardImg = pModel.data!.pancardImg.toString();
          addressProfeImg = pModel.data!.addressProofImg.toString();
          aadharCardFImg = pModel.data!.aadharFrontImg.toString();
          aadharCardBImg = pModel.data!.aadharBackImg.toString();
          chequeImg = pModel.data!.chequeImg.toString();
        });
      }
      Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).pop(); // Dismiss the loading dialog
    } catch (e) {
      print('Error: $e');
      if (e.toString().contains('Token is Expired')) {
        logoutUser().then((value) {
          userDataSession.removeUserData().then((value) {
            DeviceInfo().deleteDeviceToken(context, deviceToken, getAccessToken.access_token).then((value) {
              if (value == 'success') {
                print("token is deleted $value");
              } else {
                print("Token is not deleted");
              }
            });
          });
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SplashScreen()),
                (Route<dynamic> route) => false,
          );
        });
      } else {
        print('Error: $e');
      }
      Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).pop();
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
