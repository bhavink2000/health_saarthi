// ignore_for_file: missing_return

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Widget%20Helper/appbar_helper.dart';
import 'package:provider/provider.dart';

import '../../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../../../App Helper/Backend Helper/Enums/enums_status.dart';
import '../../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../../App Helper/Backend Helper/Providers/Home Menu Provider/home_menu_provider.dart';
import '../../../../../App Helper/Frontend Helper/Error Helper/token_expired_helper.dart';
import '../../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';
import '../../../../../App Helper/Frontend Helper/Pagination Helper/custom_pagination_widget.dart';
import '../../../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../../../Add To Cart/test_cart.dart';
import '../../../../Notification Menu/notification_menu.dart';

class TodayDealDetails extends StatefulWidget {
  var dealId;
  TodayDealDetails({Key? key,this.dealId}) : super(key: key);

  @override
  State<TodayDealDetails> createState() => _TodayDealDetailsState();
}

class _TodayDealDetailsState extends State<TodayDealDetails> {

  //GetAccessToken getAccessToken = GetAccessToken();
  HomeMenusProvider homeMenusProvider = HomeMenusProvider();
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    //getAccessToken.checkAuthentication(context, setState);
    Map dealData = {
      'id': widget.dealId.toString(),
    };
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        homeMenusProvider.fetchTodayDealDetails(1,dealData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Map dealData = {
      'id': widget.dealId.toString(),
    };
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            AppBarHelper(appBarLabel: "Today's Deal"),
            Divider(color: Colors.grey.withOpacity(0.5),thickness: 1),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width.w,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: ChangeNotifierProvider<HomeMenusProvider>(
                  create: (BuildContext context) => homeMenusProvider,
                  child: Consumer<HomeMenusProvider>(
                    builder: (context, value, __){
                      switch(value.todayDealDetailsList.status!){
                        case Status.loading:
                          return const CenterLoading();
                        case Status.error:
                          return value.todayDealDetailsList.message == '402'
                              ? TokenExpiredHelper()
                              : value.todayDealDetailsList.message == 'Internet connection problem' ? CenterLoading() : value.todayDealDetailsList.data == []
                              ? Container()
                              : const Center(
                              child: Text(
                                  "Test Not found your branch",
                                  style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16
                                  ),textAlign: TextAlign.center
                              )
                          );
                        case Status.completed:
                          return value.todayDealDetailsList.data!.todayDetailsData!.data!.isNotEmpty
                           ? AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.todayDealDetailsList.data!.todayDetailsData!.data!.length,
                              itemBuilder: (context, index){
                                var todayDealI = value.todayDealDetailsList.data!.todayDetailsData!.data![index];
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: Column(
                                    children: [
                                      FadeInAnimation(
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            shadowColor: Colors.grey.withOpacity(0.8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(todayDealI.serviceName!,style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 15.sp)),
                                                      SizedBox(height: 5.h,),
                                                      Text(todayDealI.specimenVolume!,style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12.sp),)
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                                  child: Row(
                                                    children: [
                                                      Text("\u{20B9}${todayDealI.mrpAmount}",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18.sp,color: hsBlack)),
                                                      const Spacer(),
                                                      InkWell(
                                                        onTap: (){

                                                          if(todayDealI.bookedStatus == 1){
                                                            GetXSnackBarMsg.getWarningMsg('Already booked this item');
                                                          }
                                                          else{
                                                            CartFuture().addToCartTest(todayDealI.id).then((value) {
                                                              setState(() {
                                                                homeMenusProvider.fetchTodayDealDetails(curentindex + 1, dealData);
                                                              });
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                                              color: todayDealI.bookedStatus == 1 ? hsPrime.withOpacity(0.2): hsPrime
                                                          ),
                                                          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                                          child: Text(
                                                            todayDealI.bookedStatus == 1 ? "Booked" :"+ Book Now",
                                                            style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 13.sp,color: Colors.white),),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      if (value.todayDealDetailsList.data!.todayDetailsData!.data!.length == 10 || index + 1 != value.todayDealDetailsList.data!.todayDetailsData!.data!.length)
                                        Container()
                                      else
                                        SizedBox(height: MediaQuery.of(context).size.height / 1.55),

                                      index + 1 == value.todayDealDetailsList.data!.todayDetailsData!.data!.length ? CustomPaginationWidget(
                                        currentPage: curentindex,
                                        lastPage: homeMenusProvider.todayDealDetailsList.data!.todayDetailsData!.lastPage!,
                                        onPageChange: (page) {
                                          setState(() {
                                            curentindex = page - 1;
                                          });
                                          homeMenusProvider.fetchTodayDealDetails(curentindex + 1, dealData);
                                        },
                                      ) : Container(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                           : Center(child: Text("Deal is not available",style: TextStyle(fontFamily: FontType.MontserratRegular,fontWeight: FontWeight.bold),));
                      }
                    },
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
