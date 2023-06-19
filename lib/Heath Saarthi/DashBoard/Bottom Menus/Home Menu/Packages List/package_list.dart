//@dart=2.9
// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/login_error_helper.dart';
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
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        homeMenusProvider.fetchPackage(1, getAccessToken.access_token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      height: MediaQuery.of(context).size.height / 22.h,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(color: Colors.grey.withOpacity(1),width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(4))
                      ),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            border: InputBorder.none,
                            hintText: 'Search for Tests, Package',
                            hintStyle: const TextStyle(fontSize: 12,fontFamily: FontType.MontserratRegular),
                            prefixIcon: const Icon(Icons.search_rounded,size: 20),
                            focusColor: hsPrime
                        ),
                        onChanged: (value) {},
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
                          return const LoginErrorHelper();
                        case Status.completed:
                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width.w,
                                height: MediaQuery.of(context).size.height / 1.3.h,
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
                                                child: Card(
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                  shadowColor: Colors.grey.withOpacity(0.8),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: 10.h),
                                                      InkWell(
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
                                                          )));
                                                        },
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width / 1.2.w,
                                                            height: MediaQuery.of(context).size.height / 8.h,
                                                            padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  image: DecorationImage(
                                                                    image: AssetImage(
                                                                      "assets/health_saarthi_logo.png",
                                                                    ),fit: BoxFit.fill,
                                                                  )
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
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
                                                            )));
                                                          },
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(packageI.serviceName,style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18.sp,letterSpacing: 0.5,fontWeight: FontWeight.bold)),
                                                              SizedBox(height: 5.h,),
                                                              Text("${packageI.specimenVolume}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black54,fontSize: 12.sp),)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
                                                        child: Row(
                                                          children: [
                                                            Text("\u{20B9}${packageI.mrpAmount}",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18.sp,color: Colors.black,fontWeight: FontWeight.bold)),
                                                            const Spacer(),
                                                            InkWell(
                                                              onTap: (){
                                                                CartFuture().addToCartTest(getAccessToken.access_token, packageI.id, context).then((value) {
                                                                  homeMenusProvider.fetchPackage(1, getAccessToken.access_token);
                                                                  /*final response = value;
                                                                  final snackBar = SnackBar(
                                                                    backgroundColor: hsOne,
                                                                    content: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Expanded(child: Text("${response.message} (${response.count})", style: const TextStyle(color: Colors.white, fontFamily: FontType.MontserratRegular))),
                                                                        Row(
                                                                          children: [
                                                                            Text("\u{20B9}${response.amount}", style: const TextStyle(color: Colors.white, fontFamily: FontType.MontserratRegular)),
                                                                            SizedBox(width: 10.w),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const TestCart()));
                                                                              },
                                                                              child: Container(
                                                                                padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                                                                child: Icon(Icons.shopping_cart_rounded, color: hsOne),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: const Color(0xffe2791b)),
                                                                padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                                                child: Text("+ Book Now",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 13.sp,color: Colors.white),),
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

                                            if (value.packageList.data.packageData.data.length == 10 || index + 1 != value.packageList.data.packageData.data.length)
                                              Container()
                                            else
                                              SizedBox(height: MediaQuery.of(context).size.height / 4),

                                            index + 1 == value.packageList.data.packageData.data.length ? CustomPaginationWidget(
                                              currentPage: curentindex,
                                              lastPage: homeMenusProvider.packageList.data.packageData.lastPage,
                                              onPageChange: (page) {
                                                setState(() {
                                                  curentindex = page - 1;
                                                });
                                                homeMenusProvider.fetchPackage(curentindex + 1, getAccessToken.access_token);
                                              },
                                            ) : Container(),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 20.h,
                                color: hsPackageColor,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TestCart()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                                        child: Text(
                                          "Total Cart Items [ ${value.packageList.data.cartData.count} ]",
                                          style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                                        child: Text(
                                          "\u{20B9}${value.packageList.data.cartData.amount}",
                                          style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white,fontWeight: FontWeight.bold),
                                        ),
                                      )
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
