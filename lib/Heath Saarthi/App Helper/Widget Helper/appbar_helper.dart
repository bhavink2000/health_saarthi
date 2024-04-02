import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../DashBoard/Add To Cart/test_cart.dart';
import '../../DashBoard/Notification Menu/notification_menu.dart';
import '../Backend Helper/Api Future/Data Future/data_future.dart';
import '../Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../Getx Helper/user_status_check.dart';

class AppBarHelper extends StatelessWidget {

  final controller = Get.find<DataFuture>();

  final String appBarLabel;
  AppBarHelper({super.key, required this.appBarLabel});

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
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                    controller.testSearch.clear();
                    controller.packageSearch.clear();
                    }, icon: const Icon(Icons.arrow_back,color: Colors.black,size: 24)),
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

class BottomBarHelper extends StatelessWidget {

  var count,amount;
  final GestureTapCallback? onTap;
  BottomBarHelper({super.key,this.count,this.amount,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 60,
      color: hsPrime,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
              child: Text(
                "Total Cart Items [ ${count} ]",
                style: const TextStyle(
                    fontFamily: FontType.MontserratRegular,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Padding(
                  padding:
                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    children: [
                      Text(
                        "\u{20B9}${amount}",
                        style: TextStyle(
                            fontFamily:
                            FontType.MontserratRegular,
                            color: hsPrime,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 15, color: hsPrime),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

