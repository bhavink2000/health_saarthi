//@dart=2.9
import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/snackbar_msg_show.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../Add To Cart/test_form_booking.dart';
import '../Packages List/package_list.dart';
import '../Test List/test_list_items.dart';
import 'attach_prescription.dart';
import 'instant_booking.dart';

class HomeTestPackage extends StatefulWidget {
  var uStatus;
  HomeTestPackage({Key key,this.uStatus}) : super(key: key);

  @override
  State<HomeTestPackage> createState() => _HomeTestPackageState();
}

class _HomeTestPackageState extends State<HomeTestPackage> {
  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width.w,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    shadowColor: Color(0xff396fff).withOpacity(0.3),
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
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 10),
                                  const Image(image: AssetImage("assets/Home/test.png"),width: 30),
                                  const SizedBox(width: 10),
                                  Text("Lab Test",style: TextStyle(fontSize: 12.sp,color: Colors.black,fontFamily: FontType.MontserratMedium,)),
                                  SizedBox(width: 1.w),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Icon(Icons.arrow_forward_ios_rounded,size: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0xff396fff).withOpacity(0.1)
                              ),
                              child: Row(
                                children: [
                                  Image(image: AssetImage("assets/Home/test_sub.png"),width: 12),
                                  SizedBox(width: 10.w,),
                                  Text("View Test",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),)
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
                    shadowColor: Color(0xffe2791b).withOpacity(0.3),
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
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 10),
                                  const Image(image: AssetImage("assets/Home/package.png"),width: 30),
                                  const SizedBox(width: 10),
                                  Text("Package",style: TextStyle(fontSize: 12.sp,color: Colors.black,fontFamily: FontType.MontserratMedium,)),
                                  SizedBox(width: 1.w),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Icon(Icons.arrow_forward_ios_rounded,size: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0xffe2791b).withOpacity(0.1)
                              ),
                              child: Row(
                                children: [
                                  Image(image: AssetImage("assets/Home/package_sub.png"),width: 12),
                                  SizedBox(width: 10.w,),
                                  Text("View Package",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),)
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
                    print("pre->${widget.uStatus}");
                    if(widget.uStatus == 0){
                      SnackBarMessageShow.warningMSG('Account is under review\nPlease connect with support team', context);
                    }
                    else if (widget.uStatus == 1){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AttachPrescription()));
                    }
                    else{
                      SnackBarMessageShow.warningMSG('User Not Found', context);
                    }
                  },
                  child: Card(
                    elevation: 5,
                    shadowColor: Color(0xff4aa4f5).withOpacity(0.3),
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
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 10),
                                  const Image(image: AssetImage("assets/Home/prescription.png"),width: 30),
                                  const SizedBox(width: 10),
                                  Text("Prescription",style: TextStyle(fontSize: 12.sp,color: Colors.black,fontFamily: FontType.MontserratMedium,)),
                                  SizedBox(width: 1.w),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Icon(Icons.arrow_forward_ios_rounded,size: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0xff4aa4f5).withOpacity(0.1)
                              ),
                              child: Row(
                                children: [
                                  Image(image: AssetImage("assets/Home/prescription_sub.png"),width: 12),
                                  SizedBox(width: 10.w,),
                                  Text("Attach File",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),)
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
                    if(widget.uStatus == 0){
                      SnackBarMessageShow.warningMSG('Account is under review\nPlease connect with support team', context);
                    }
                    else if (widget.uStatus == 1){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>InstantBooking()));
                    }
                    else{
                      SnackBarMessageShow.warningMSG('User Not Found', context);
                    }

                  },
                  child: Card(
                    elevation: 5,
                    shadowColor: Color(0xff002860).withOpacity(0.3),
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
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 10),
                                  const Image(image: AssetImage("assets/Home/booking.png"),width: 30),
                                  SizedBox(width: 10.w),
                                  Text("Instant Book",style: TextStyle(fontSize: 12.sp,color: Colors.black,fontFamily: FontType.MontserratMedium,)),
                                  SizedBox(width: 1.w),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Icon(Icons.arrow_forward_ios_rounded,size: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0xff002860).withOpacity(0.1)
                              ),
                              child: Row(
                                children: [
                                  Image(image: AssetImage("assets/Home/booking_sub.png"),width: 12),
                                  SizedBox(width: 10.w,),
                                  Text("Book Now!",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),)
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
    );
  }
}
