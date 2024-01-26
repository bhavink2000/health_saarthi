import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../DashBoard/Add To Cart/test_cart.dart';
import '../../DashBoard/Notification Menu/notification_menu.dart';
import '../Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../Getx Helper/user_status_check.dart';

class AppBarHelper extends StatelessWidget {

  final String appBarLabel;
  const AppBarHelper({super.key, required this.appBarLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: Row(
                children: [
                  IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back,color: Colors.black,size: 24)),
                  SizedBox(width: 10.w),
                  Text("$appBarLabel",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.bold),)
                ],
              )
          ),
          Row(
            children: [
              IconButton(onPressed: (){
                Get.delete<UserStatusCheckController>();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
              }, icon: Icon(Icons.shopping_cart_rounded,color: hsPrime,size: 24)),
              IconButton(onPressed: (){
                Get.delete<UserStatusCheckController>();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationMenu()));
              }, icon: Icon(Icons.circle_notifications_rounded,color: hsPrime,size: 24)),
            ],
          )
        ],
      ),
    );
  }
}
