import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../App Helper/Backend Helper/Api Future/Profile Future/profile_future.dart';
import '../../../App Helper/Backend Helper/Device Info/device_info.dart';
import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../Bottom Menus/Home Menu/Home Widgets/attach_prescription.dart';
import '../../Bottom Menus/Home Menu/Home Widgets/instant_booking.dart';
import '../../Bottom Menus/Home Menu/Packages List/package_list.dart';
import '../../Bottom Menus/Home Menu/Test List/test_list_items.dart';
import '../../Add To Cart/test_form_booking.dart';

class BookTestScreen extends StatefulWidget {
  const BookTestScreen({Key? key}) : super(key: key);

  @override
  State<BookTestScreen> createState() => _BookTestScreenState();
}

class _BookTestScreenState extends State<BookTestScreen> {
  File? fileManger;
  GetAccessToken getAccessToken = GetAccessToken();
  bool? isLoading;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    retrieveDeviceToken();
    Future.delayed(const Duration(seconds: 1),(){
      getUserStatus();
    });
  }
  var userStatus;
  var deviceToken;
  void getUserStatus()async{
    setState(() {
      isLoading = false;
    });
    try{
      dynamic userData = await ProfileFuture().fetchProfile(getAccessToken.access_token);
      setState(() {
        userStatus = userData.data.status;
        isLoading = true;
      });
      print("userStatus ==>>$userStatus");
    }
    catch(e){
      print("get User Status Error->$e");
      setState(() {
        isLoading = true;
      });
      if (e.toString().contains('402')) {
        DeviceInfo().logoutUser(context, deviceToken, getAccessToken.access_token);
      }
    }
  }

  Future<void> retrieveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      deviceToken = prefs.getString('deviceToken');
    });
    log("SharedPreferences DeviceToken->$deviceToken");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hsPrimeOne,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,color: Colors.white,size: 25,),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text("Book Test",style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: SafeArea(
                  child: isLoading == true ? Container(
                    width: MediaQuery.of(context).size.width.w,
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TestListItems()));
                                },
                                child: Card(
                                  elevation: 5,
                                  shadowColor: hsPrime.withOpacity(0.3),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2.1.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(width: 10),
                                                const Image(image: AssetImage("assets/Home/test.png"),width: 30),
                                                const SizedBox(width: 10),
                                                Text("Lab Test",style: TextStyle(fontSize: 12.sp,color: Colors.black,fontFamily: FontType.MontserratMedium,)),
                                                SizedBox(width: 1.w),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                                  child: Icon(Icons.arrow_forward_ios_rounded,size: 10),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                color: hsPrime.withOpacity(0.1)
                                            ),
                                            child: Row(
                                              children: [
                                                const Image(image: AssetImage("assets/Home/test_sub.png"),width: 12),
                                                SizedBox(width: 10.w,),
                                                const Text("View Test",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),)
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const PackageListItems()));
                                },
                                child: Card(
                                  elevation: 5,
                                  shadowColor: hsPrime.withOpacity(0.3),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2.1.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(width: 10),
                                                const Image(image: AssetImage("assets/Home/package.png"),width: 30),
                                                const SizedBox(width: 10),
                                                Text("Package",style: TextStyle(fontSize: 12.sp,color: Colors.black,fontFamily: FontType.MontserratMedium,)),
                                                SizedBox(width: 1.w),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                                  child: Icon(Icons.arrow_forward_ios_rounded,size: 10),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                color: hsPrime.withOpacity(0.1)
                                            ),
                                            child: Row(
                                              children: [
                                                const Image(image: AssetImage("assets/Home/package_sub.png"),width: 12),
                                                SizedBox(width: 10.w,),
                                                const Text("View Package",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),)
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
                              child: InkWell(
                                onTap: (){
                                  print("pre->${userStatus}");
                                  if(userStatus == 0){
                                    GetXSnackBarMsg.getWarningMsg('${AppTextHelper().inAccount}');
                                  }
                                  else if (userStatus == 1){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AttachPrescription()));
                                  }
                                  else{
                                    GetXSnackBarMsg.getWarningMsg('${AppTextHelper().userNotFound}');
                                  }
                                },
                                child: Card(
                                  elevation: 5,
                                  shadowColor: hsPrime.withOpacity(0.3),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2.1.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(width: 10),
                                                const Image(image: AssetImage("assets/Home/prescription.png"),width: 30),
                                                const SizedBox(width: 10),
                                                Text("Prescription",style: TextStyle(fontSize: 12.sp,color: Colors.black,fontFamily: FontType.MontserratMedium,)),
                                                SizedBox(width: 1.w),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                                  child: Icon(Icons.arrow_forward_ios_rounded,size: 10),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                color: hsPrime.withOpacity(0.1)
                                            ),
                                            child: Row(
                                              children: [
                                                const Image(image: AssetImage("assets/Home/prescription_sub.png"),width: 12),
                                                SizedBox(width: 10.w,),
                                                const Text("Attach File",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),)
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                              child: InkWell(
                                onTap: (){
                                  if(userStatus == 0){
                                    GetXSnackBarMsg.getWarningMsg('${AppTextHelper().inAccount}');
                                  }
                                  else if (userStatus == 1){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const InstantBooking()));
                                  }
                                  else{
                                    GetXSnackBarMsg.getWarningMsg('${AppTextHelper().userNotFound}');
                                  }

                                },
                                child: Card(
                                  elevation: 5,
                                  shadowColor: hsPrime.withOpacity(0.3),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2.1.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(width: 10),
                                                const Image(image: AssetImage("assets/Home/booking.png"),width: 30),
                                                SizedBox(width: 10.w),
                                                Text("Instant Book",style: TextStyle(fontSize: 12.sp,color: Colors.black,fontFamily: FontType.MontserratMedium,)),
                                                SizedBox(width: 1.w),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                                  child: Icon(Icons.arrow_forward_ios_rounded,size: 10),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                color: hsPrime.withOpacity(0.1)
                                            ),
                                            child: Row(
                                              children: [
                                                const Image(image: AssetImage("assets/Home/booking_sub.png"),width: 12),
                                                SizedBox(width: 10.w,),
                                                const Text("Book Now!",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),)
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ) : CenterLoading(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
