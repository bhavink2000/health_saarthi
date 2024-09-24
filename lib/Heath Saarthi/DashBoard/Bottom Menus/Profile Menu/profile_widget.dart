import 'dart:developer';
import 'dart:io';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Dashboard%20Model/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/bottom_navigation_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App Helper/Backend Helper/Api Future/Profile Future/profile_future.dart';
import '../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../App Helper/Backend Helper/Device Info/device_info.dart';
import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Frontend Helper/File Picker/file_image_picker.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../../App Helper/Frontend Helper/Text Helper/test_helper.dart';
import '../../hs_dashboard.dart';
import 'change_password.dart';

class ProfileWidgets extends StatefulWidget {
  const ProfileWidgets({super.key});

  @override
  State<ProfileWidgets> createState() => _ProfileWidgetsState();
}

class _ProfileWidgetsState extends State<ProfileWidgets> {


  //GetAccessToken getAccessToken = GetAccessToken();

  final bottomController = Get.put(BottomBarController());
  final box = GetStorage();
  String? deviceToken;

  File? panCardChange;
  File? aadhaarCardFChange;
  File? aadhaarCardBChange;
  File? addressChange;
  File? chequeChange;
  File? gstFileChange;


  bool mounted = false;
  var userStatus;

  @override
  void initState(){
    super.initState();
    mounted = true;
    //getAccessToken.checkAuthentication(context, setState);
    functionCall();
  }

  functionCall()async{
    Future.delayed(const Duration(seconds: 1), () async{
      if (mounted) {
        await getProfile();
      }
    });
  }

  @override
  void dispose() {
    mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        showTextField('${box.read('vendorNm')}',Icons.person),
        showTextField('${box.read('name')}',Icons.home_max_rounded),
        showTextField('${box.read('mobile')}',Icons.mobile_friendly),
        showTextField('${box.read('email')}',Icons.email_rounded),

        showTextField('${box.read('address')}',Icons.location_city),
        showTextField('${box.read('stateNm')}',Icons.query_stats),
        showTextField('${box.read('cityNm')}',Icons.reduce_capacity),
        showTextField('${box.read('areaNm')}',Icons.area_chart),
        showTextField('${box.read('branchNm')}', Icons.location_city),
        showTextField('${box.read('pincode')}', Icons.code),

        showTextField('${box.read('bankNm')}', Icons.account_balance_rounded),
        showTextField('${box.read('ifsc')}', Icons.account_tree_rounded),
        showTextField('${box.read('accountNo')}',Icons.account_balance_wallet_rounded),
        showTextField('${box.read('gstNo')}',Icons.app_registration_rounded),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen(accessToken: box.read('accessToken'))));
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
                  subtitle: Text(panCardChange == null ? '${box.read('pancard')}' : 'Pan Card is picked',
                    style: TextStyle(
                        fontFamily: FontType.MontserratRegular,
                        color: panCardChange == null ? Colors.black87 : hsPrime,
                        fontSize: 10),
                  ),
                  trailing: Container(
                    width: 115,
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
                    box.read('pancardImg') == 'null' ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Image not found"),
                    ) : Image.network(
                      '${box.read('pancardImg')}',
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
                      ? '${box.read('aadhaarF')}' : 'Aadhaar card front is picked',
                    style: TextStyle(
                        fontFamily: FontType.MontserratRegular,
                        color: aadhaarCardFChange == null  ? Colors.black87 : hsPrime,
                        fontSize: 10),
                  ),
                  trailing: Container(
                    width: 115,
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
                    box.read('aadhaarFImg') == 'null' ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Image not found"),
                    ) :Image.network(
                      '${box.read('aadhaarFImg')}',
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
                      ? '${box.read('aadhaarB')}' : 'Aadhaar card back is picked',
                    style: TextStyle(
                        fontFamily: FontType.MontserratRegular,
                        color: aadhaarCardBChange == null ? Colors.black87 : hsPrime,
                        fontSize: 10),
                  ),
                  trailing: Container(
                    width: 115,
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
                    box.read('aadhaarBImg') == 'null' ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Image not found"),
                    ) : Image.network(
                      '${box.read('aadhaarBImg')}',
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
                      ? '${box.read('addressProof')}' : 'Address proof is picked',
                    style: TextStyle(
                        fontFamily: FontType.MontserratRegular,
                        color: addressChange == null ? Colors.black87 : hsPrime,
                        fontSize: 10),
                  ),
                  trailing: Container(
                    width: 115,
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
                    box.read('addressImg') == 'null' ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Image not found"),
                    ) : Image.network(
                      '${box.read('addressImg')}',
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
                      ? '${box.read('chequeImage')}' : 'Cheque img is picked',
                    style: TextStyle(
                        fontFamily: FontType.MontserratRegular,
                        color: chequeChange == null ? Colors.black87 : hsPrime,
                        fontSize: 10),
                  ),
                  trailing: Container(
                    width: 115,
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
                    box.read('chequeImg') == 'null' ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Image not found"),
                    ) : Image.network(
                      '${box.read('chequeImg')}',
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
                      ? '${box.read('gstImage') == 'null' ? 'N/A' : box.read('gstImage')}' : 'GST img is picked',
                    style: TextStyle(
                        fontFamily: FontType.MontserratRegular,
                        color: gstFileChange == null ? Colors.black87 : hsPrime,
                        fontSize: 10),
                  ),
                  trailing: Container(
                    width: 115,
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
                    box.read('gstImg') == 'null' ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Image not found"),
                    ) : Image.network(
                      '${box.read('gstImg')}',
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
            },
            child: const Text("Update profile",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white))
        ) : Container()
      ],
    );
  }

  Widget showTextField(var label,IconData iconData){
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: TextField(
        //controller: controller,
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
            'Authorization': 'Bearer ${box.read('accessToken')}',
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        var data = response.data;
        var msg = data['message'];
        if (data['status'] == 200) {
          GetXSnackBarMsg.getSuccessMsg('$msg');
          bottomController.index.value = 0;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
        }else if(data['status'] == '402'){
          GetXSnackBarMsg.getWarningMsg('$msg');
          DeviceInfo().logoutUser();
        }
      }
    } catch (e) {
      print("Error uploading documents: ${e}");
      GetXSnackBarMsg.getWarningMsg('${AppTextHelper().selectDocuments}');
      Navigator.pop(context);
    }
  }

  ProfileModel? profileModel;
  Future<void> getProfile() async {
    try {
      profileModel = await ProfileFuture().fetchProfile();
      if (mounted && profileModel != null && profileModel?.data != null) {
        setState(() {
          userStatus = profileModel?.data?.status?.toString() ?? '';
          mounted = false;
        });
      }
    } catch (e) {
      log('catch Error: $e');
      if (e is Exception && e.toString().contains('402')) {
        var errorMessage = e.toString();
        var messageIndex = errorMessage.indexOf('message: ');
        if (messageIndex != -1) {
          errorMessage = errorMessage.substring(messageIndex + 'message: '.length);
          errorMessage = errorMessage.trim().replaceAll('}', ''); // Clean up the string
          GetXSnackBarMsg.getWarningMsg(errorMessage);
          DeviceInfo().logoutUser();
        } else {
          log('catch Error: else $e');
          DeviceInfo().logoutUser();
        }
      }
    }
  }

}

