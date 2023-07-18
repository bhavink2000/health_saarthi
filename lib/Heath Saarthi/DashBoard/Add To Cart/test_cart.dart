//@dart=2.9
// ignore_for_file: missing_return, use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Cart%20Future/cart_future.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/cart_empty_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/token_expired_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../App Helper/Backend Helper/Api Future/Profile Future/profile_future.dart';
import '../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../App Helper/Backend Helper/Enums/enums_status.dart';
import '../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Backend Helper/Models/Authentication Models/user_model.dart';
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
  bool callPromo = false;
  var isApplyPromo;
  var applyPromo;
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
    getUserData();
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        homeMenusProvider.fetchCart(1, getAccessToken.access_token, context);
      });
    });
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        cartCalculation();
      });
    });
  }
  var userStatus;
  void getUserData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedEmail = prefs.getString('email');
    String storedPassword = prefs.getString('password');
    print("store E->$storedEmail");
    print("store P->$storedPassword");
    getUser(storedEmail, storedPassword);
  }
  void getUser(String sEmail, String sPassword) async {
    try {
      UserModel user = await ProfileFuture().fetchUser(sEmail, sPassword);
      if (user != null && user.data != null) {
        print("user Status -->> ${user.data.status}");
        setState(() {
          userStatus = user.data.status;
        });
      } else {
        print('Failed to fetch user: User data is null');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width.w,
        height: MediaQuery.of(context).size.height / 3.8.h,
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
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Row(
                children: [
                  Text("Gross amount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white),),
                  const Spacer(),
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width / 3.w,
                    height: MediaQuery.of(context).size.height / 25.h,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Text("\u{20B9}${grossAmount.isEmpty ? 0 : grossAmount}",style: const TextStyle(
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
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Row(
                children: [
                  Text("Total discount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white),),
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
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 5),
              alignment: Alignment.topLeft,
              child: callPromo == true ? Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5.w,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Row(
                          children: [
                            const Text(
                                "Promo offer applied",
                                style: TextStyle(
                                    fontFamily: FontType.MontserratRegular,fontWeight: FontWeight.bold,color: Colors.green)
                            ),
                            const Spacer(),
                            Text("\u{20B9}$applyPromo",style: const TextStyle(fontFamily: FontType.MontserratMedium),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: (){
                      promoApply.clear();
                      _showLoadingDialog();
                      cartCalculation().then((_) {
                        setState(() {
                          callPromo = false;
                        });
                        Navigator.of(context).pop(); // Hide the loading dialog
                      });
                    },
                    child: Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsPrime),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  )
                ],
              ): Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5.w,
                    height: MediaQuery.of(context).size.height / 20.h,
                    child: TextField(
                      controller: promoApply,
                      style: const TextStyle(color: Colors.white,fontFamily: FontType.MontserratMedium),
                      textAlign: TextAlign.left,
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
                        hintText: 'Coupon code',
                        hintStyle: const TextStyle(
                            color: Colors.white,
                            fontFamily: FontType.MontserratMedium,
                            fontSize: 14
                        ),
                        //prefixIcon: Icon(iconData, color: hsBlack,size: 20),
                      ),
                      onEditingComplete: (){
                        setState(() {
                          callPromo = true;
                        });
                        cartCalculation();
                      },
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: (){
                      if(promoApply.text.isEmpty){
                        SnackBarMessageShow.warningMSG('Please enter coupe code', context);
                      }
                      else{
                        _showLoadingDialog();
                        cartCalculation().then((_) {
                          setState(() {
                            callPromo = true;
                          });
                          Navigator.of(context).pop();
                          promoApply.clear();
                        });
                      }
                    },
                    child: Text("Apply",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsPrime),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width.w,
              height: MediaQuery.of(context).size.height / 14.sp,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),color: Colors.white),
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                    child: Container(
                      child: Row(
                        children: [
                          Text("Payable :-",
                            style: TextStyle(fontFamily: FontType.MontserratMedium,
                                color: Colors.green,fontSize: 16.sp),
                          ),
                          SizedBox(width: 5.w,),
                          Text(
                            "\u{20B9}${netAmount.isEmpty ? 0.00 : netAmount}",
                            style: TextStyle(fontFamily: FontType.MontserratMedium,
                                color: Colors.green,fontSize: 16.sp,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 10, 0),
                    child: InkWell(
                      onTap: (){
                        if(userStatus == 0){
                          SnackBarMessageShow.warningMSG('Account is under review\nPlease connect with support team', context);
                        }else if(userStatus == 1){
                          if(bodyMsg == 'There is no item in cart.'){
                            SnackBarMessageShow.warningMSG('Cart is empty', context);
                          }
                          else{
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TestBookingScreen(
                              testDis: testD,
                              packageDis: packageD,
                              profileDis: profileD,
                              promoApply: promoApply.text,
                            )));
                          }
                        }
                        else{
                          SnackBarMessageShow.warningMSG('User Not Found', context);
                        }
                      },
                      child: Card(
                        elevation: userStatus == 0 ? 0 : 5,
                        shadowColor: userStatus == 0 ? Colors.white : Colors.green.withOpacity(0.5),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.9.w,
                            padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:
                            userStatus == 0 ? Colors.green.withOpacity(0.5) : Colors.green
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Book now",
                                  style: TextStyle(
                                      fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 3.w,),
                                const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size: 12,)
                              ],
                            )
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          physics: const BouncingScrollPhysics(),
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
                    Text("Cart items",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18.sp,letterSpacing: 0.5),)
                  ],
                ),
              ),
              Divider(color: Colors.grey.withOpacity(0.5),thickness: 1),
              ChangeNotifierProvider<HomeMenusProvider>(
                create: (BuildContext context) => homeMenusProvider,
                child: Consumer<HomeMenusProvider>(
                  builder: (context, value, __){
                    switch(value.cartList.status){
                      case Status.loading:
                        return Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height / 3.5.h),
                            const CenterLoading(),
                          ],
                        );
                      case Status.error:
                        return value.cartList.message == 'Cart is Empty'
                          ? Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height / 3),
                              Center(
                                 child: Text(
                                  "${value.cartList.message}\nPlease buy Test or Package",
                                  style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16
                                  ),textAlign: TextAlign.center
                                 )
                              ),
                            ],
                          )
                          : Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height / 3.5),
                              TokenExpiredHelper(tokenMsg: value.cartList.message),
                            ],
                          );
                      case Status.completed:
                        return SizedBox(
                          width: MediaQuery.of(context).size.width.w,
                          child: Column(
                            children: [
                              value.cartList.data.data.cartItems.testItems.isEmpty
                              && value.cartList.data.data.cartItems.packageItems.isEmpty
                              && value.cartList.data.data.cartItems.profileItems.isEmpty
                               ? Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: MediaQuery.of(context).size.height / 2.h,),
                                      const Text(
                                          "Cart is empty",
                                          style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16
                                          ),textAlign: TextAlign.center
                                        ),
                                    ],
                                  )
                                  )
                               : Container(
                                width: MediaQuery.of(context).size.width.w,
                                //height: MediaQuery.of(context).size.height / 1.4.h,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height / 4),
                                  child: Column(
                                    children: [
                                      value.cartList.data.data.cartItems.testItems.isNotEmpty ? Padding(
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
                                                height: MediaQuery.of(context).size.height / 3.h,
                                                child: value.cartList.data.data.cartItems.testItems.isNotEmpty
                                                 ? Scrollbar(
                                                    isAlwaysShown: true,
                                                    thickness: 5,
                                                    radius: const Radius.circular(50),
                                                    child: ListView.builder(
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
                                                                      showDialog(
                                                                          context: context,
                                                                          barrierDismissible: false,
                                                                          builder: (BuildContext context) {
                                                                            return BackdropFilter(
                                                                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                                                              child: AlertDialog(
                                                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                                                                content: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(30),
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: <Widget>[
                                                                                      Image.asset("assets/health_saarthi_logo.png",width: 150),
                                                                                      const Padding(
                                                                                        padding: EdgeInsets.all(5),
                                                                                        child: Text(
                                                                                          "Are you sure would like to delete test item?",
                                                                                          style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 12),
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: <Widget>[
                                                                                          TextButton(
                                                                                            child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 2),),
                                                                                            onPressed: () => Navigator.of(context).pop(),
                                                                                          ),
                                                                                          TextButton(
                                                                                            child: const Text("Delete",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 2),),
                                                                                            onPressed: (){
                                                                                              CartFuture().removeToCartTest(getAccessToken.access_token, cartI.testItemInfo.id, context).then((value){}).then((value){
                                                                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                                                                                              });
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                      );
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
                                                ),
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
                                                  color: hsTestColor.withOpacity(0.8),
                                                ),
                                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                child: Row(
                                                  children: [
                                                    Text("Test discount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                                                    const Spacer(),
                                                    Container(
                                                        width: MediaQuery.of(context).size.width / 3.w,
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
                                                          items: [
                                                            const DropdownMenuItem(
                                                              value: '',
                                                              child: Text("discount"),
                                                            ),
                                                            ...value.cartList.data.data.globalSettingTestSlot?.map((testDrop) => DropdownMenuItem<String>(
                                                              value: testDrop.id.toString() ?? '',
                                                              child: Text("${testDrop.slotValue}%"),
                                                            ))?.toList() ?? []
                                                          ],
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ) : Container(),
                                      const SizedBox(height: 10),
                                      value.cartList.data.data.cartItems.packageItems.isNotEmpty ? Padding(
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
                                                height: MediaQuery.of(context).size.height / 6.5.h,
                                                child: value.cartList.data.data.cartItems.packageItems.isNotEmpty
                                                 ? Scrollbar(
                                                    isAlwaysShown: true,
                                                    thickness: 5,
                                                    radius: const Radius.circular(50),
                                                    child: ListView.builder(
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
                                                                      showDialog(
                                                                          context: context,
                                                                          barrierDismissible: false,
                                                                          builder: (BuildContext context) {
                                                                            return BackdropFilter(
                                                                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                                                              child: AlertDialog(
                                                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                                                                content: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(30),
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: <Widget>[
                                                                                      Image.asset("assets/health_saarthi_logo.png",width: 150),
                                                                                      const Padding(
                                                                                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                                                        child: Text(
                                                                                          "Are you sure would like to delete package item?",
                                                                                          style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 12),
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: <Widget>[
                                                                                          TextButton(
                                                                                            child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 2),),
                                                                                            onPressed: () => Navigator.of(context).pop(),
                                                                                          ),
                                                                                          TextButton(
                                                                                            child: const Text("Delete",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 2),),
                                                                                            onPressed: (){
                                                                                              CartFuture().removeToCartTest(getAccessToken.access_token, cartI.packageItemInfo.id, context).then((value){}).then((value){
                                                                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                                                                                              });
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                      );
                                                                    },
                                                                    child: SizedBox(
                                                                      width: MediaQuery.of(context).size.width / 6.w,
                                                                      child: Icon(Icons.delete_forever_rounded,color: hsPackageColor,size: 20),
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
                                                ),
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
                                                  color: hsPackageColor.withOpacity(0.8),
                                                ),
                                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                child: Row(
                                                  children: [
                                                    Text("Package discount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                                                    const Spacer(),
                                                    Container(
                                                        width: MediaQuery.of(context).size.width / 3.w,
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
                                                          items: [
                                                            const DropdownMenuItem(
                                                              value: '',
                                                              child: Text("Discount"),
                                                            ),
                                                            ...value.cartList.data.data.globalSettingPackageSlot?.map((packageDrop) => DropdownMenuItem<String>(
                                                              value: packageDrop.id.toString() ?? '',
                                                              child: Text("${packageDrop.slotValue}%"),
                                                            ))?.toList() ?? []
                                                          ],
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ) : Container(),
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
                                                child: value.cartList.data.data.cartItems.profileItems.isNotEmpty
                                                 ? Scrollbar(
                                                    isAlwaysShown: true,
                                                    thickness: 5,
                                                    radius: const Radius.circular(50),
                                                    child: ListView.builder(
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
                                                                      showDialog(
                                                                          context: context,
                                                                          barrierDismissible: false,
                                                                          builder: (BuildContext context) {
                                                                            return BackdropFilter(
                                                                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                                                              child: AlertDialog(
                                                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                                                                content: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(30),
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: <Widget>[
                                                                                      Image.asset("assets/health_saarthi_logo.png",width: 150),
                                                                                      const Padding(
                                                                                        padding: EdgeInsets.all(5),
                                                                                        child: Text(
                                                                                          "Are you sure would like to delete profile item?",
                                                                                          style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 12),
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: <Widget>[
                                                                                          TextButton(
                                                                                            child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 2),),
                                                                                            onPressed: () => Navigator.of(context).pop(),
                                                                                          ),
                                                                                          TextButton(
                                                                                            child: const Text("Delete",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 2),),
                                                                                            onPressed: (){
                                                                                              CartFuture().removeToCartTest(getAccessToken.access_token, cartI.profileItemInfo.id, context).then((value){
                                                                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                                                                                              });
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                      );
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
                                                ),
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
                                                  color: hsPackageColor.withOpacity(0.8),
                                                ),
                                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                child: Row(
                                                  children: [
                                                    Text("Profile discount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                                                    const Spacer(),
                                                    Container(
                                                        width: MediaQuery.of(context).size.width / 3.w,
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
                                                          items: [
                                                            const DropdownMenuItem(
                                                              value: '',
                                                              child: Text("Discount"),
                                                            ),
                                                            ...value.cartList.data.data.globalSettingProfileSlot?.map((packageDrop) => DropdownMenuItem<String>(
                                                              value: packageDrop.id.toString() ?? '',
                                                              child: Text(packageDrop.slotValue),
                                                            ))?.toList() ?? []
                                                          ],
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
                              /*SizedBox(height: 30.h,),
                              //const Spacer(),
                              value.cartList.data.data.cartItems.testItems.isEmpty
                                  && value.cartList.data.data.cartItems.packageItems.isEmpty
                                  && value.cartList.data.data.cartItems.profileItems.isEmpty
                                  ? Container()
                                  : Container(
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
                                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                      child: Row(
                                        children: [
                                          Text("Gross Amount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white),),
                                          const Spacer(),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: MediaQuery.of(context).size.width / 3.w,
                                            height: MediaQuery.of(context).size.height / 25.h,
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                            child: Text("\u{20B9}${grossAmount.isEmpty ? 0 : grossAmount}",style: const TextStyle(
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
                                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
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
                                      padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                                      alignment: Alignment.topLeft,
                                      child: callPromo == true ? Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width / 1.5.w,
                                            child: Card(
                                              elevation: 5,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        "Promo offer applyed",
                                                        style: TextStyle(
                                                            fontFamily: FontType.MontserratRegular,fontWeight: FontWeight.bold,color: Colors.green)
                                                    ),
                                                    Spacer(),
                                                    Text("\u{20B9}$applyPromo",style: TextStyle(fontFamily: FontType.MontserratMedium),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: (){
                                              promoApply.clear();
                                              _showLoadingDialog();
                                              cartCalculation().then((_) {
                                                setState(() {
                                                  callPromo = false;
                                                });
                                                Navigator.of(context).pop(); // Hide the loading dialog
                                              });
                                            },
                                            child: Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsPrime),),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                            ),
                                          )
                                        ],
                                      ): Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width / 1.5.w,
                                            height: MediaQuery.of(context).size.height / 20.h,
                                            child: TextField(
                                              controller: promoApply,
                                              style: const TextStyle(color: Colors.white,fontFamily: FontType.MontserratMedium),
                                              textAlign: TextAlign.left,
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
                                                    color: Colors.white,
                                                    fontFamily: FontType.MontserratMedium,
                                                    fontSize: 14
                                                ),
                                                //prefixIcon: Icon(iconData, color: hsBlack,size: 20),
                                              ),
                                              onEditingComplete: (){
                                                setState(() {
                                                  callPromo = true;
                                                });
                                                cartCalculation();
                                              },
                                            ),
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: (){
                                              if(promoApply.text.isEmpty){
                                                SnackBarMessageShow.warningMSG('Please enter coupe code', context);
                                              }
                                              else{
                                                _showLoadingDialog();
                                                cartCalculation().then((_) {
                                                  setState(() {
                                                    callPromo = true;
                                                  });
                                                  Navigator.of(context).pop();
                                                  promoApply.clear();
                                                });
                                              }
                                            },
                                            child: Text("Apply",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsPrime),),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width.w,
                                      height: MediaQuery.of(context).size.height / 14.sp,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),color: Colors.white),
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Text("Payable :-",
                                                    style: TextStyle(fontFamily: FontType.MontserratMedium,
                                                        color: Colors.green,fontSize: 16.sp),
                                                  ),
                                                  SizedBox(width: 5.w,),
                                                  Text(
                                                    "\u{20B9}${netAmount.isEmpty ? 0.00 : netAmount}",
                                                    style: TextStyle(fontFamily: FontType.MontserratMedium,
                                                        color: Colors.green,fontSize: 16.sp,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 4, 10, 0),
                                            child: InkWell(
                                              onTap: (){
                                                if(getAccessToken.userStatus == '0'){
                                                  SnackBarMessageShow.warningMSG('Unauthorized', context);
                                                }else if(getAccessToken.userStatus == '1'){
                                                  if(value.cartList.data.data.cartItems.testItems.isEmpty
                                                      && value.cartList.data.data.cartItems.packageItems.isEmpty
                                                      && value.cartList.data.data.cartItems.profileItems.isEmpty){
                                                    SnackBarMessageShow.warningMSG('Cart Is Empty', context);
                                                  }
                                                  else{
                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TestBookingScreen(
                                                      testDis: testD,
                                                      packageDis: packageD,
                                                      profileDis: profileD,
                                                      promoApply: promoApply.text,
                                                    )));
                                                  }
                                                }
                                                else{
                                                  SnackBarMessageShow.warningMSG('User Not Found', context);
                                                }
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
                                                      SizedBox(width: 3.w,),
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
                              ),*/
                            ],
                          ),
                        );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 16.0),
                Text('Loading...'),
              ],
            ),
          ),
        );
      },
    );
  }
  var bodyMsg;
  Future<CartCalculationModel> cartCalculation() async {
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
      print("responsedata->$responseData");
      var bodyStatus = responseData['status'];
      bodyMsg = responseData['message'];
      if (bodyStatus == 200) {
        setState(() {
          isApplyPromo = responseData['data']['isApplyPromo'];
          applyPromo = responseData['data']['applyPromo'];
          netAmount = responseData['data']['netAmount'].toString();
          grossAmount = responseData['data']['grossAmount'].toString();
          totalAmount = responseData['data']['discountAmount'].toString();
        });
        print("netA ->$netAmount / grossA ->$grossAmount / totalA ->$totalAmount / promo ->$applyPromo");
      }
      else if(bodyStatus == 400){
        setState(() {
          isApplyPromo = responseData['data']['isApplyPromo'];
          applyPromo = responseData['data']['applyPromo'];
          netAmount = responseData['data']['netAmount'].toString();
          grossAmount = responseData['data']['grossAmount'].toString();
          totalAmount = responseData['data']['discountAmount'].toString();
          promoApply.text = '';
        });
        print("netA ->$netAmount / grossA ->$grossAmount / totalA ->$totalAmount / promo ->$applyPromo");
        //SnackBarMessageShow.warningMSG('$bodyMsg', context);
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