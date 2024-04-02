
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Custom%20Ui/show_box_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Packages%20List/package_items_getx.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Test%20List/test_item_getx.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../Packages List/package_list.dart';
import '../Test List/test_list_items.dart';
import 'attach_prescription.dart';
import 'instant_booking.dart';

class HomeTestPackage extends StatelessWidget {
  const HomeTestPackage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowBoxHelper(
      onTapForTest: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestDataNew()));
      },
      onTapForPackage: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const PackageDataNew()));
      },
      onTapForPrescription: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AttachPrescription()));
      },
      onTapForBooking: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const InstantBooking()));
      },
    );
  }
}
