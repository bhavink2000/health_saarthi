//@dart=2.9
// ignore_for_file: prefer_typing_uninitialized_variables, missing_return, use_build_context_synchronously

import 'dart:convert';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Cart%20Future/cart_future.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/login_error_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Enums/enums_status.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Providers/Home%20Menu%20Provider/home_menu_provider.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Notification%20Menu/notification_menu.dart';
import 'package:provider/provider.dart';
import '../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_response_model.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../../App Helper/Frontend Helper/Pagination Helper/custom_pagination_widget.dart';
import '../../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../../Add To Cart/test_cart.dart';
import 'test_list_item_details.dart';

class TestListItems extends StatefulWidget {
  TestListItems({Key key}) : super(key: key);

  @override
  State<TestListItems> createState() => _TestListItemsState();
}

class _TestListItemsState extends State<TestListItems> {

  GetAccessToken getAccessToken = GetAccessToken();
  HomeMenusProvider homeMenusProvider = HomeMenusProvider();
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        homeMenusProvider.fetchTest(1, getAccessToken.access_token);
      });
    });
  }

  var testCartAmount = 0;
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
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Row(
                            children: [
                              IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back,color: Colors.black,size: 24)),
                              SizedBox(width: 10.w),
                              Text("Test Items",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.bold),)
                            ],
                          )
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                          }, icon: const Icon(Icons.shopping_cart_outlined,color: Color(0xff396fff),size: 24)),
                          /*InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                              },child: Icon(Icons.shopping_cart_outlined,color: Color(0xff396fff),size: 24)
                          ),*/
                          //SizedBox(width: 10.w),
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationMenu()));
                          }, icon: const Icon(Icons.circle_notifications_rounded,color: Color(0xff396fff),size: 24)),
                          /*InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationMenu()));
                              },child: Icon(Icons.circle_notifications_rounded,color: Color(0xff396fff),size: 24)
                          ),*/
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
                      switch(value.testList.status){
                        case Status.loading:
                          return const CenterLoading();
                        case Status.error:
                          bool showError = false;
                          if (value.testList.message == "type 'String' is not a subtype of type 'int?'") {
                              showError = true;
                          }
                          return showError == true ? const LoginErrorHelper() : Center(child: Text(value.testList.message));
                        case Status.completed:
                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width.w,
                                height: MediaQuery.of(context).size.height / 1.3.h,
                                child: AnimationLimiter(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: value.testList.data.testData.data.length,
                                      itemBuilder: (context, index){
                                        var testI = value.testList.data.testData.data[index];
                                        return AnimationConfiguration.staggeredList(
                                          position: index,
                                          duration: const Duration(milliseconds: 1000),
                                          child: Column(
                                            children: [
                                              FadeInAnimation(
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                  child: InkWell(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TestItemDetails(
                                                        title: testI.serviceName,
                                                        mrp: testI.mrpAmount,
                                                        serviceCode: testI.serviceCode,
                                                        collect: testI.collect,
                                                        serviceClassification: testI.serviceClassification,
                                                        serviceVolume: testI.specimenVolume,
                                                        orderingInfo: testI.orderingInfo,
                                                        reported: testI.reported,
                                                        state: testI.state.stateName,
                                                        city: testI.city.cityName,
                                                        area: testI.area.areaName,
                                                        accessToken: getAccessToken.access_token,
                                                        testId: testI.id,
                                                      )));
                                                    },
                                                    child: Card(
                                                      elevation: 5,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                      shadowColor: Colors.grey.withOpacity(0.5),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(context).size.width.w,
                                                            decoration: BoxDecoration(
                                                              borderRadius: const BorderRadius.only(
                                                                  topLeft: Radius.circular(10),topRight: Radius.circular(10)
                                                              ),
                                                              color: const Color(0xff396fff).withOpacity(0.5),
                                                            ),
                                                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                            child: Text(
                                                                testI.serviceName,
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
                                                                //Divider(color: hsOne,thickness: 1),
                                                                Container(
                                                                    width: MediaQuery.of(context).size.width / 1.5.w,
                                                                    child: Text("${testI.specimenVolume}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12.sp),)),
                                                                Row(
                                                                  children: [
                                                                    Text("\u{20B9}${testI.mrpAmount}",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18.sp,color: hsBlack)),
                                                                    const Spacer(),
                                                                    InkWell(
                                                                      onTap: (){
                                                                        CartFuture().addToCartTest(getAccessToken.access_token, testI.id, context).then((value) {
                                                                          /*final response = value;
                                                                          final snackBar = SnackBar(
                                                                            backgroundColor: hsTestColor,
                                                                            content: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Expanded(child: Text("${response.message} (${response.count == null ? 0 : response.count})", style: const TextStyle(color: Colors.white, fontFamily: FontType.MontserratRegular))),
                                                                                Row(
                                                                                  children: [
                                                                                    Text("\u{20B9}${response.amount == null ? 0.00 : response.amount}", style: const TextStyle(color: Colors.white, fontFamily: FontType.MontserratRegular)),
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
                                                                          homeMenusProvider.fetchTest(1, getAccessToken.access_token);
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(borderRadius: const BorderRadius.only(
                                                                            bottomRight: Radius.circular(10),topLeft: Radius.circular(10)
                                                                        ),color: hsTestColor.withOpacity(0.8)),
                                                                        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                                                        child: Text("+ Book Now",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 13.sp,color: Colors.white),),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              if (value.testList.data.testData.data.length == 10 || index + 1 != value.testList.data.testData.data.length)
                                                Container()
                                              else
                                                SizedBox(height: MediaQuery.of(context).size.height / 4),

                                              index + 1 == value.testList.data.testData.data.length ? CustomPaginationWidget(
                                                currentPage: curentindex,
                                                lastPage: homeMenusProvider.testList.data.testData.lastPage,
                                                onPageChange: (page) {
                                                  setState(() {
                                                    curentindex = page - 1;
                                                  });
                                                  homeMenusProvider.fetchTest(curentindex + 1, getAccessToken.access_token);
                                                },
                                              ) : Container(),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 20.h,
                                color: hsTestColor,
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
                                            "Total Cart Items [ ${value.testList.data.cartData.count} ]",
                                          style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                                        child: Text(
                                            "\u{20B9}${value.testList.data.cartData.amount}",
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

  //var bodyMsg;
  /*Future<void> addToCartTest(var testId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.addItemsUrls),
        headers: headers,
        body: {
          'test_managements_id': testId.toString()
        }
      );
      final responseData = json.decode(response.body);

      var bodyStatus = responseData['status'];
      bodyMsg = responseData['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMsg', context);
      } else {
        SnackBarMessageShow.errorMSG('$bodyMsg', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }*/
}
