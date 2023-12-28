import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';

import '../../DashBoard/Bottom Menus/Home Menu/home_menu.dart';
import '../../DashBoard/Bottom Menus/Profile Menu/profile_menu.dart';
import '../../DashBoard/Bottom Menus/Report Menu/report_menu.dart';
import '../../DashBoard/Bottom Menus/Test Menu/test_menu_book_now.dart';
import '../Frontend Helper/UI Helper/app_icons_helper.dart';

bottomNavBar() {
  final controller = Get.put(BottomBarController());
  return Container(
    height: 65,
    margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: hsPrimeOne,
    ),
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(
          () => GestureDetector(
              onTap: () {
                controller.index.value = 0;
                log('index ==> ${controller.index.value}');
              },
              child: Container(
                width: 80,
                decoration: controller.index.value == 0
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10))
                    : const BoxDecoration(),
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: Column(
                  children: [
                    ImageIcon(AppIcons().HHome,
                        size: 25,
                        color: controller.index.value == 0
                            ? Colors.black
                            : Colors.white),
                    Text(
                      'Home',
                      style: TextStyle(
                          color: controller.index.value == 0
                              ? hsPrime
                              : Colors.white),
                    )
                  ],
                ),
              )),
        ),
        Obx(
          () => GestureDetector(
              onTap: () {
                controller.index.value = 1;
                log('index ==> ${controller.index.value}');
              },
              child: Container(
                width: 80,
                decoration: controller.index.value == 1
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10))
                    : const BoxDecoration(),
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    ImageIcon(AppIcons().HBookNow,
                        size: 25,
                        color: controller.index.value == 1
                            ? Colors.black
                            : Colors.white),
                    Text(
                      'Book Now',
                      style: TextStyle(
                          color: controller.index.value == 1
                              ? hsPrime
                              : Colors.white),
                    )
                  ],
                ),
              )),
        ),
        Obx(
          () => GestureDetector(
            onTap: () {
              controller.index.value = 2;
              log('index ==> ${controller.index.value}');
            },
            child: Container(
              width: 80,
              decoration: controller.index.value == 2
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10))
                  : const BoxDecoration(),
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  ImageIcon(AppIcons().HRecord,
                      size: 25,
                      color: controller.index.value == 2
                          ? Colors.black
                          : Colors.white),
                  Text(
                    'Record',
                    style: TextStyle(
                        color: controller.index.value == 2
                            ? hsPrime
                            : Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
        Obx(
          () => GestureDetector(
            onTap: () {
              controller.index.value = 3;
              log('index ==> ${controller.index.value}');
            },
            child: Container(
              width: 80,
              decoration: controller.index.value == 3
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10))
                  : const BoxDecoration(),
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  ImageIcon(AppIcons().HProfile,
                      size: 25,
                      color: controller.index.value == 3
                          ? Colors.black
                          : Colors.white),
                  Text(
                    'Profile',
                    style: TextStyle(
                        color: controller.index.value == 3
                            ? hsPrime
                            : Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class BottomBarController extends GetxController {
  RxInt index = 0.obs;

  List screens = [
    const HomeMenu(),
    const TestMenu(),
    const ReportMenu(),
    const ProfileMenu(),
  ];
}
