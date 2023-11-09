// ignore_for_file: import_of_legacy_library_into_null_safe, library_private_types_in_public_api
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/getx_snackbar_msg.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
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
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import 'Drawer Menus Items/Other Screen/qr_code_screen.dart';
import 'Drawer Menus Items/Other Screen/refer_chemist_screen.dart';
import 'Drawer Menus Items/Other Screen/support_screen.dart';
import 'Drawer Menus Items/my_profile_screen.dart';
import 'Drawer Menus Items/my_report_screen.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  GetAccessToken getAccessToken = GetAccessToken();
  String? deviceToken;
  @override
  void initState() {
    super.initState();
    retrieveDeviceToken();
    getAccessToken.checkAuthentication(context, setState);
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
    final userDataSession = Provider.of<UserDataSession>(context);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2,),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width / 1.5,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              const Image(image: AssetImage("assets/health_saarthi_logo.png"),width: 175),
              const SizedBox(height: 20,),
              Expanded(
                child: Container(
                  //height: MediaQuery.of(context).size.height / 1.1.h,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.dashboard,color: hsPrimeOne,size: 25),
                                const SizedBox(width: 10,),
                                const Text("Home",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
                              ],
                            ),
                          ),
                        ),
                        Divider(color: hsPrimeOne,thickness: 0.5,endIndent: 0,indent: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const BookTestScreen()));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.book,color: hsPrimeOne,size: 25),
                                const SizedBox(width: 10,),
                                const Text("Book a test",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
                              ],
                            ),
                          ),
                        ),
                        Divider(color: hsPrimeOne,thickness: 0.5,endIndent: 0,indent: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyBookingScreen()));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.shopping_bag_rounded,color: hsPrimeOne,size: 25),
                                const SizedBox(width: 10,),
                                const Text("My booking history",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
                              ],
                            ),
                          ),
                        ),
                        Divider(color: hsPrimeOne,thickness: 0.5,endIndent: 0,indent: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyReportScreen()));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.event_repeat_outlined,color: hsPrimeOne,size: 25),
                                const SizedBox(width: 10,),
                                const Text("My report",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
                              ],
                            ),
                          ),
                        ),
                        Divider(color: hsPrimeOne,thickness: 0.5,endIndent: 0,indent: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyProfileScreen()));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.person_pin,color: hsPrimeOne,size: 25),
                                const SizedBox(width: 10,),
                                const Text("My profile",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
                              ],
                            ),
                          ),
                        ),
                        Divider(color: hsPrimeOne,thickness: 0.5,endIndent: 0,indent: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ContactUsScreen()));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.phone_android_rounded,color: hsPrimeOne,size: 25),
                                const SizedBox(width: 10,),
                                const Text("Contact us",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
                              ],
                            ),
                          ),
                        ),
                        Divider(color: hsPrimeOne,thickness: 0.5,endIndent: 0,indent: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const FaqScreen()));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.question_answer_rounded,color: hsPrimeOne,size: 25),
                                const SizedBox(width: 10,),
                                const Text("FAQ",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
                              ],
                            ),
                          ),
                        ),
                        Divider(color: hsPrimeOne,thickness: 0.5,endIndent: 0,indent: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SupportScreen()));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.support_agent_rounded,color: hsPrimeOne,size: 25),
                                const SizedBox(width: 10,),
                                const Text("Support",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
                              ],
                            ),
                          ),
                        ),
                        Divider(color: hsPrimeOne,thickness: 0.5,endIndent: 0,indent: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReferChemist()));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.science_rounded,color: hsPrimeOne,size: 25),
                                const SizedBox(width: 10,),
                                const Text("Refer a chemist",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
                              ],
                            ),
                          ),
                        ),
                        Divider(color: hsPrimeOne,thickness: 0.5,endIndent: 0,indent: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCodeScreen()));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.qr_code,color: hsPrimeOne,size: 25),
                                const SizedBox(width: 10,),
                                const Text("Download QR code",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
                              ],
                            ),
                          ),
                        ),
                        Divider(color: hsPrimeOne,thickness: 0.5,endIndent: 0,indent: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: InkWell(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                      child: AlertDialog(
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                        content: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Image.asset("assets/health_saarthi_logo.png",width: 150),
                                              const Padding(
                                                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                                child: Text(
                                                  "Are You Sure Would Like To Logout?",
                                                  style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 16),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  InkWell(
                                                    onTap: ()=>Navigator.pop(context),
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width / 4.w,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: hsPrime,
                                                      ),
                                                      child: const Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                                        child: Text("Stay",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      logoutUser().then((value) {
                                                        var logoutUserStatus = value.toString();
                                                        print("Logout user status ->$logoutUserStatus");

                                                        if(logoutUserStatus == '200'){
                                                          userDataSession.removeUserData().then((values) {
                                                            DeviceInfo().deleteDeviceToken(context, deviceToken, getAccessToken.access_token).then((value) {
                                                              if (value == 'success') {
                                                                print("token is deleted $value");
                                                              } else {
                                                                print("Token is not deleted");
                                                              }
                                                            });
                                                            var removeUser = values;
                                                            if(removeUser == true){
                                                              Navigator.of(context).pushAndRemoveUntil(
                                                                MaterialPageRoute(builder: (context) => const SplashScreen()),
                                                                    (Route<dynamic> route) => false,
                                                              );
                                                            }
                                                            else{
                                                              print("removeUser not proper remove");
                                                              Navigator.pop(context);
                                                            }
                                                          });
                                                        }
                                                        else if(logoutUserStatus == '402'){
                                                          GetXSnackBarMsg.getWarningMsg('Token is Invalid');
                                                          print("user proper not logout,");
                                                          Navigator.pop(context);
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
                                                        child: Text("Logout",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
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
                                  }
                              );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.logout_rounded,color: hsPrimeOne,size: 25),
                                const SizedBox(width: 10,),
                                const Text("Log out",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
                              ],
                            ),
                          ),
                        ),
                        Divider(color: hsPrimeOne,thickness: 0.5,endIndent: 0,indent: 20),
                      ],
                    ),
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
      'Authorization': 'Bearer ${getAccessToken.access_token}',
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
      } else if(bodyStatus == '402'){
        return bodyStatus;
      }
    } catch (error) {
      print("logout catch -error-->>${error.toString()}");
      GetXSnackBarMsg.getWarningMsg('${AppTextHelper().logoutProblem}');
    }
  }
}
