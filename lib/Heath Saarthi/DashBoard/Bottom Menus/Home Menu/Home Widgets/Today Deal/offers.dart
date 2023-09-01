//@dart=2.9
// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Enums/enums_status.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Home%20Widgets/Today%20Deal/today_deal_details.dart';
import 'package:provider/provider.dart';
import '../../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../../App Helper/Backend Helper/Providers/Home Menu Provider/home_menu_provider.dart';
import '../../../../../App Helper/Frontend Helper/Error Helper/internet_problem.dart';
import '../../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../Test List/test_list_items.dart';

class HomeOffers extends StatefulWidget {
  const HomeOffers({Key key}) : super(key: key);

  @override
  State<HomeOffers> createState() => _HomeOffersState();
}

class _HomeOffersState extends State<HomeOffers> {

  GetAccessToken getAccessToken = GetAccessToken();
  HomeMenusProvider homeMenusProvider = HomeMenusProvider();
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        homeMenusProvider.fetchTodayDeal(1, getAccessToken.access_token);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeMenusProvider>(
      create: (BuildContext context)=> homeMenusProvider,
      child: Consumer<HomeMenusProvider>(
        builder: (context, value, __){
          switch(value.todayDealList.status){
            case Status.loading:
              return const CenterLoading();
            case Status.error:
              print("offers status.error ->${value.todayDealList.message}----------");
              return value.todayDealList.message == 'Internet connection problem' ? CenterLoading() :Center(child: Text("${value.todayDealList.message}"));
            case Status.completed:
              return value.todayDealList.data.todayData.isEmpty ? Container() : Container(
                width: MediaQuery.of(context).size.width.w,
                height: MediaQuery.of(context).size.height / 7.4.h,
                color: Colors.grey.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Text("Today's Deal",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,letterSpacing: 0.5,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width.w,
                      height: MediaQuery.of(context).size.height / 11.h,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: value.todayDealList.data.todayData.length,
                        itemBuilder: (context, index){
                          var todayDeal = value.todayDealList.data.todayData[index];
                          return Padding(
                            padding: EdgeInsets.fromLTRB(5.w, 7.h, 5.w, 5.h),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>TodayDealDetails(
                                  dealId: todayDeal.id,
                                )));
                              },
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                color: Colors.white,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1.35.w,
                                  height: MediaQuery.of(context).size.height / 20.h,
                                  //padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          hsPrime.withOpacity(1),
                                          hsPrime.withOpacity(0.7),
                                        ],
                                      ),
                                      border: Border.all(color: hsPrime,width: 0.2)
                                    //color: Colors.white
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                        child: Container(
                                            child: const Image(
                                              image: AssetImage("assets/Home/discount.png"),
                                            )
                                        ),
                                      ),
                                      Expanded(child: Text("${todayDeal.title}",style: const TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 12,color: Colors.white),)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
