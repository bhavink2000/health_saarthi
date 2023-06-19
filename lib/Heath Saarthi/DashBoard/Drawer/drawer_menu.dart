// ignore_for_file: import_of_legacy_library_into_null_safe, library_private_types_in_public_api

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Login%20Screen/login_screen.dart';
import 'package:health_saarthi/Heath%20Saarthi/Authentication%20Screens/Splash%20Screen/splash_screen.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Drawer/Drawer%20Menus%20Items/book_test_screen.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Drawer/Drawer%20Menus%20Items/contact_us_screen.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Drawer/Drawer%20Menus%20Items/my_booking_screen.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/hs_dashboard.dart';
import 'package:provider/provider.dart';
import '../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import 'Drawer Menus Items/my_profile_screen.dart';
import 'Drawer Menus Items/my_report_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
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
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
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
                      const Text("Book A Test",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
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
                      const Text("My Booking History",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
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
                      const Text("My Report",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
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
                      const Text("My Profile",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
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
                      const Text("Contact Us",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
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
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        "Are You Sure Would Like To Logout?",
                                        style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        TextButton(
                                          child: const Text("Stay",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 2),),
                                          onPressed: () => Navigator.of(context).pop(),
                                        ),
                                        TextButton(
                                          child: const Text("Logout",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 2),),
                                          onPressed: (){
                                            logoutUser().then((value){
                                              userDataSession.removeUserData();
                                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
                                            });
                                          },
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
                      const Text("Log Out",style: TextStyle(fontSize: 14,fontFamily: FontType.MontserratMedium))
                    ],
                  ),
                ),
              ),
              Divider(color: hsPrimeOne,thickness: 0.5,endIndent: 0,indent: 20),
              const Spacer(),
              const Text("STERLING ACCURIS WELLNESS PVT. LTD.",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),textAlign: TextAlign.center,),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
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
        SnackBarMessageShow.errorMSG('$bodyMsg', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }
}
