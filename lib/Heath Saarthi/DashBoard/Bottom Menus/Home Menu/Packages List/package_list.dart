//@dart=2.9
// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/login_error_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/token_expired_helper.dart';
import 'package:provider/provider.dart';
import '../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../../App Helper/Backend Helper/Enums/enums_status.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Backend Helper/Providers/Home Menu Provider/home_menu_provider.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';
import '../../../../App Helper/Frontend Helper/Pagination Helper/custom_pagination_widget.dart';
import '../../../../App Helper/Frontend Helper/package_model.dart';
import '../../../Add To Cart/test_cart.dart';
import '../../../Notification Menu/notification_menu.dart';
import 'package_list_details.dart';

class PackageListItems extends StatefulWidget {
  const PackageListItems({Key key}) : super(key: key);

  @override
  State<PackageListItems> createState() => _PackageListItemsState();
}

class _PackageListItemsState extends State<PackageListItems> {

  GetAccessToken getAccessToken = GetAccessToken();
  HomeMenusProvider homeMenusProvider = HomeMenusProvider();
  int curentindex = 0;
  final packageSearch = TextEditingController();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        homeMenusProvider.fetchPackage(1, getAccessToken.access_token,'');
      });
    });
  }

  bool packageBook = false;
  @override
  Widget build(BuildContext context) {
    Map packageData = {
      'search': packageSearch.text,
    };
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset:  false,
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            InkWell(onTap: (){Navigator.pop(context);}, child: const Icon(Icons.arrow_back,color: Colors.black,size: 24)),
                            SizedBox(width: 10.w),
                            const Text("Package Items",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.black,fontSize: 14),)
                          ],
                        )
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestBookingDetails()));
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                            },child: Icon(Icons.shopping_cart_rounded,color: hsPackageColor,size: 24)
                          ),
                          SizedBox(width: 10.w),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationMenu()));
                            },child: Icon(Icons.circle_notifications_rounded,color: hsPackageColor,size: 30)
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(color: Colors.grey.withOpacity(0.5),thickness: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 19.h,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(color: Colors.grey.withOpacity(1),width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(4))
                      ),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: TextFormField(
                        controller: packageSearch,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            border: InputBorder.none,
                            hintText: 'Search for Tests, Package',
                            hintStyle: const TextStyle(fontSize: 12,fontFamily: FontType.MontserratRegular),
                            suffixIcon: InkWell(
                                onTap: (){
                                  setState(() {
                                    packageSearch.clear();
                                  });
                                  Map packageData = {
                                    'search': '',
                                  };
                                  homeMenusProvider.fetchPackage(1, getAccessToken.access_token,packageData);
                                },
                                child: const Icon(Icons.close)
                            ),
                            focusColor: hsPrime
                        ),
                        onChanged: (value) {
                          Map packageData = {
                            'search': packageSearch.text,
                          };
                          homeMenusProvider.fetchPackage(1, getAccessToken.access_token,packageData);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width.w,
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: ChangeNotifierProvider<HomeMenusProvider>(
                  create: (BuildContext context) => homeMenusProvider,
                  child: Consumer<HomeMenusProvider>(
                    builder: (context, value, __){
                      switch(value.packageList.status){
                        case Status.loading:
                          return const CenterLoading();
                        case Status.error:
                          print("${value.testList.message}-----------------");
                          return value.packageList.message == 'Token is Expired'
                              ? TokenExpiredHelper(tokenMsg: "${value.packageList.message}")
                              : value.packageList.data == []
                              ? Container()
                              : Center(
                              child: Text(
                                  "Package Not found your branch",
                                  style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16
                                  ),textAlign: TextAlign.center
                              )
                          );
                        case Status.completed:
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width.w,
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                                  child: AnimationLimiter(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: value.packageList.data.packageData.data.length,
                                      itemBuilder: (context, index){
                                        var packageI = value.packageList.data.packageData.data[index];
                                        return AnimationConfiguration.staggeredList(
                                          position: index,
                                          duration: const Duration(milliseconds: 1000),
                                          child: Column(
                                            children: [
                                              FadeInAnimation(
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                  child: InkWell(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PackageItemsDetails(
                                                        title: packageI.serviceName,
                                                        mrp: packageI.mrpAmount,
                                                        serviceCode: packageI.serviceCode,
                                                        collect: packageI.collect,
                                                        serviceClassification: packageI.serviceClassification,
                                                        serviceVolume: packageI.specimenVolume,
                                                        orderingInfo: packageI.orderingInfo,
                                                        reported: packageI.reported,
                                                        state: packageI.state.stateName,
                                                        city: packageI.city.cityName,
                                                        area: packageI.area.areaName,
                                                        accessToken: getAccessToken.access_token,
                                                        packageId: packageI.id,
                                                        bookedStatus: packageI.bookedStatus,
                                                      )));
                                                    },
                                                    child: Card(
                                                      elevation: 5,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                      shadowColor: Colors.grey.withOpacity(0.8),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(context).size.width.w,
                                                            decoration: BoxDecoration(
                                                              borderRadius: const BorderRadius.only(
                                                                  topLeft: Radius.circular(10),topRight: Radius.circular(10)
                                                              ),
                                                              color: hsPackageColor.withOpacity(0.5),
                                                            ),
                                                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                            child: Text(
                                                                packageI.serviceName,
                                                                style: TextStyle(
                                                                    fontFamily: FontType.MontserratMedium,
                                                                    fontSize: 15.sp,color: Colors.white
                                                                )
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                    width: MediaQuery.of(context).size.width / 1.5.w,
                                                                    child: Text("${packageI.specimenVolume}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12.sp),)),
                                                                Row(
                                                                  children: [
                                                                    Text("\u{20B9}${packageI.mrpAmount}",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18.sp,color: hsBlack)),
                                                                    const Spacer(),
                                                                    InkWell(
                                                                      onTap: (){
                                                                        CartFuture().addToCartTest(getAccessToken.access_token, packageI.id, context).then((value) {
                                                                          homeMenusProvider.fetchPackage(1, getAccessToken.access_token,packageData);
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(borderRadius: const BorderRadius.only(
                                                                            bottomRight: Radius.circular(10),topLeft: Radius.circular(10)
                                                                        ),color: hsPackageColor.withOpacity(0.9)),
                                                                        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                                                        child: Text(packageI.bookedStatus == 1 ? "Booked" :"+ Book Now",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 13.sp,color: Colors.white),),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              if (value.packageList.data.packageData.data.length == 10 || index + 1 != value.packageList.data.packageData.data.length)
                                                Container()
                                              else
                                                SizedBox(height: MediaQuery.of(context).size.height / 2.8),

                                              index + 1 == value.packageList.data.packageData.data.length ? CustomPaginationWidget(
                                                currentPage: curentindex,
                                                lastPage: homeMenusProvider.packageList.data.packageData.lastPage,
                                                onPageChange: (page) {
                                                  setState(() {
                                                    curentindex = page - 1;
                                                  });
                                                  homeMenusProvider.fetchPackage(curentindex + 1, getAccessToken.access_token, packageData);
                                                },
                                              ) : Container(),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 12.h,
                                color: hsPackageColor,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                                        child: Text(
                                          "Total Cart Items [ ${value.packageList.data.cartData.count} ]",
                                          style: const TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
                                        child: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "\u{20B9}${value.packageList.data.cartData.amount}",
                                                  style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsPackageColor,fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(width: 5.w),
                                                Icon(Icons.arrow_forward_ios_rounded,size: 15,color: hsPackageColor,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
