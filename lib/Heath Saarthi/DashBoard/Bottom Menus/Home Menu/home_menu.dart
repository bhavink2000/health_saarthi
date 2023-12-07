// ignore_for_file: import_of_legacy_library_into_null_safe, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Profile%20Future/profile_future.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Home%20Widgets/body_checkups.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Home%20Widgets/category.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Home%20Widgets/image_slider.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Home%20Widgets/Today%20Deal/offers.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Home%20Widgets/test_package.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../Global Search Screen/global_search_screen.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {

  GetAccessToken getAccessToken = GetAccessToken();

  var userStatus;
  @override
  void initState() {
    super.initState();
    getAccessToken = GetAccessToken();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      getUserStatus();
    });
  }
  void getUserStatus()async{
    try{
      dynamic userData = await ProfileFuture().fetchProfile(getAccessToken.access_token);
      if (userData != null && userData.data != null) {
        print("user Status -->> ${userData.data.status}");
        setState(() {
          userStatus = userData.data.status;
        });
        if (userStatus == 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Account Status"),
                content: const Text("Account is under review\nPlease connect with the support team."),
                backgroundColor: Colors.white,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog box
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        print('Failed to fetch user: User data is null');
      }
      print("userStatus ==>>$userStatus");
    }
    // on SocketException catch (e) {
    //   log('${e.message}');
    //   GetXSnackBarMsg.getWarningMsg('${e.message}');
    // }
    catch(e){
      print("get User Status Error->$e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 18.h,
                    decoration: BoxDecoration(
                        color: hsPrime.withOpacity(0.1),
                        border: Border.all(color: hsPrime,width: 0.2),
                        borderRadius: const BorderRadius.all(Radius.circular(4))
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: TextFormField(
                      autofocus: false,
                      readOnly: true,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          border: InputBorder.none,
                          hintText: 'Search for Tests, Package',
                          hintStyle: const TextStyle(fontSize: 12,fontFamily: FontType.MontserratRegular),
                          prefixIcon: const Icon(Icons.search_rounded,size: 20),
                          focusColor: hsPrime
                      ),
                      onChanged: (value) {},
                      onTap: (){
                        showSearch(
                            context: context,
                            delegate: GlobalSearch(context: context,accessToken: getAccessToken.access_token)
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const HomeImageSlider(),
              HomeTestPackage(uStatus: userStatus),
              const HomeOffers(),
              const HomeBodyCheckups(),
            ],
          ),
        ),
      ),
    );
  }
}