// ignore_for_file: import_of_legacy_library_into_null_safe, use_build_context_synchronously

import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Data%20Future/home_data_future.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Profile%20Future/profile_future.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Dashboard%20Model/profile_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Dialog%20Helper/account_status.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Home%20Widgets/body_checkups.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Home%20Widgets/image_slider.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Home%20Widgets/Today%20Deal/offers.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Home%20Widgets/test_package.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App Helper/Backend Helper/Api Future/Data Future/data_future.dart';
import '../../../App Helper/Backend Helper/Device Info/device_info.dart';
import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../Global Search Screen/global_search_screen.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {

  final controller = Get.put(DataFuture(),permanent: true);
  final homeController = Get.put(HomeDataFuture());

  var userStatus;
  var deviceToken;

  @override
  void initState() {
    super.initState();
    getUserStatus();
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
                            delegate: GlobalSearch()
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const HomeImageSlider(),
              const HomeTestPackage(),
              const HomeOffers(),
              const HomeBodyCheckups(),
            ],
          ),
        ),
      ),
    );
  }


  final box = GetStorage();
  Future<void> getUserStatus()async{
    try{
      ProfileModel profileModel = await ProfileFuture().fetchProfile();
      if (profileModel != null && profileModel.data != null) {
        setState(() {
          userStatus = profileModel.data?.status;
          box.write('vendorNm', profileModel.data?.vendorName?.toString() ?? 'N/A');
          box.write('name', profileModel.data?.name?.toString() ?? 'N/A');
          box.write('mobile', profileModel.data?.mobile?.toString() ?? 'N/A');
          box.write('email', profileModel.data?.emailId?.toString() ?? 'N/A');
          box.write('address', profileModel.data?.address?.toString() ?? 'N/A');
          box.write('stateNm', profileModel.data?.state?.stateName?.toString() ?? 'N/A');
          box.write('cityNm', profileModel.data?.city?.cityName?.toString() ?? 'N/A');
          box.write('areaNm', profileModel.data?.area?.areaName?.toString() ?? 'N/A');
          box.write('branchNm', profileModel.data?.costCenter?.branchName?.toString() ?? 'N/A');
          box.write('pincode', profileModel.data?.pincode?.toString() ?? 'N/A');
          box.write('bankNm', profileModel.data?.bankName?.toString() ?? 'N/A');
          box.write('ifsc', profileModel.data?.ifsc?.toString() ?? 'N/A');
          box.write('accountNo', profileModel.data?.accountNumber?.toString() ?? 'N/A');
          box.write('gstNo', profileModel.data?.gstNumber?.toString() ?? 'N/A');
          box.write('pancard', profileModel.data?.pancard?.toString() ?? 'N/A');
          box.write('addressProof', profileModel.data?.addressProof?.toString() ?? 'N/A');
          box.write('aadhaarF', profileModel.data?.aadharFront?.toString() ?? 'N/A');
          box.write('aadhaarB', profileModel.data?.aadharBack?.toString() ?? 'N/A');
          box.write('chequeImage', profileModel.data?.chequeImage?.toString() ?? 'N/A');
          box.write('gstImage', profileModel.data?.gstImage?.toString() ?? 'N/A');
          box.write('pancardImg', profileModel.data?.pancardImg?.toString() ?? 'N/A');
          box.write('addressImg', profileModel.data?.addressProofImg?.toString() ?? 'N/A');
          box.write('aadhaarFImg', profileModel.data?.aadharFrontImg?.toString() ?? 'N/A');
          box.write('aadhaarBImg', profileModel.data?.aadharBackImg?.toString() ?? 'N/A');
          box.write('chequeImg', profileModel.data?.chequeImg?.toString() ?? 'N/A');
          box.write('gstImg', profileModel.data?.gstImg?.toString() ?? 'N/A');
        });
        if (userStatus == 0) {
          AccountStatus().accountStatus(context);
        }
      }
    }
    catch(e){
      print("get User Status Error->$e");
      if (e.toString().contains('402')) {
        DeviceInfo().logoutUser();
      }
    }
  }

}