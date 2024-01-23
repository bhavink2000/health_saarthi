
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
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
import '../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../../App Helper/Frontend Helper/Text Helper/test_helper.dart';
import '../../../Authentication Screens/Splash Screen/splash_screen.dart';
import '../../hs_dashboard.dart';
import 'change_password.dart';

class ProfileWidgets extends StatefulWidget {
  const ProfileWidgets({super.key});

  @override
  State<ProfileWidgets> createState() => _ProfileWidgetsState();
}

class _ProfileWidgetsState extends State<ProfileWidgets> {

  final firstNm = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final area = TextEditingController();
  final branch = TextEditingController();

  final bankNm = TextEditingController();
  final ifscCode = TextEditingController();
  final accountNo = TextEditingController();
  var gstNo;

  var pincode;
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

  GetAccessToken getAccessToken = GetAccessToken();
  String? deviceToken;

  File? panCardChange;
  File? aadhaarCardFChange;
  File? aadhaarCardBChange;
  File? addressChange;
  File? chequeChange;
  File? gstFileChange;
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
    log("SharedPreferences DeviceToken->$deviceToken");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              prefixIcon: const Icon(Icons.person, color: hsBlack,size: 20),
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
              prefixIcon: const Icon(Icons.mobile_friendly, color: hsBlack,size: 20),
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
              prefixIcon: const Icon(Icons.email, color: hsBlack,size: 20),
            ),
          ),
        ),

        showTextField('Address', address,Icons.location_city),
        showTextField('State', state,Icons.query_stats),
        showTextField('City', city,Icons.reduce_capacity),
        showTextField('Area', area,Icons.area_chart),
        showTextField('Branch', branch,Icons.location_city),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(hsPaddingM),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
              ),
              hintText: '${(pincode == null || pincode == '') ? 'N/A' : '$pincode'}',
              hintStyle: const TextStyle(
                  color: Colors.black,
                  fontFamily: FontType.MontserratRegular,
                  fontSize: 14
              ),
              prefixIcon: const Icon(Icons.code_rounded, color: hsBlack,size: 20),
            ),
          ),
        ),
        //showTextField('PinCode', pincode,Icons.code),
        showTextField('Bank name', bankNm,Icons.account_balance_rounded),
        showTextField('IFSC code', ifscCode,Icons.account_tree_rounded),
        showTextField('Account number', accountNo,Icons.account_balance_wallet_rounded),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(hsPaddingM),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
              ),
              hintText: '${(gstNo == 'null' || gstNo == '') ? 'N/A' : '$gstNo'}',
              hintStyle: const TextStyle(
                  color: Colors.black,
                  fontFamily: FontType.MontserratRegular,
                  fontSize: 14
              ),
              prefixIcon: const Icon(Icons.app_registration_rounded, color: hsBlack,size: 20),
            ),
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
                title: Text("Change password",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
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
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  title: const Text("Pan Card",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                  subtitle: Text(panCardChange == null ? '$panCard' : 'Pan Card is picked',
                    style: TextStyle(
                        fontFamily: FontType.MontserratRegular,
                        color: panCardChange == null ? Colors.black87 : hsPrime,
                        fontSize: 10),
                  ),
                  trailing: Container(
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                        userStatus == '0' ? TextButton(
                            onPressed: ()async{
                              var panCardCamera = await FileImagePicker().pickCamera();
                              setState(() {
                                panCardChange = panCardCamera;
                              });
                            },
                            child: const Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                        ) : Container()
                      ],
                    ),
                  ),
                  children: [
                    panCardImg == 'null' ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Image not found"),
                    ) : Image.network(
                      '$panCardImg',
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child!;
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  title: const Text("Aadhaar card front",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                  subtitle: Text(aadhaarCardFChange == null
                      ? '$aadharCardF' : 'Aadhaar card front is picked',
                    style: TextStyle(
                        fontFamily: FontType.MontserratRegular,
                        color: aadhaarCardFChange == null  ? Colors.black87 : hsPrime,
                        fontSize: 10),
                  ),
                  trailing: Container(
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                        userStatus == '0' ? TextButton(
                            onPressed: ()async{
                              var aadhaarCardFrontCamera = await FileImagePicker().pickCamera();
                              setState(() {
                                aadhaarCardFChange = aadhaarCardFrontCamera;
                              });
                            },
                            child: const Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                        ) : Container()
                      ],
                    ),
                  ),
                  children: [
                    aadharCardFImg == 'null' ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Image not found"),
                    ) :Image.network(
                      '$aadharCardFImg',
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child!;
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  title: const Text("Aadhaar card back",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                  subtitle: Text(aadhaarCardBChange == null
                      ? '$aadharCardB' : 'Aadhaar card back is picked',
                    style: TextStyle(
                        fontFamily: FontType.MontserratRegular,
                        color: aadhaarCardBChange == null ? Colors.black87 : hsPrime,
                        fontSize: 10),
                  ),
                  trailing: Container(
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                        userStatus == '0' ? TextButton(
                            onPressed: ()async {
                              var aadhaarCardBack = await FileImagePicker().pickCamera();
                              setState(() {
                                aadhaarCardBChange = aadhaarCardBack;
                              });
                            },
                            child: const Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                        ) : Container()
                      ],
                    ),
                  ),
                  children: [
                    aadharCardBImg == 'null' ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Image not found"),
                    ) : Image.network(
                      '$aadharCardBImg',
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child!;
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  title: const Text("Address proof",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                  subtitle: Text(addressChange == null
                      ? '$addressProfe' : 'Address proof is picked',
                    style: TextStyle(
                        fontFamily: FontType.MontserratRegular,
                        color: addressChange == null ? Colors.black87 : hsPrime,
                        fontSize: 10),
                  ),
                  trailing: Container(
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                        userStatus == '0' ? TextButton(
                            onPressed: ()async{
                              var addressProofCamera = await FileImagePicker().pickCamera();
                              setState(() {
                                addressChange = addressProofCamera;
                              });
                            },
                            child: const Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                        ) : Container()
                      ],
                    ),
                  ),
                  children: [
                    addressProfeImg == 'null' ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Image not found"),
                    ) : Image.network(
                      '$addressProfeImg',
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child!;
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  title: const Text("Cheque image",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                  subtitle: Text(chequeChange == null
                      ? '$chequeFile' : 'Cheque img is picked',
                    style: TextStyle(
                        fontFamily: FontType.MontserratRegular,
                        color: chequeChange == null ? Colors.black87 : hsPrime,
                        fontSize: 10),
                  ),
                  trailing: Container(
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                        userStatus == '0' ? TextButton(
                            onPressed: ()async{
                              var chequeFileCamera = await FileImagePicker().pickCamera();
                              setState(() {
                                chequeChange = chequeFileCamera;
                              });
                            },
                            child: const Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                        ) : Container()
                      ],
                    ),
                  ),
                  children: [
                    chequeImg == 'null' ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Image not found"),
                    ) : Image.network(
                      '$chequeImg',
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child!;
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  title: const Text("GST file image",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12)),
                  subtitle: Text(gstFileChange == null
                      ? '${gstFile == 'null' ? 'N/A' : gstFile}' : 'GST img is picked',
                    style: TextStyle(
                        fontFamily: FontType.MontserratRegular,
                        color: gstFileChange == null ? Colors.black87 : hsPrime,
                        fontSize: 10),
                  ),
                  trailing: Container(
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("View",style: TextStyle(fontFamily: FontType.MontserratRegular)),
                        userStatus == '0' ? TextButton(
                            onPressed: ()async{
                              var gstImgCamera = await FileImagePicker().pickCamera();
                              setState(() {
                                gstFileChange = gstImgCamera;
                              });
                            },
                            child: const Text("Upload",style: TextStyle(fontFamily: FontType.MontserratRegular))
                        ) : Container()
                      ],
                    ),
                  ),
                  children: [
                    gstImg == 'null' ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Image not found"),
                    ) : Image.network(
                      '$gstImg',
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child!;
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
          ),
        ),
        userStatus == '0'? ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                backgroundColor: hsPrime
            ),
            onPressed: (){
              if(userStatus == '0'){
                updateProfileData(context);
              }
              else if(userStatus == '1'){
                GetXSnackBarMsg.getWarningMsg('${AppTextHelper().notUpdateUser}');
              }
              else{
                GetXSnackBarMsg.getWarningMsg('${AppTextHelper().userNotFound}');
              }
            },
            child: const Text("Update profile",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white))
        ) : Container()
      ],
    );
  }

  Widget showTextField(var label, TextEditingController controller, IconData iconData){
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
          hintText: '$label',
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
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.0),
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
            'pancard', await MultipartFile.fromFile(panCardChange!.path)));
      }
      if (addressChange != null) {
        formData.files.add(MapEntry(
            'address_proof', await MultipartFile.fromFile(addressChange!.path)));
      }
      if (aadhaarCardFChange != null) {
        formData.files.add(MapEntry(
            'aadhar_front',
            await MultipartFile.fromFile(aadhaarCardFChange!.path)));
      }
      if (aadhaarCardBChange != null) {
        formData.files.add(MapEntry(
            'aadhar_back', await MultipartFile.fromFile(aadhaarCardBChange!.path)));
      }
      if (chequeChange != null) {
        formData.files.add(MapEntry(
            'cheque_image', await MultipartFile.fromFile(chequeChange!.path)));
      }
      if (gstFileChange != null) {
        formData.files.add(MapEntry(
            'gst_image', await MultipartFile.fromFile(gstFileChange!.path)));
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
          GetXSnackBarMsg.getSuccessMsg('$msg');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
        }
      } else if (response.statusCode == 400) {
        var data = response.data;
        var errorMsg = data['message'];
        if (data['status'] == 400) {
          GetXSnackBarMsg.getWarningMsg('$errorMsg');
          Navigator.pop(context);
        }
      }
    } catch (e) {

      print("Error uploading documents: ${e}");
      GetXSnackBarMsg.getWarningMsg('${AppTextHelper().selectDocuments}');
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
          address.text = pModel.data.address ?? '';
          state.text = pModel.data.state.stateName.toString();
          city.text = pModel.data.city.cityName.toString();
          area.text = pModel.data.area.areaName.toString();
          branch.text = pModel.data.costCenter.branchName.toString();
          pincode = pModel.data.pincode;

          bankNm.text = pModel.data.bankName.toString();
          ifscCode.text = pModel.data.ifsc.toString();
          accountNo.text = pModel.data.accountNumber.toString();
          gstNo = pModel.data.gstNumber.toString();

          panCard = pModel.data.pancard.toString();
          addressProfe = pModel.data.addressProof.toString();
          aadharCardF = pModel.data.aadharFront.toString();
          aadharCardB = pModel.data.aadharBack.toString();
          chequeFile = pModel.data.chequeImage.toString();

          gstFile = pModel.data.gstImage.toString();

          panCardImg = pModel.data.pancardImg.toString();
          addressProfeImg = pModel.data.addressProofImg.toString();
          aadharCardFImg = pModel.data.aadharFrontImg.toString();
          aadharCardBImg = pModel.data.aadharBackImg.toString();
          chequeImg = pModel.data.chequeImg.toString();
          gstImg = pModel.data.gstImg.toString();
        });
      }
      Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).pop(); // Dismiss the loading dialog
    } catch (e) {
      print('Error: $e');
      if (e.toString().contains('402')) {
        DeviceInfo().logoutUser(context, deviceToken, getAccessToken.access_token);
        // logoutUser().then((value) {
        //   userDataSession.removeUserData().then((value) {
        //     DeviceInfo().deleteDeviceToken(context, deviceToken, getAccessToken.access_token).then((value) {
        //       if (value == 'success') {
        //         print("token is deleted $value");
        //       } else {
        //         print("Token is not deleted");
        //       }
        //     });
        //   });
        //   Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => const SplashScreen()),
        //         (Route<dynamic> route) => false,
        //   );
        // });
      } else {
        print('Error: else $e');
        Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).pop();
      }
      Navigator.of(_loadingDialogKey.currentContext!, rootNavigator: true).pop();
    }
  }
}
