//@dart=2.9
// ignore_for_file: missing_return, use_build_context_synchronously

import 'dart:convert';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Cart%20Future/cart_future.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/cart_empty_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:provider/provider.dart';
import '../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../App Helper/Backend Helper/Enums/enums_status.dart';
import '../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Backend Helper/Models/Cart Menu/cart_calculation.dart';
import '../../App Helper/Backend Helper/Providers/Home Menu Provider/home_menu_provider.dart';
import '../../App Helper/Frontend Helper/Error Helper/login_error_helper.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../Bottom Menus/Home Menu/Packages List/package_list.dart';
import '../Bottom Menus/Home Menu/Test List/test_list_items.dart';
import 'test_form_booking.dart';

class TestCart extends StatefulWidget {
  const TestCart({Key key}) : super(key: key);

  @override
  State<TestCart> createState() => _TestCartState();
}

class _TestCartState extends State<TestCart> {

  final promoApply = TextEditingController();
  var grossAmount = '';
  var totalAmount = '';
  var netAmount = '';
  String testD;
  String packageD;
  String profileD;
  bool showPatient = false;
  List<FamilyMember> familyMembers = [];

  GetAccessToken getAccessToken = GetAccessToken();
  HomeMenusProvider homeMenusProvider = HomeMenusProvider();
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        print("calling fetchCart");
        homeMenusProvider.fetchCart(1, getAccessToken.access_token);
        print("called fetchCard");
      });
    });
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        cartCalculation();
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back,size: 30,)
                  ),
                  Text("Card Items",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18.sp,letterSpacing: 0.5),)
                ],
              ),
            ),
            Divider(color: hsTwo,thickness: 1),
            Expanded(
              child: ChangeNotifierProvider<HomeMenusProvider>(
                create: (BuildContext context) => homeMenusProvider,
                child: Consumer<HomeMenusProvider>(
                  builder: (context, value, __){
                    switch(value.cartList.status){
                      case Status.loading:
                        return const CenterLoading();
                      case Status.error:
                        print("error->${Status.error}");
                        return const LoginErrorHelper();
                      case Status.completed:
                        return SizedBox(
                          width: MediaQuery.of(context).size.width.w,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width.w,
                                height: MediaQuery.of(context).size.height / 1.45.h,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: hsTestColor.withOpacity(0.1)
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(15, 8, 10, 0),
                                                child: Row(
                                                  children: [
                                                    const Text("Tests",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,fontWeight: FontWeight.bold),),
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TestListItems()));
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsTestColor.withOpacity(0.8)),
                                                        child: const Text("+ Add",style: TextStyle(color: Colors.white,fontFamily: FontType.MontserratMedium,fontSize: 14),),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Divider(color: Colors.grey.withOpacity(0.5),),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width.w,
                                                height: MediaQuery.of(context).size.height / 4.5.h,
                                                child: value.cartList.data.data.cartItems.testItems.isNotEmpty
                                                    ? ListView.builder(
                                                  physics: const BouncingScrollPhysics(),
                                                  itemCount: value.cartList.data.data.cartItems.testItems.length,
                                                  itemBuilder: (context, tIndex){
                                                    var cartI = value.cartList.data.data.cartItems.testItems[tIndex];
                                                    return Padding(
                                                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(context).size.width / 1.5.w,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(cartI.testItemInfo.serviceName,style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 15)),
                                                                      Text("Amount :-  \u{20B9}${cartI.testItemInfo.mrpAmount}",style: const TextStyle(fontFamily: FontType.MontserratLight,fontSize: 12)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: (){
                                                                    CartFuture().removeToCartTest(getAccessToken.access_token, cartI.testItemInfo.id, context).then((value){
                                                                      /*final response = value;
                                                                      final snackBar = SnackBar(
                                                                        backgroundColor: hsTestColor,
                                                                        content: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Expanded(child: Text("${response.message} (${response.count})", style: const TextStyle(color: Colors.white, fontFamily: FontType.MontserratRegular,fontSize: 12))),
                                                                            Row(
                                                                              children: [
                                                                                Text("\u{20B9}${response.amount}", style: const TextStyle(color: Colors.white, fontFamily: FontType.MontserratRegular)),
                                                                                SizedBox(width: 10.w),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TestCart()));
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
                                                                  child: SizedBox(
                                                                    width: MediaQuery.of(context).size.width / 6.w,
                                                                    child: Icon(Icons.delete_forever_rounded,color: hsOne,size: 20),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Divider(color: Colors.white,)
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                                    : const CartEmptyHelper(),
                                              ),
                                              SizedBox(height: 5.h),
                                              Container(
                                                width: MediaQuery.of(context).size.width.w,
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.only(
                                                      bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)
                                                  ),
                                                  color: const Color(0xff396fff).withOpacity(0.8),
                                                ),
                                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                child: Row(
                                                  children: [
                                                    Text("Test Discount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                                                    const Spacer(),
                                                    Container(
                                                        width: MediaQuery.of(context).size.width / 3.5.w,
                                                        height: MediaQuery.of(context).size.height / 25.h,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15),
                                                          color: Colors.white,
                                                        ),
                                                        child: DropdownButtonFormField<String>(
                                                          value: testD,
                                                          style: const TextStyle(color: Colors.black,fontFamily: FontType.MontserratMedium),
                                                          dropdownColor: Colors.white,
                                                          decoration: InputDecoration(
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                            contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(color: Colors.white),
                                                                borderRadius: BorderRadius.circular(15)
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(color: Colors.white),
                                                                borderRadius: BorderRadius.circular(15)
                                                            ),
                                                            hintText: 'Discount',
                                                            hintStyle: TextStyle(
                                                              color: Colors.black,
                                                              fontFamily: FontType.MontserratRegular,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                          onChanged: (newValue) {
                                                            testD = newValue;
                                                            cartCalculation();
                                                          },
                                                          items: value.cartList.data.data.globalSettingTestSlot?.map((testDrop) => DropdownMenuItem<String>(
                                                            value: testDrop.id.toString() ?? '',
                                                            child: Text(testDrop.slotValue),
                                                          ))?.toList() ?? [],
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: hsPackageColor.withOpacity(0.1)
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(15, 8, 10, 0),
                                                child: Row(
                                                  children: [
                                                    //Container(width: 2, height: 18,color: hsTwo,),
                                                    //const SizedBox(width: 5),
                                                    const Text("Package",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,fontWeight: FontWeight.bold),),
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PackageListItems()));
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPackageColor.withOpacity(0.8)),
                                                        child: const Text("+ Add",style: TextStyle(color: Colors.white,fontFamily: FontType.MontserratMedium,fontSize: 14),),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Divider(color: Colors.grey.withOpacity(0.5),),
                                              Container(
                                                width: MediaQuery.of(context).size.width.w,
                                                height: MediaQuery.of(context).size.height / 5.h,
                                                child: value.cartList.data.data.cartItems.packageItems.isNotEmpty
                                                    ? ListView.builder(
                                                  physics: const BouncingScrollPhysics(),
                                                  itemCount: value.cartList.data.data.cartItems.packageItems.length,
                                                  itemBuilder: (context, pIndex){
                                                    var cartI = value.cartList.data.data.cartItems.packageItems[pIndex];
                                                    return Padding(
                                                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(context).size.width / 1.5.w,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(cartI.packageItemInfo.serviceName,style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 15)),
                                                                      Text("Amount :-  \u{20B9}${cartI.packageItemInfo.mrpAmount}",style: const TextStyle(fontFamily: FontType.MontserratLight,fontSize: 12)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: (){
                                                                    CartFuture().removeToCartTest(getAccessToken.access_token, cartI.packageItemInfo.id, context).then((value){
                                                                      /*final response = value;
                                                                      final snackBar = SnackBar(
                                                                        backgroundColor: hsPackageColor,
                                                                        content: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Expanded(child: Text("${response.message} (${response.count})", style: const TextStyle(color: Colors.white, fontFamily: FontType.MontserratRegular,fontSize: 12))),
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
                                                                  child: SizedBox(
                                                                    width: MediaQuery.of(context).size.width / 6.w,
                                                                    child: const Icon(Icons.delete_forever_rounded,color: Colors.black,size: 20),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Divider(color: Colors.white,)
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                                    : const CartEmptyHelper(),
                                              ),
                                              SizedBox(height: 5.h),
                                              Container(
                                                width: MediaQuery.of(context).size.width.w,
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.only(
                                                      bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)
                                                  ),
                                                  color: const Color(0xffe2791b).withOpacity(0.8),
                                                ),
                                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                child: Row(
                                                  children: [
                                                    Text("Package Discount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                                                    const Spacer(),
                                                    Container(
                                                        width: MediaQuery.of(context).size.width / 3.5.w,
                                                        height: MediaQuery.of(context).size.height / 25.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(15),
                                                            color: Colors.white
                                                        ),
                                                        child: DropdownButtonFormField<String>(
                                                          value: packageD,
                                                          style: const TextStyle(color: Colors.black,fontFamily: FontType.MontserratMedium),
                                                          dropdownColor: Colors.white,
                                                          decoration: InputDecoration(
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                            contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(color: Colors.white),
                                                                borderRadius: BorderRadius.circular(15)
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(color: Colors.white),
                                                                borderRadius: BorderRadius.circular(15)
                                                            ),
                                                            hintText: 'Discount',
                                                            hintStyle: TextStyle(
                                                              color: Colors.black,
                                                              fontFamily: FontType.MontserratRegular,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                          onChanged: (newValue) {
                                                            packageD = newValue;
                                                            cartCalculation();
                                                          },
                                                          items: value.cartList.data.data.globalSettingPackageSlot?.map((packageDrop) => DropdownMenuItem<String>(
                                                            value: packageDrop.id.toString() ?? '',
                                                            child: Text(packageDrop.slotValue),
                                                          ))?.toList() ?? [],
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      value.cartList.data.data.cartItems.profileItems.isNotEmpty ? Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: hsInstantBookingColor.withOpacity(0.1)
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(15, 8, 10, 0),
                                                child: Row(
                                                  children: [
                                                    //Container(width: 2, height: 18,color: hsTwo,),
                                                    //const SizedBox(width: 5),
                                                    const Text("Profile",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,fontWeight: FontWeight.bold),),
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PackageListItems()));
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsInstantBookingColor.withOpacity(0.8)),
                                                        child: const Text("+ Add",style: TextStyle(color: Colors.white,fontFamily: FontType.MontserratMedium,fontSize: 14),),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Divider(color: Colors.grey.withOpacity(0.5),),
                                              Container(
                                                width: MediaQuery.of(context).size.width.w,
                                                height: MediaQuery.of(context).size.height / 5.h,
                                                child: value.cartList.data.data.cartItems.profileItems.isNotEmpty
                                                    ? ListView.builder(
                                                  physics: const BouncingScrollPhysics(),
                                                  itemCount: value.cartList.data.data.cartItems.profileItems.length,
                                                  itemBuilder: (context, pIndex){
                                                    var cartI = value.cartList.data.data.cartItems.profileItems[pIndex];
                                                    return Padding(
                                                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(context).size.width / 1.5.w,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(cartI.profileItemInfo.serviceName,style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 15)),
                                                                      Text("Amount :-  \u{20B9}${cartI.profileItemInfo.mrpAmount}",style: const TextStyle(fontFamily: FontType.MontserratLight,fontSize: 12)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: (){
                                                                    CartFuture().removeToCartTest(getAccessToken.access_token, cartI.profileItemInfo.id, context).then((value){
                                                                      /*final response = value;
                                                                      final snackBar = SnackBar(
                                                                        backgroundColor: hsPackageColor,
                                                                        content: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Expanded(child: Text("${response.message} (${response.count})", style: const TextStyle(color: Colors.white, fontFamily: FontType.MontserratRegular,fontSize: 12))),
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
                                                                  child: SizedBox(
                                                                    width: MediaQuery.of(context).size.width / 6.w,
                                                                    child: const Icon(Icons.delete_forever_rounded,color: Colors.black,size: 20),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Divider(color: Colors.white,)
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                                    : const CartEmptyHelper(),
                                              ),
                                              SizedBox(height: 5.h),
                                              Container(
                                                width: MediaQuery.of(context).size.width.w,
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.only(
                                                      bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)
                                                  ),
                                                  color: hsInstantBookingColor.withOpacity(0.8),
                                                ),
                                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                child: Row(
                                                  children: [
                                                    Text("Profile Discount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                                                    const Spacer(),
                                                    Container(
                                                        width: MediaQuery.of(context).size.width / 3.5.w,
                                                        height: MediaQuery.of(context).size.height / 25.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(15),
                                                            color: Colors.white
                                                        ),
                                                        child: DropdownButtonFormField<String>(
                                                          value: profileD,
                                                          style: const TextStyle(color: Colors.black,fontFamily: FontType.MontserratMedium),
                                                          dropdownColor: Colors.white,
                                                          decoration: InputDecoration(
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                                            contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(color: Colors.white),
                                                                borderRadius: BorderRadius.circular(15)
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(color: Colors.white),
                                                                borderRadius: BorderRadius.circular(15)
                                                            ),
                                                            hintText: 'Discount',
                                                            hintStyle: TextStyle(
                                                              color: Colors.black,
                                                              fontFamily: FontType.MontserratRegular,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                          onChanged: (newValue) {
                                                            profileD = newValue;
                                                            cartCalculation();
                                                          },
                                                          items: value.cartList.data.data.globalSettingProfileSlot?.map((packageDrop) => DropdownMenuItem<String>(
                                                            value: packageDrop.id.toString() ?? '',
                                                            child: Text(packageDrop.slotValue),
                                                          ))?.toList() ?? [],
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ) : Container(),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width.w,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(0),topLeft: Radius.circular(0)
                                  ),color: hsPrime,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.fromLTRB(15, 5, 10, 0),
                                      child: Row(
                                        children: [
                                          Text("Gross Amount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white),),
                                          const Spacer(),
                                          Container(
                                            alignment: Alignment.centerRight,
                                              width: MediaQuery.of(context).size.width / 3.w,
                                              height: MediaQuery.of(context).size.height / 25.h,
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                              child: Text("\u{20B9}$grossAmount",style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontFamily: FontType.MontserratRegular,
                                                  fontSize: 14
                                              )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.fromLTRB(15, 5, 10, 0),
                                      child: Row(
                                        children: [
                                          Text("Total Discount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white),),
                                          const Spacer(),
                                          Container(
                                            alignment: Alignment.centerRight,
                                              width: MediaQuery.of(context).size.width / 3.w,
                                              height: MediaQuery.of(context).size.height / 25.h,
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                              child: Text("$totalAmount",style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontFamily: FontType.MontserratRegular,
                                                  fontSize: 14
                                              )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Text("Prome Offer",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white),),
                                          const Spacer(),
                                          SizedBox(
                                              width: MediaQuery.of(context).size.width / 2.w,
                                              height: MediaQuery.of(context).size.height / 25.h,
                                              child: TextField(
                                                controller: promoApply,
                                                style: const TextStyle(color: Colors.white,fontFamily: FontType.MontserratMedium),
                                                textAlign: TextAlign.right,
                                                decoration: InputDecoration(
                                                  contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Colors.white),
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Colors.white),
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  hintText: 'Coupon Code',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.white70,
                                                      fontFamily: FontType.MontserratRegular,
                                                      fontSize: 14
                                                  ),
                                                  //prefixIcon: Icon(iconData, color: hsBlack,size: 20),
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width.w,
                                      height: MediaQuery.of(context).size.height / 18.sp,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),color: Colors.white),
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                                            child: Container(
                                              child: Text("\u{20B9}$netAmount",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.green,fontSize: 16.sp,fontWeight: FontWeight.bold),),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 4, 10, 0),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TestBookingScreen(
                                                  testDis: testD,
                                                  packageDis: packageD,
                                                  profileDis: profileD,
                                                  promoApply: promoApply.text,
                                                )));
                                              },
                                              child: Container(
                                                  width: MediaQuery.of(context).size.width / 2.9.w,
                                                  padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.green),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Book Now",
                                                        style: TextStyle(
                                                            fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      SizedBox(width: 5.w,),
                                                      const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size: 12,)
                                                    ],
                                                  )
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<CartCalculationModel> cartCalculation() async {
    print("calling cart cal");
    print("testDisId ->$testD / packageDisId ->$packageD / profileDisId ->$profileD / promo ->${promoApply.text}");
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    try {
      final response = await http.post(
          Uri.parse(ApiUrls.cartCalculationUrls),
          headers: headers,
          body: {
            'test_discount_id': testD?.toString() ?? '',
            'package_discount_id': packageD?.toString() ?? '',
            'profile_discount_id': profileD?.toString() ?? '',
            'promo_offer_code': promoApply?.text ?? ''
          }
      );
      final responseData = json.decode(response.body);
      var bodyStatus = responseData['status'];

      if (bodyStatus == 200) {
        setState(() {
          var isApplyPromo = responseData['data']['isApplyPromo'];
          var applyPromo = responseData['data']['applyPromo'];
          netAmount = responseData['data']['netAmount'].toString();
          grossAmount = responseData['data']['grossAmount'].toString();
          totalAmount = responseData['data']['discountAmount'].toString();
        });
        print("netA ->$netAmount / grossA ->$grossAmount / totalA ->$totalAmount");
      } else {
        //SnackBarMessageShow.warningMSG('Discount Not Apply', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }
}
class FamilyMember {
  String name;

  FamilyMember({this.name});
}