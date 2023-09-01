import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/getx_snackbar_msg.dart';
import 'package:http/http.dart' as http;
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/token_expired_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/home_menu.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Report%20Menu/report_menu.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Drawer/drawer_menu.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Notification%20Menu/notification_menu.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../App Helper/Backend Helper/Device Info/device_info.dart';
import '../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../App Helper/Frontend Helper/Dialog Helper/update_app_dialog.dart';
import '../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../App Helper/Frontend Helper/UI Helper/app_icons_helper.dart';
import '../Authentication Screens/Splash Screen/splash_screen.dart';
import 'Add To Cart/test_cart.dart';
import 'Bottom Menus/Profile Menu/profile_menu.dart';
import 'Bottom Menus/Test Menu/test_menu_book_now.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GetAccessToken getAccessToken = GetAccessToken();
  int _currentIndex = 0;
  List<Widget> _widgetList = [];


  var appVersion, updateMsg;
  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;
  String? installerStore;
  var deviceToken,deviceType;
  var userDataSession;

  bool? callAddDevice;
  @override
  void initState(){
    super.initState();
    getAccessToken = GetAccessToken();
    getAccessToken.checkAuthentication(context, setState);
    userDataSession = Provider.of<UserDataSession>(context, listen: false);
    retrieveCallAddDevice();
    Future.delayed(Duration(seconds: 1), () {
      deviceTokenType();
      print("callAdddevice->$callAddDevice");
    });

    _widgetList = [
      const HomeMenu(),
      const TestMenu(),
      const ReportMenu(),
      const ProfileMenu(),
    ];
  }
  Future<void> storeCallAddDevice() async {
    print("calling store call add device");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('callAddDevice', true);
  }
  Future<dynamic> retrieveCallAddDevice() async {
    print("call retrieve call add device");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    callAddDevice = prefs.getBool('callAddDevice');
    print("call Add Device --> $callAddDevice");
    return callAddDevice;
  }

  void deviceTokenType()async{
    await retrieveDeviceToken();
    await retrieveDeviceDetails();
    print("----->>>>>after(dashboard) login add device token api call with accesstoken<<<<<-----");
    await DeviceInfo().sendDeviceToken(context, deviceToken, deviceType, getAccessToken.access_token).then((value) async{
      if (value == null) {
        var data = json.decode(value);
        print("after(dashboard) login check value-->${value}");
        print("after(dashboard) login chack value data->${data}");
      } else {
        var data = json.decode(value);
        if (data['status'] == 200) {
          print("----->>>>>");
          storeCallAddDevice();
          print("after(dashboard) login check device token check status->>${data['status']}");
          print("<<<<<-----");
        } else if (data['status'] == 201) {
          print("<<<<<-----");
          print("after(dashboard) login device status is ->${data['status']}");
          setState(() {
            updateMsg = data['message'];
            appVersion = data['app_version'];
          });
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: AlertDialog(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                        contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                        content: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          //height: MediaQuery.of(context).size.height / 2.8,
                          //color: hsPrime,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(alignment: Alignment.center,child: Image(image: AssetImage('assets/health_saarthi_logo.png'),width: 150,)),
                              Divider(thickness: 0.5,color: Colors.grey.withOpacity(0.5),),
                              const Text(
                                "About update?",
                                style: TextStyle(
                                    fontFamily: FontType.MontserratMedium,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "You must be logout your account from health saarthi",
                                style: const TextStyle(
                                    fontFamily: FontType.MontserratLight),
                              ),
                              const SizedBox(height: 10,),
                              const Text("if you not logout then you are not use new futures",
                                  style: TextStyle(fontFamily: FontType.MontserratLight)),
                              const SizedBox(height: 10),
                              const Text("so please logout your account",
                                  style: TextStyle(
                                      fontFamily: FontType.MontserratMedium,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              const Text("",
                                style: TextStyle(fontFamily: FontType.MontserratLight)),
                              Divider(thickness: 0.5,color: Colors.grey.withOpacity(0.5),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: ()async {
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
                                          storeCallAddDevice();
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SplashScreen()), (Route<dynamic> route) => false);
                                        });
                                      },
                                      child: Text("Logout",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsPrime,fontWeight: FontWeight.bold,fontSize: 16),)
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
          print("----->>>>>");
        } else {
          var errorMsg = data['error']['device_token'];
          print("Error->$errorMsg");
          Navigator.pop(context);
        }
      }
    });
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
      print("token logout->$responseData");
      var bodyStatus = responseData['status'];
      bodyMsg = responseData['message'];

      if (bodyStatus == 200) {
        GetXSnackBarMsg.getSuccessMsg('$bodyMsg');
      } else {
      }
    } catch (error) {
      print("logoutUser catch->$error");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: hsPrimeOne,
        selectedItemColor: hsOne,
        iconSize: 20,
        fontSize: 12,
        unselectedItemColor: Colors.white60,
        onTap: onTapScreen,
        currentIndex: _currentIndex,
        items: [
          FloatingNavbarItem(
            title: 'Home',
            customWidget: Image(image: AppIcons().HHome,width: _currentIndex == 0 ? 25 : 20,color: _currentIndex == 0 ? Colors.black87 : Colors.white60)
          ),
          FloatingNavbarItem(
            title: 'Book Now',
            customWidget: Image(image: AppIcons().HBookNow,width: _currentIndex == 1 ? 25 : 20,color: _currentIndex == 1 ? Colors.black87 : Colors.white60)
          ),
          FloatingNavbarItem(
            title: 'Record',
            customWidget: Image(image: AppIcons().HRecord,width: _currentIndex == 2 ? 25 : 20,color: _currentIndex == 2 ? Colors.black87 : Colors.white60)
          ),
          FloatingNavbarItem(
            title: 'Profile',
            customWidget: Image(image: AppIcons().HProfile,width: _currentIndex == 3 ? 25 : 20,color: _currentIndex == 3 ? Colors.black87 : Colors.white60)
          ),
        ],
      ),
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
                    const Image(image: AssetImage("assets/health_saarthi_logo.png"),width: 150),
                    Container(
                      width: MediaQuery.of(context).size.width / 5.35,
                      child: Row(
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                              },child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Icon(Icons.shopping_cart_rounded,color: hsPrime,size: 25),
                              )
                          ),
                          SizedBox(width: 5.w,),
                          InkWell(
                              onTap: (){
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
              child: _widgetList[_currentIndex]
            )
          ],
        ),
      ),
      drawer: DrawerScreen(),
    );
  }

  void onTapScreen(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> retrieveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      deviceToken = prefs.getString('deviceToken');
    });
    print("hs_dashboard \nDeviceToken->$deviceToken");
  }

  Future retrieveDeviceDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      appName     = packageInfo.appName;
      packageName = packageInfo.packageName;
      version     = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      installerStore = packageInfo.installerStore;
      print('Android dashboard ==> \nVersion appName->$appName \npackageName->$packageName, \nversion->$version \nbuildNumber->$buildNumber');
      setState(() {
        deviceType = 'Android';
      });
      return deviceType;
    } else if (Platform.isIOS) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      print('IOS Dashboard ==>> Release Version appName->$appName \npackageName->$packageName, \nversion->$version \nbuildNumber->$buildNumber');
      setState(() {
        deviceType = 'iOS';
      });
      return deviceType;
    }
    print('retrieve Device Type: $deviceType');
  }
}
