//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
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
import '../../../App Helper/Frontend Helper/File Picker/file_image_picker.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../../Authentication Screens/Splash Screen/splash_screen.dart';
import '../../Bottom Menus/Profile Menu/change_password.dart';
import '../../hs_dashboard.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key key}) : super(key: key);

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
  var gstFile;
  var panCardImg;
  var addressProfeImg;
  var aadharCardFImg;
  var aadharCardBImg;
  var chequeImg;
  var gstImg;

  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final cPassword = TextEditingController();

  GetAccessToken getAccessToken = GetAccessToken();
  String deviceToken;

  File panCardChange;
  File aadhaarCardFChange;
  File aadhaarCardBChange;
  File addressChange;
  File chequeChange;
  @override
  void initState(){
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    retrieveDeviceToken();
    Future.delayed(const Duration(seconds: 1),(){
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: TextField(
                            controller: firstNm,
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(hsPaddingM),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              ),
                              hintText: 'First name',
                              hintStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontFamily: FontType.MontserratRegular,
                                  fontSize: 14
                              ),
                              prefixIcon: Icon(Icons.person, color: hsBlack,size: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: TextField(
                            controller: mobile,
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(hsPaddingM),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              ),
                              hintText: 'Mobile no',
                              hintStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontFamily: FontType.MontserratRegular,
                                  fontSize: 14
                              ),
                              prefixIcon: Icon(Icons.mobile_friendly, color: hsBlack,size: 20),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: TextField(
                            controller: email,
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(hsPaddingM),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                              ),
                              hintText: 'Email id',
                              hintStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontFamily: FontType.MontserratRegular,
                                  fontSize: 14
                              ),
                              prefixIcon: Icon(Icons.email, color: hsBlack,size: 20),
                            ),
                          ),
                        ),

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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ExpansionTile(
                                tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                title: const Text("Pancard",style: TextStyle(fontFamily: FontType.MontserratMedium)),
                                subtitle: Text(panCardChange == null ? '$panCard' : 'Pancard is picked',
                                  style: TextStyle(
                                      fontFamily: FontType.MontserratRegular,
                                      color: panCardChange == null ? Colors.black87 : Colors.green,
                                      fontSize: 12),
                                ),
                                trailing: Container(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                      TextButton(
                                          onPressed: ()async{
                                            var panCardCamera = await FileImagePicker().pickCamera(context);
                                            setState(() {
                                              panCardChange = panCardCamera;
                                            });
                                          },
                                          child: Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                                      )
                                    ],
                                  ),
                                ),
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
                                subtitle: Text(aadhaarCardFChange == null
                                    ? '$aadharCardF' : 'Aadhaar card front is picked',
                                  style: TextStyle(
                                      fontFamily: FontType.MontserratRegular,
                                      color: aadhaarCardFChange == null  ? Colors.black87 : Colors.green,
                                      fontSize: 12),
                                ),
                                trailing: Container(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                      TextButton(
                                          onPressed: ()async{
                                            var aadhaarCardFrontCamera = await FileImagePicker().pickCamera(context);
                                            setState(() {
                                              aadhaarCardFChange = aadhaarCardFrontCamera;
                                            });
                                          },
                                          child: Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                                      )
                                    ],
                                  ),
                                ),
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
                                subtitle: Text(aadhaarCardBChange == null
                                    ? '$aadharCardB' : 'Aadhaar card back is picked',
                                  style: TextStyle(
                                      fontFamily: FontType.MontserratRegular,
                                      color: aadhaarCardBChange == null ? Colors.black87 : Colors.green,
                                      fontSize: 12),
                                ),
                                trailing: Container(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                      TextButton(
                                          onPressed: ()async {
                                            var aadhaarCardBack = await FileImagePicker().pickFileManger(context);
                                            setState(() {
                                              aadhaarCardBChange = aadhaarCardBack;
                                            });
                                          },
                                          child: Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                                      )
                                    ],
                                  ),
                                ),
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
                                subtitle: Text(addressChange == null
                                    ? '$addressProfe' : 'Address proof is picked',
                                  style: TextStyle(
                                      fontFamily: FontType.MontserratRegular,
                                      color: addressChange == null ? Colors.black87 : Colors.green,
                                      fontSize: 12),
                                ),
                                trailing: Container(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                      TextButton(
                                          onPressed: ()async{
                                            var addressProofCamera = await FileImagePicker().pickCamera(context);
                                            setState(() {
                                              addressChange = addressProofCamera;
                                            });
                                          },
                                          child: Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                                      )
                                    ],
                                  ),
                                ),
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
                                subtitle: Text(chequeChange == null
                                    ? '$chequeFile' : 'Cheque img is picked',
                                  style: TextStyle(
                                      fontFamily: FontType.MontserratRegular,
                                      color: chequeChange == null ? Colors.black87 : Colors.green,
                                      fontSize: 12),
                                ),
                                trailing: Container(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                      TextButton(
                                          onPressed: ()async{
                                            var chequeFileCamera = await FileImagePicker().pickCamera(context);
                                            setState(() {
                                              chequeChange = chequeFileCamera;
                                            });
                                          },
                                          child: Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                                      )
                                    ],
                                  ),
                                ),
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
                          child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ExpansionTile(
                                tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                title: const Text("GST file image",style: TextStyle(fontFamily: FontType.MontserratMedium)),
                                subtitle: Text("${gstFile == null ? 'No gst file' : 'GST file'}",
                                  style: const TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black87,
                                      fontSize: 12),
                                ),
                                trailing: const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                                children: [
                                  gstImg == null ? const Text("Image not found") :Image(
                                    image: NetworkImage("$gstImg"),
                                  ),
                                ],
                              )
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: hsPrime
                            ),
                            onPressed: (){
                              if(userStatus == '0'){
                                updateProfileData(context);
                              }
                              else if(userStatus == '1'){
                                SnackBarMessageShow.warningMSG('Not updatable for this user', context);
                              }
                              else{
                                SnackBarMessageShow.warningMSG('User not found', context);
                              }
                            },
                            child: Text("Update profile",style: TextStyle(fontFamily: FontType.MontserratMedium))
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
        readOnly: true,
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

  void updateProfileData(BuildContext context) async {
    Dio dio = Dio();
    String apiUrl = ApiUrls.updateProfileUrls;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text('Loading...'),
              ],
            ),
          ),
        ); // Show the loading dialog while waiting for the response.
      },
    );
    try {
      FormData formData = FormData();
      if (panCardChange != null) {
        formData.files.add(MapEntry(
            'pancard', await MultipartFile.fromFile(panCardChange.path)));
      }
      if (addressChange != null) {
        formData.files.add(MapEntry(
            'address_proof', await MultipartFile.fromFile(addressChange.path)));
      }
      if (aadhaarCardFChange != null) {
        formData.files.add(MapEntry(
            'aadhar_front',
            await MultipartFile.fromFile(aadhaarCardFChange.path)));
      }
      if (aadhaarCardBChange != null) {
        formData.files.add(MapEntry(
            'aadhar_back', await MultipartFile.fromFile(aadhaarCardBChange.path)));
      }
      if (chequeChange != null) {
        formData.files.add(MapEntry(
            'cheque_image', await MultipartFile.fromFile(chequeChange.path)));
      }
      Response response = await dio.post(
        apiUrl,
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${getAccessToken.access_token}',
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        var data = response.data;
        var msg = data['message'];
        if (data['status'] == 200) {
          SnackBarMessageShow.successsMSG("$msg", context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
        }
      } else if (response.statusCode == 400) {
        var data = response.data;
        var errorMsg = data['message'];
        if (data['status'] == 400) {
          SnackBarMessageShow.errorMSG("$errorMsg", context);
          Navigator.pop(context);
        }
      }
    } catch (e) {
      print("Error uploading documents: ${e}");
      SnackBarMessageShow.successsMSG("Select at least one document update.", context);
      Navigator.pop(context);
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
  var userStatus;
  void getProfile() async {
    final userDataSession = Provider.of<UserDataSession>(context, listen: false);
    try {
      _showLoadingDialog(context);
      var pModel;
      pModel = await ProfileFuture().fetchProfile(getAccessToken.access_token);
      if (pModel != null) {
        setState(() {
          userStatus = pModel.data.status.toString();
          firstNm.text = pModel.data.name.toString();
          mobile.text = pModel.data.mobile.toString();
          email.text = pModel.data.emailId.toString();
          address.text = pModel.data.address.toString();
          state.text = pModel.data.state.stateName.toString();
          city.text = pModel.data.city.cityName.toString();
          area.text = pModel.data.area.areaName.toString();
          pincode.text = pModel.data.pincode.toString();

          bankNm.text = pModel.data.bankName.toString();
          ifscCode.text = pModel.data.ifsc.toString();
          accountNo.text = pModel.data.accountNumber.toString();
          gstNo.text = pModel.data.gstNumber.toString();
          panCard = pModel.data.pancard.toString();
          addressProfe = pModel.data.addressProof.toString();
          aadharCardF = pModel.data.aadharFront.toString();
          aadharCardB = pModel.data.aadharBack.toString();
          chequeFile = pModel.data.chequeImage.toString();
          //gstFile = pModel.data!.chequeImage.toString();

          panCardImg = pModel.data.pancardImg.toString();
          addressProfeImg = pModel.data.addressProofImg.toString();
          aadharCardFImg = pModel.data.aadharFrontImg.toString();
          aadharCardBImg = pModel.data.aadharBackImg.toString();
          chequeImg = pModel.data.chequeImg.toString();
          gstImg = pModel.data.gstImg.toString();
        });
      }
      Navigator.of(_loadingDialogKey.currentContext, rootNavigator: true).pop(); // Dismiss the loading dialog
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
      Navigator.of(_loadingDialogKey.currentContext, rootNavigator: true).pop();
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
