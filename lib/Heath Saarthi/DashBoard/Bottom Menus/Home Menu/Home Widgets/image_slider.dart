// ignore_for_file: missing_return

import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Data%20Future/home_data_future.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Enums/enums_status.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/token_expired_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Test%20List/test_item_getx.dart';
import 'package:provider/provider.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Backend Helper/Providers/Home Menu Provider/home_menu_provider.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../../App Helper/Frontend Helper/Loading Helper/shimmer_loading.dart';
import '../Test List/test_list_items.dart';

class HomeImageSlider extends StatefulWidget {
  const HomeImageSlider({Key? key}) : super(key: key);

  @override
  State<HomeImageSlider> createState() => _HomeImageSliderState();
}

class _HomeImageSliderState extends State<HomeImageSlider> {

  final controller = Get.find<HomeDataFuture>();

  @override
  void initState() {
    super.initState();
    controller.fetchBanner();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.bannerLoad.value
        ? ShimmerHelper(
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: Get.width,
          height: 180,
          decoration:
          BoxDecoration(color: hsPrime.withOpacity(0.5)),
        ))
        : controller.bannerModel.value.data!.isEmpty
        ? Container()
        : Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration:
            const Duration(milliseconds: 2000),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.1,
            height: 180,
            scrollDirection: Axis.horizontal,
          ),
          itemCount: controller.bannerModel.value.data!.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            var bannerI = controller.bannerModel.value.data![itemIndex];
            return SizedBox(
              width: Get.width,
              // height: 100,
              child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TestDataNew()));
                  },
                  child: Image(
                    image: NetworkImage(bannerI.image!),
                    fit: BoxFit.fill,
                  )),
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    ));
    // return ChangeNotifierProvider<HomeMenusProvider>(
    //   create: (BuildContext context)=>homeMenusProvider,
    //   child: Consumer<HomeMenusProvider>(
    //     builder: (context, value, __){
    //       switch(value.bannerList.status!){
    //         case Status.loading:
    //           return const CenterLoading();
    //         case Status.error:
    //           log('image banner --->>>${value.bannerList.message}');
    //           return value.bannerList.message == 'Internet connection problem' ? Container() : value.bannerList.message == '402' ? TokenExpiredHelper() : Container();
    //         case Status.completed:
    //           return value.bannerList.data!.data!.isEmpty ? Container() : Container(
    //             width: MediaQuery.of(context).size.width.w,
    //             height: MediaQuery.of(context).size.height / 6.h,
    //             child: value.bannerList.data!.data!.isEmpty
    //               ? const Center(child: Text("No Banner Available",style: TextStyle(fontFamily: FontType.MontserratMedium),),)
    //               : CarouselSlider.builder(
    //                 options: CarouselOptions(
    //                 viewportFraction: 0.8,
    //                 initialPage: 0,
    //                 enableInfiniteScroll: true,
    //                 reverse: false,
    //                 autoPlay: true,
    //                 autoPlayInterval: const Duration(seconds: 3),
    //                 autoPlayAnimationDuration: const Duration(milliseconds: 2000),
    //                 autoPlayCurve: Curves.fastOutSlowIn,
    //                 enlargeCenterPage: true,
    //                 enlargeFactor: 0.1,
    //                 scrollDirection: Axis.horizontal,
    //               ),
    //               itemCount: value.bannerList.data!.data!.length,
    //               itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
    //                 var bannerI = value.bannerList.data!.data![itemIndex];
    //                 return Container(
    //                   width: MediaQuery.of(context).size.width.w,
    //                   height: MediaQuery.of(context).size.height / 7.h,
    //                   child: InkWell(
    //                       onTap: (){
    //                         Navigator.push(context, MaterialPageRoute(builder: (context)=>TestDataNew()));
    //                       },
    //                       child: Image(image: NetworkImage(bannerI.image!),fit: BoxFit.fill,)),
    //                 );
    //               },
    //             ),
    //           );
    //       }
    //     },
    //   ),
    // );
  }
}
