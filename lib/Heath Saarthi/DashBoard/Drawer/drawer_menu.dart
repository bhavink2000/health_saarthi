// ignore_for_file: import_of_legacy_library_into_null_safe, library_private_types_in_public_api
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/token_expired_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/getx_snackbar_msg.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/UI%20Helper/app_icons_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Drawer/Drawer%20Menus%20Items/Other%20Screen/faq_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Splash%20Screen/splash_screen.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Drawer/Drawer%20Menus%20Items/book_test_screen.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Drawer/Drawer%20Menus%20Items/contact_us_screen.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Drawer/Drawer%20Menus%20Items/my_booking_screen.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/hs_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../App Helper/Backend Helper/Device Info/device_info.dart';
import '../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../../App Helper/Backend Helper/bottom_navigation_controller.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Getx Helper/user_status_check.dart';
import 'Drawer Menus Items/Other Screen/qr_code_screen.dart';
import 'Drawer Menus Items/Other Screen/refer_chemist_screen.dart';
import 'Drawer Menus Items/Other Screen/support_screen.dart';
import 'Drawer Menus Items/my_profile_screen.dart';
import 'Drawer Menus Items/my_report_screen.dart';
import 'multiple_camera.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final controller = Get.put(BottomBarController());
  final box = GetStorage();

  //GetAccessToken getAccessToken = GetAccessToken();
  String? deviceToken;
  @override
  void initState() {
    super.initState();
    retrieveDeviceToken();
    //getAccessToken.checkAuthentication(context, setState);
  }

  Future<void> retrieveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      deviceToken = prefs.getString('deviceToken');
    });
  }

  @override
  void dispose() {
    Get.delete<UserStatusCheckController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final userDataSession = Provider.of<UserDataSession>(context);
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2,
        sigmaY: 2,
      ),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width / 1.5,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image(image: AppIcons.hsLogo, width: 175),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              controller.index.value = 0;
                            });
                            Get.delete<UserStatusCheckController>();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.dashboard, color: hsPrimeOne, size: 25),
                              const SizedBox(width: 10,),
                              const Text("Home", style: TextStyle(fontSize: 14, fontFamily: FontType.MontserratMedium))
                            ],
                          ),
                        ),
                      ),
                      Divider(color: hsPrimeOne, thickness: 0.5, endIndent: 0, indent: 20),
                      DrawerMenuItemsWidget(
                        itemName: 'Book a test',
                        iconData: Icons.book,
                        itemOnTap: () {
                          Get.delete<UserStatusCheckController>();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const BookTestScreen()));},
                      ),
                      Divider(color: hsPrimeOne, thickness: 0.5, endIndent: 0, indent: 20),
                      DrawerMenuItemsWidget(
                        itemName: 'My booking history',
                        iconData: Icons.shopping_bag_rounded,
                        itemOnTap: () {
                          Get.delete<UserStatusCheckController>();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyBookingScreen()));},
                      ),
                      Divider(color: hsPrimeOne, thickness: 0.5, endIndent: 0, indent: 20),
                      DrawerMenuItemsWidget(
                        itemName: 'My report',
                        iconData: Icons.event_available_rounded,
                        itemOnTap: () {
                          Get.delete<UserStatusCheckController>();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyReportScreen()));},
                      ),
                      Divider(color: hsPrimeOne, thickness: 0.5, endIndent: 0, indent: 20),
                      DrawerMenuItemsWidget(
                        itemName: 'My profile',
                        iconData: Icons.person_pin,
                        itemOnTap: () {
                          Get.delete<UserStatusCheckController>();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProfileScreen()));},
                      ),
                      Divider(color: hsPrimeOne, thickness: 0.5, endIndent: 0, indent: 20),
                      DrawerMenuItemsWidget(
                        itemName: 'Contact us',
                        iconData: Icons.phone_android_rounded,
                        itemOnTap: () {
                          Get.delete<UserStatusCheckController>();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUsScreen()));},
                      ),
                      Divider(color: hsPrimeOne, thickness: 0.5, endIndent: 0, indent: 20),
                      DrawerMenuItemsWidget(
                        itemName: 'FAQ',
                        iconData: Icons.question_answer_rounded,
                        itemOnTap: () {
                          Get.delete<UserStatusCheckController>();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const FaqScreen()));},
                      ),
                      Divider(color: hsPrimeOne, thickness: 0.5, endIndent: 0, indent: 20),
                      DrawerMenuItemsWidget(
                        itemName: 'Support',
                        iconData: Icons.support_agent_rounded,
                        itemOnTap: () {
                          Get.delete<UserStatusCheckController>();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SupportScreen()));},
                      ),
                      Divider(color: hsPrimeOne, thickness: 0.5, endIndent: 0, indent: 20),
                      DrawerMenuItemsWidget(
                        itemName: 'Refer a chemist',
                        iconData: Icons.science_rounded,
                        itemOnTap: () {
                          Get.delete<UserStatusCheckController>();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ReferChemist()));},
                      ),
                      Divider(color: hsPrimeOne, thickness: 0.5, endIndent: 0, indent: 20),
                      DrawerMenuItemsWidget(
                        itemName: 'Download QR code',
                        iconData: Icons.qr_code,
                        itemOnTap: () {
                          Get.delete<UserStatusCheckController>();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const QRCodeScreen()));},
                      ),
                      Divider(color: hsPrimeOne, thickness: 0.5, endIndent: 0, indent: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                    child: AlertDialog(
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                      content: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Image(image: AppIcons.hsTransparent,width: 150),
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                              child: Text(
                                                "Are You Sure Would Like To Logout?",
                                                style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 16), textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () => Navigator.pop(context),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width / 4.w,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: hsPrime,
                                                    ),
                                                    child: const Padding(
                                                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                                      child: Text(
                                                        "Stay",
                                                        style: TextStyle(fontFamily: FontType.MontserratMedium,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    logoutUser().then((value) {
                                                      var logoutUserStatus = value.toString();
                                                      print("Logout user status ->$logoutUserStatus");
                                                      if (logoutUserStatus == '200') {
                                                        log('in if code ->200');
                                                        AuthenticationManager().removeToken().then((value){
                                                          box.remove('accessToken');
                                                          box.remove('name',);
                                                          box.remove('mobile',);
                                                          box.remove('email',);
                                                          box.remove('address',);
                                                          box.remove('stateNm',);
                                                          box.remove('cityNm',);
                                                          box.remove('areaNm',);
                                                          box.remove('branchNm',);
                                                          box.remove('pincode',);
                                                          box.remove('bankNm',);
                                                          box.remove('ifsc',);
                                                          box.remove('accountNo',);
                                                          box.remove('gstNo',);
                                                          box.remove('pancard',);
                                                          box.remove('addressProof',);
                                                          box.remove('aadhaarF',);
                                                          box.remove('aadhaarB',);
                                                          box.remove('chequeImage',);
                                                          box.remove('gstImage',);
                                                          box.remove('pancardImg',);
                                                          box.remove('addressImg',);
                                                          box.remove('aadhaarFImg',);
                                                          box.remove('aadhaarBImg',);
                                                          box.remove('chequeImg',);
                                                          box.remove('gstImg',);
                                                          DeviceInfo().deleteDeviceToken().then((value) {
                                                            if (value == 'success') {
                                                              print("token is deleted $value");
                                                            } else {
                                                              print("Token is not deleted");
                                                            }
                                                          });
                                                          Navigator.of(context).pushAndRemoveUntil(
                                                            MaterialPageRoute(builder: (context) => const SplashScreen()),
                                                                (Route<dynamic>route) => false,
                                                          );
                                                        });
                                                      } else if (logoutUserStatus == '402') {
                                                        log('in else if code ->402');
                                                        AuthenticationManager().removeToken().then((value){
                                                          box.remove('accessToken');
                                                          DeviceInfo().deleteDeviceToken().then((value) {
                                                            if (value == 'success') {
                                                              print("token is deleted $value");
                                                            } else {
                                                              print("Token is not deleted");
                                                            }
                                                          });
                                                          Navigator.of(context).pushAndRemoveUntil(
                                                            MaterialPageRoute(builder: (context) => const SplashScreen()),
                                                                (Route<dynamic>route) => false,
                                                          );
                                                        });
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width / 4.w,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: hsPrime,
                                                    ),
                                                    child: const Padding(
                                                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                                      child: Text(
                                                        "Logout",
                                                        style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.logout_rounded, color: hsPrimeOne, size: 25),
                              const SizedBox(width: 10,),
                              const Text("Log out", style: TextStyle(fontSize: 14, fontFamily: FontType.MontserratMedium))
                            ],
                          ),
                        ),
                      ),
                      Divider(color: hsPrimeOne, thickness: 0.5, endIndent: 0, indent: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var bodyMsg;
  Future<dynamic> logoutUser() async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('accessToken')}',
    };
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.logoutUrl),
        headers: headers,
      );
      final responseData = json.decode(response.body);
      print("drawer logout->$responseData");
      var bodyStatus = responseData['status'];
      bodyMsg = responseData['message'];

      if (bodyStatus == 200) {
        GetXSnackBarMsg.getSuccessMsg('$bodyMsg');
        return bodyStatus;
      } else if (bodyStatus == '402') {
        log('in else if -->>$bodyMsg');
        GetXSnackBarMsg.getWarningMsg('$bodyMsg');
        return bodyStatus;
      }
    } catch (error) {
      print("logout catch -error-->>${error.toString()}");
    }
  }
}

class DrawerMenuItemsWidget extends StatelessWidget {
  String? itemName;
  final VoidCallback? itemOnTap;
  IconData? iconData;
  DrawerMenuItemsWidget({super.key, this.itemOnTap, this.itemName, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
      child: InkWell(
        onTap: itemOnTap,
        child: Row(
          children: [
            Icon(iconData, color: hsPrimeOne, size: 25),
            const SizedBox(width: 10,),
            Text("$itemName", style: const TextStyle(fontSize: 14, fontFamily: FontType.MontserratMedium))
          ],
        ),
      ),
    );
  }
}
