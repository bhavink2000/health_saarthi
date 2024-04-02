// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Dialog%20Helper/update_show_dialog.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/UI%20Helper/app_icons_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Getx%20Helper/location_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Drawer/drawer_menu.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Notification%20Menu/notification_menu.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../App Helper/Backend Helper/Device Info/device_info.dart';
import '../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../App Helper/Backend Helper/bottom_navigation_controller.dart';
import '../App Helper/Check Internet Helper/Bindings/dependency_injection.dart';
import '../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../App Helper/Getx Helper/user_status_check.dart';
import 'Add To Cart/test_cart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  final controller = Get.put(BottomBarController());
  final locationController = Get.put(LocationCall());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //GetAccessToken getAccessToken = GetAccessToken();
  final box = GetStorage();

  @override
  void initState(){
    CheckNetworkDependencyInjection.init();
    Future.delayed(const Duration(seconds: 1), () {
      deviceTokenType();
    });
    super.initState();
  }

  void deviceTokenType()async{
    await DeviceInfo().sendDeviceToken(context).then((value) async{
      if (value == null) {
        var data = json.decode(value);
      } else {
        var data = json.decode(value);
        if (data['status'] == 200) {

        }
        else if (data['status'] == 201) {
          UpdateShowDialog().updateShow(context);
        } else {
          var errorMsg = data['error']['device_token'];
          print("Error->$errorMsg");
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val){
        return openExitBox();
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: bottomNavBar(),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.menu_rounded,color: hsPrime,),
                          onPressed: () => _scaffoldKey.currentState?.openDrawer()
                        ),
                      ),
                      Image(image: AppIcons.hsLogo,width: 150),
                      Container(
                        width: MediaQuery.of(context).size.width / 5.35,
                        child: Row(
                          children: [
                            InkWell(
                                onTap: (){
                                  Get.delete<UserStatusCheckController>();
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                                },child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Icon(Icons.shopping_cart_rounded,color: hsPrime,size: 25),
                                )
                            ),
                            SizedBox(width: 5.w,),
                            InkWell(
                                onTap: (){
                                  Get.delete<UserStatusCheckController>();
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationMenu()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Icon(Icons.circle_notifications_rounded,color: hsPrime,size: 25),
                                )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(() => controller.screens[controller.index.value]),
              ),
            ],
          ),
        ),
        drawer: DrawerScreen(),
      ),
    );
  }
  openExitBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AlertDialog(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              content: Container(
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image(image: AppIcons.hsTransparent,width: 150,),
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Are you sure you want to exit.?",
                        style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          child: const Text("Stay",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 2),),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: const Text("Exit",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 2),),
                          onPressed: (){
                            exit(0);
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
  }

}
