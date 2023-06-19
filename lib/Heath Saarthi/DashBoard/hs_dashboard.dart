import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/home_menu.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Report%20Menu/report_menu.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Drawer/drawer_menu.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Notification%20Menu/notification_menu.dart';
import '../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../App Helper/Frontend Helper/UI Helper/app_icons_helper.dart';
import 'Add To Cart/test_cart.dart';
import 'Bottom Menus/Profile Menu/profile_menu.dart';
import 'Bottom Menus/Test Menu/test_menu.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;
  final List<Widget> _widgetList = [
    const HomeMenu(),
    const TestMenu(),
    const ReportMenu(),
    const ProfileMenu(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
                    offset: Offset(0, 1),
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //color: Colors.green,
                          child: IconButton(
                              icon: Image.asset("assets/menu.png",color: hsPrimeOne),
                              onPressed: () => _scaffoldKey.currentState?.openDrawer()
                          ),
                        ),
                        const Image(image: AssetImage("assets/health_saarthi_logo.png"),width: 150),
                        Container(
                          width: MediaQuery.of(context).size.width / 6.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                                  },child: Icon(Icons.shopping_cart_rounded,color: hsPrime,size: 25)
                              ),
                              //const SizedBox(width: 5,),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationMenu()));
                                  },child: Icon(Icons.circle_notifications_rounded,color: hsPrime,size: 25)
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Card(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 22.h,
                        decoration: BoxDecoration(
                            color: hsPrime.withOpacity(0.1),
                            border: Border.all(color: hsPrime,width: 0.2),
                            borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              border: InputBorder.none,
                              hintText: 'Search for Tests, Package',
                              hintStyle: TextStyle(fontSize: 12,fontFamily: FontType.MontserratRegular),
                              prefixIcon: Icon(Icons.search_rounded,size: 20),
                            focusColor: hsPrime
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _widgetList[_currentIndex]
            )
          ],
        ),
      ),
      drawer: const DrawerScreen(),
    );
  }

  void onTapScreen(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}
