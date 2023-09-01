//@dart=2.9
// ignore_for_file: missing_return, use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Cart%20Future/cart_future.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Error%20Helper/token_expired_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:provider/provider.dart';
import '../../App Helper/Backend Helper/Api Future/Location Future/location_future.dart';
import '../../App Helper/Backend Helper/Api Future/Profile Future/profile_future.dart';
import '../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../App Helper/Backend Helper/Enums/enums_status.dart';
import '../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Backend Helper/Models/Cart Menu/cart_calculation.dart';
import '../../App Helper/Backend Helper/Models/Location Model/area_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/branch_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/city_model.dart';
import '../../App Helper/Backend Helper/Models/Location Model/state_model.dart';
import '../../App Helper/Backend Helper/Providers/Home Menu Provider/home_menu_provider.dart';
import '../../App Helper/Frontend Helper/Error Helper/internet_problem.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
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

  String sStateName;
  String sCityName;
  String sAreaName;
  String sBranchName;
  String sStateId;
  String sCityId;
  String sAreaId;
  String sBranchId;

  bool setLocation = false;
  bool showDLocation = false;
  bool showExpantile = true;

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

  bool stateLoading = false;
  bool cityLoading = false;
  bool areaLoading = false;
  bool branchLoading = false;

  GetAccessToken getAccessToken = GetAccessToken();
  HomeMenusProvider homeMenusProvider = HomeMenusProvider();
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      cartScreenCall();
    });
  }

  void cartScreenCall()async{
    await getUserStatus();
    await homeMenusProvider.fetchCart(1, getAccessToken.access_token, context,sBranchId);
    await cartCalculation();
  }
  bool pageLoad = false;
  var userStatus;
  void getUserStatus()async{
    try{
      dynamic userData = await ProfileFuture().fetchProfile(getAccessToken.access_token);
      setState(() {
        userStatus = userData.data.status;
        sStateId = userData.data.state.id.toString();
        sCityId = userData.data.city.id.toString();
        sAreaId = userData.data.area.id.toString();
        sBranchId = userData.data.costCenter.id.toString();
        sStateName = userData.data.state.stateName.toString();
        sCityName = userData.data.city.cityName.toString();
        sAreaName = userData.data.area.areaName.toString();
        sBranchName = userData.data.costCenter.branchName.toString();
        pageLoad = true;
      });
      print("userStatus ==>>$userStatus");
      print("branchId ==>>$sBranchId");
    }catch(e){
      print("get User Status Error->$e");
    }
  }

  String selectLocation;
  final GlobalKey<FormState> _locationFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      bottomSheet: pageLoad == true ? Container(
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
                  Text("Gross amount",style: TextStyle(fontFamily: FontType.MontserratLight,fontSize: 14.sp,color: Colors.white),),
                  const Spacer(),
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width / 3.w,
                    height: MediaQuery.of(context).size.height / 25.h,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Text("\u{20B9}${grossAmount.isEmpty ? 0 : grossAmount}",style: const TextStyle(
                        color: Colors.white,
                        fontFamily: FontType.MontserratRegular,
                        fontSize: 16,
                      fontWeight: FontWeight.bold
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
                  Text("Total discount",style: TextStyle(fontFamily: FontType.MontserratLight,fontSize: 14.sp,color: Colors.white),),
                  const Spacer(),
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width / 3.w,
                    height: MediaQuery.of(context).size.height / 25.h,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Text("$totalAmount",style: const TextStyle(
                        color: Colors.white,
                        fontFamily: FontType.MontserratRegular,
                        fontSize: 16,
                      fontWeight: FontWeight.bold
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
                                    fontFamily: FontType.MontserratRegular,fontWeight: FontWeight.bold,color: Colors.orange)
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
                        GetXSnackBarMsg.getWarningMsg('${AppTextHelper().couponCode}');

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
                                color: Colors.orange,fontSize: 14.sp),
                          ),
                          SizedBox(width: 5.w,),
                          Text(
                            "\u{20B9}${netAmount.isEmpty ? 0.00 : netAmount}",
                            style: TextStyle(fontFamily: FontType.MontserratMedium,
                                color: Colors.orange,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 10, 0),
                    child: InkWell(
                      onTap: (){
                        if(userStatus == 0){
                          GetXSnackBarMsg.getWarningMsg('${AppTextHelper().inAccount}');
                        }else if(userStatus == 1){
                          if(bodyMsg == 'There is no item in cart.'){
                            GetXSnackBarMsg.getWarningMsg('${AppTextHelper().cartEmpty}');
                          }
                          else{
                            if(selectLocation == null){
                              GetXSnackBarMsg.getWarningMsg('${AppTextHelper().selectLocation}');
                            }
                            else{
                              if(setLocation == false){
                                GetXSnackBarMsg.getWarningMsg('${AppTextHelper().setLocation}');
                              }
                              else{
                                print("branch->>${selectedBranch}/$sBranchName/$selectedBranch");
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TestBookingScreen(
                                  testDis: testD,
                                  packageDis: packageD,
                                  profileDis: profileD,
                                  promoApply: promoApply.text,
                                  dStateId: selectLocation == 'cLocation' ? sStateId : selectedStateId,
                                  dStateNm: selectLocation == 'cLocation' ? sStateName : selectedState,
                                  dCityId: selectLocation == 'cLocation' ?  sCityId : selectedCityId,
                                  dCityNm: selectLocation == 'cLocation' ? sCityName : selectedCity,
                                  dAreaId: selectLocation == 'cLocation' ? sAreaId : selectedAreaId,
                                  dAreaNm: selectLocation == 'cLocation' ? sAreaName : selectedArea,
                                  dBranchId: selectLocation == 'cLocation' ? sBranchId : selectedBranchId,
                                  dBranchNm: selectLocation == 'cLocation' ? sBranchName : selectedBranch,
                                )));
                              }
                            }
                          }
                        }
                        else{
                          GetXSnackBarMsg.getWarningMsg('${AppTextHelper().userNotFound}');
                        }
                      },
                      child: Card(
                        elevation: userStatus == 0 ? 0 : 5,
                        shadowColor: userStatus == 0 ? Colors.white : Colors.green.withOpacity(0.5),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.9.w,
                            padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:
                            userStatus == 0 ? Colors.orange.withOpacity(0.5) : Colors.orange
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
      ) : CenterLoading(),
      body: pageLoad == true ? SafeArea(
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
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        dense: true,
                        title: const Text('Current location',style: TextStyle(fontFamily: FontType.MontserratRegular)),
                        value: 'cLocation',
                        groupValue: selectLocation,
                        onChanged: (value) {
                          print("sbranchId---->>$sBranchId");
                          homeMenusProvider.fetchCart(1, getAccessToken.access_token, context,sBranchId).then((value){
                            Future.delayed(const Duration(seconds: 1),(){
                              cartCalculation();
                            });
                          });
                          print("sbranchId<<------$sBranchId");
                          setState(() {
                            selectLocation = value;
                            showDLocation = false;
                            stateList.clear();
                            selectedState = '';
                            cityList.clear();
                            selectedCity = '';
                            areaList.clear();
                            selectedArea = '';
                            branchList.clear();
                            selectedBranch = '';
                            setLocation = true;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        dense: true,
                        title: const Text('Different location',style: TextStyle(fontFamily: FontType.MontserratRegular)),
                        value: 'dLocation',
                        groupValue: selectLocation,
                        onChanged: (value) {
                          fetchStateList();
                          setState(() {
                            setLocation = false;
                            selectLocation = value;
                            showDLocation = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: showDLocation,
                child: Form(
                  key: _locationFormKey,
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    title: const Text('Choose location',style: TextStyle(fontFamily: FontType.MontserratMedium)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.w,
                          //height: MediaQuery.of(context).size.height / 14.h,
                          child: Stack(
                            children: [
                              Visibility(
                                visible: stateLoading,
                                child: Positioned(
                                  top: 10,
                                  right: 5,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              DropdownSearch<String>(
                                mode: Mode.DIALOG,
                                autoValidateMode: AutovalidateMode.onUserInteraction,
                                showSearchBox: true,
                                showSelectedItem: true,
                                items: stateList.where((state) => state.stateName != null).map((state) => state.stateName).toList(),
                                label: "Select state *",
                                onChanged: (newValue) {
                                  final selectedStateObject = stateList.firstWhere((state) => state.stateName == newValue, orElse: () => null);
                                  if (selectedStateObject != null) {
                                    setState(() {
                                      cityList.clear();
                                      selectedCity = '';
                                      areaList.clear();
                                      selectedArea = '';
                                      branchList.clear();
                                      selectedBranch = '';
                                      selectedState = newValue;
                                      selectedStateId = selectedStateObject.id.toString();
                                    });
                                    fetchCityList(selectedStateId);
                                  }
                                },
                                selectedItem: selectedState,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select a state';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.w,
                          //height: MediaQuery.of(context).size.height / 14.h,
                          child: Stack(
                            children: [
                              Visibility(
                                visible: cityLoading,
                                child: Positioned(
                                  top: 10,
                                  right: 5,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              DropdownSearch<String>(
                                mode: Mode.DIALOG,
                                autoValidateMode: AutovalidateMode.onUserInteraction,
                                showSearchBox: true,
                                showSelectedItem: true,
                                items: cityList.where((city) => city.cityName != null).map((city) => city.cityName).toList(),
                                label: "Select city *",
                                onChanged: (newValue) {
                                  final selectedCityObject = cityList.firstWhere((city) => city.cityName == newValue, orElse: () => null);
                                  if (selectedCityObject != null) {
                                    setState(() {
                                      selectedCity = '';
                                      areaList.clear();
                                      selectedArea = '';
                                      branchList.clear();
                                      selectedBranch = '';
                                      selectedCity = newValue;
                                      selectedCityId = selectedCityObject.id.toString();
                                      //fetchBranchList(selectedStateId, selectedCityId, '');
                                    });
                                    fetchAreaList(selectedStateId, selectedCityId);
                                  }
                                },
                                selectedItem: selectedCity,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select a city';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.w,
                          //height: MediaQuery.of(context).size.height / 14.h,
                          child: Stack(
                            children: [
                              Visibility(
                                visible: areaLoading,
                                child: Positioned(
                                  top: 10,
                                  right: 5,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              DropdownSearch<String>(
                                mode: Mode.DIALOG,
                                autoValidateMode: AutovalidateMode.onUserInteraction,
                                showSearchBox: true,
                                showSelectedItem: true,
                                items: areaList?.map((area) => area.areaName)?.toList() ?? [],
                                label: "Select area *",
                                onChanged: (newValue) {
                                  final selectedAreaObject = areaList.firstWhere((area) => area.areaName  == newValue, orElse: () => null);
                                  if (selectedAreaObject != null) {
                                    setState(() {
                                      branchList.clear();
                                      selectedBranch = '';
                                      selectedArea = newValue;
                                      selectedAreaId = selectedAreaObject.id.toString();
                                      fetchBranchList(selectedStateId, selectedCityId, selectedAreaId);
                                    });
                                  }
                                },
                                selectedItem: selectedArea,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select a area';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.w,
                          //height: MediaQuery.of(context).size.height / 14.h,
                          child: Stack(
                            children: [
                              Visibility(
                                visible: branchLoading,
                                child: Positioned(
                                  top: 10,
                                  right: 5,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              DropdownSearch<String>(
                                mode: Mode.DIALOG,
                                autoValidateMode: AutovalidateMode.onUserInteraction,
                                showSearchBox: true,
                                showSelectedItem: true,
                                items: branchList?.map((branch) => branch.branchName)?.toList() ?? [],
                                label: "Select branch *",
                                onChanged: (newValue) {
                                  final selectedBranchObject = branchList.firstWhere((branch) => branch.branchName  == newValue, orElse: () => null);
                                  if (selectedBranchObject != null) {
                                    setState(() {
                                      selectedBranch = newValue;
                                      selectedBranchId = selectedBranchObject.id.toString();
                                    });
                                  }
                                },
                                selectedItem: selectedBranch,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select a branch';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: hsPrime
                            ),
                            onPressed: (){
                              if(_locationFormKey.currentState.validate()){
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  showDLocation = false;
                                  setLocation = true;
                                });
                                homeMenusProvider.fetchCart(1, getAccessToken.access_token, context,selectedBranchId).then((value){
                                  Future.delayed(const Duration(seconds: 1),(){
                                    cartCalculation();
                                  });
                                });
                              }
                            },
                            child: const Text('Set location',style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),)
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
              //const Divider(endIndent: 20,indent: 20,thickness: 0.9,),
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
                              value.cartList.status == '402'
                                  ? TokenExpiredHelper(tokenMsg: value.cartList.message)
                                  : value.cartList.message == 'Internet connection problem' ? CenterLoading() : const Center(child: Text('Please check internet connection')),
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
                                              Container(
                                                //color: Colors.green,
                                                width: MediaQuery.of(context).size.width.w,
                                                height: value.cartList.data.data.cartItems.testItems.length == 1
                                                    ? 50.h : value.cartList.data.data.cartItems.testItems.length == 2 ? 80.h
                                                    : 175.h,
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
                                                                  Container(
                                                                    width: MediaQuery.of(context).size.width / 1.9.w,
                                                                    child: Text(cartI.testItemInfo.serviceName,style: const TextStyle(fontFamily: FontType.MontserratLight,fontSize: 13)),
                                                                  ),
                                                                  Text("\u{20B9}${cartI.testItemInfo.mrpAmount}",style: const TextStyle(fontFamily: FontType.MontserratLight,fontSize: 14,fontWeight: FontWeight.bold)),
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
                                                 : const Center(child: Text('No Items Available, \nSo You Need To Shopping.'),),
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
                                      value.cartList.data.data.cartItems.testItems.isNotEmpty ? Container() : Center(
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            const Text("Add test",style: TextStyle(fontFamily: FontType.MontserratMedium)),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: hsPrime,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                                ),
                                                onPressed: (){
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TestListItems()));
                                                },
                                                child: const Text("+ Test",style: TextStyle(fontFamily: FontType.MontserratRegular))
                                            )
                                          ],
                                        ),
                                      ),
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
                                                height: value.cartList.data.data.cartItems.packageItems.length == 1 ? 50.h : 120.h,
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
                                                                    width: MediaQuery.of(context).size.width / 1.9.w,
                                                                    child: Text(cartI.packageItemInfo.serviceName,style: const TextStyle(fontFamily: FontType.MontserratLight,fontSize: 13)),
                                                                  ),
                                                                  Text("\u{20B9}${cartI.packageItemInfo.mrpAmount}",style: const TextStyle(fontFamily: FontType.MontserratLight,fontSize: 14,fontWeight: FontWeight.bold)),
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
                                                 : const Center(child: Text('No Items Available, \nSo You Need To Shopping.'),),
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
                                      ) : value.cartList.data.data.cartItems.profileItems.isEmpty ? Center(
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            const Text("Add package",style: TextStyle(fontFamily: FontType.MontserratMedium)),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: hsPrime,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                              ),
                                              onPressed: (){
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PackageListItems()));
                                              },
                                              child: const Text("+ Package",style: TextStyle(fontFamily: FontType.MontserratRegular))
                                            )
                                          ],
                                        ),
                                      ) : Container(),

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
                                                height: value.cartList.data.data.cartItems.profileItems.length == 1 ? 50.h : 100.h,
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
                                                                    width: MediaQuery.of(context).size.width / 1.9.w,
                                                                    child: Text(cartI.profileItemInfo.serviceName,style: const TextStyle(fontFamily: FontType.MontserratLight,fontSize: 13)),
                                                                  ),
                                                                  Text("\u{20B9}${cartI.profileItemInfo.mrpAmount}",style: const TextStyle(fontFamily: FontType.MontserratLight,fontSize: 14,fontWeight: FontWeight.bold)),
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
                                                                      child: Icon(Icons.delete_forever_rounded,color: hsPrime,size: 20),
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
                                                 : const Center(child: Text('No Items Available, \nSo You Need To Shopping.'),),
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
                                                              child: Text('${packageDrop.slotValue}%'),
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
      ) : CenterLoading(),
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
      }
    } catch (error) {
      print("cart Calculation Error->$error");
    }
  }

  List<StateData> stateList = [];
  String selectedState;
  String selectedStateId;
  Future<void> fetchStateList() async {
    setState(() {
      stateLoading = true;
    });
    try {
      LocationFuture locationFuture = LocationFuture();
      List<StateData> list = await locationFuture.getState();
      setState(() {
        stateList = list;
        stateLoading = false;
      });
    } catch (e) {
      print("Error -> $e");
    }
  }

  List<CityData> cityList = [];
  String selectedCity;
  String selectedCityId;
  Future<void> fetchCityList(var sState) async {
    setState(() {
      cityLoading = true;
    });
    try {
      LocationFuture locationFuture = LocationFuture();
      List<CityData> list = await locationFuture.getCity(sState);
      setState(() {
        cityList = list;
        cityLoading = false;
      });
    } catch (e) {
      print("Error -> $e");
    }
  }

  List<AreaData> areaList = [];
  String selectedArea;
  String selectedAreaId;
  Future<void> fetchAreaList(var sState, var sCity) async {
    setState(() {
      areaLoading = true;
    });
    try {
      LocationFuture locationFuture = LocationFuture();
      List<AreaData> list = await locationFuture.getArea(sState,sCity);
      setState(() {
        areaList = list;
        areaLoading = false;
      });
    } catch (e) {
      print("Error -> $e");
    }
  }

  List<BranchData> branchList = [];
  String selectedBranch;
  String selectedBranchId;
  Future<void> fetchBranchList(var sState, var sCity, var sArea) async {
    setState(() {
      branchLoading = true;
    });
    try {
      LocationFuture locationFuture = LocationFuture();
      List<BranchData> list = await locationFuture.getBranch(sState,sCity,sArea);
      setState(() {
        branchList = list;
        branchLoading = false;
      });
    } catch (e) {
      print("Branch Error -> $e");
    }
  }
}
