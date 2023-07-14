import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/snackbar_msg_show.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/home_menu.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Report%20Menu/report_menu.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Drawer/drawer_menu.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Global%20Search%20Screen/global_search_screen.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Notification%20Menu/notification_menu.dart';
import '../App Helper/Backend Helper/Api Service/notification_service.dart';
import '../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../App Helper/Frontend Helper/UI Helper/app_icons_helper.dart';
import 'Add To Cart/test_cart.dart';
import 'Bottom Menus/Profile Menu/profile_menu.dart';
import 'Bottom Menus/Test Menu/test_menu_book_now.dart';


class Home extends StatefulWidget {
  var deviceToken;
  Home({Key? key,this.deviceToken}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GetAccessToken getAccessToken = GetAccessToken();
  int _currentIndex = 0;
  List<Widget> _widgetList = [];

  @override
  void initState() {
    super.initState();
    getAccessToken = GetAccessToken();
    getAccessToken.checkAuthentication(context, setState);
    _widgetList = [
      const HomeMenu(),
      const TestMenu(),
      const ReportMenu(),
      const ProfileMenu(),
    ];
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
                      width: MediaQuery.of(context).size.width / 5.5,
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
}
