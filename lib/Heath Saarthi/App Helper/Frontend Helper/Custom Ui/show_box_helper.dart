import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/UI%20Helper/app_icons_helper.dart';

import '../Font & Color Helper/font_&_color_helper.dart';

class ShowBoxHelper extends StatelessWidget {
  final GestureTapCallback? onTapForTest, onTapForPackage, onTapForPrescription,onTapForBooking;
  const ShowBoxHelper({super.key, this.onTapForTest, this.onTapForPackage, this.onTapForPrescription, this.onTapForBooking});

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
                  onTap: onTapForTest,
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
                                  Image(image: AppIcons.test,width: 30),
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
                                  Image(image: AppIcons.testSub,width: 12),
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
                  onTap: onTapForPackage,
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
                                  Image(image: AppIcons.package,width: 30),
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
                                  Image(image: AppIcons.packageSub,width: 12),
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
                  onTap: onTapForPrescription,
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
                                  Image(image: AppIcons.prescription,width: 30),
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
                                  Image(image: AppIcons.prescriptionSub,width: 12),
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
                  onTap: onTapForBooking,
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
                                  Image(image: AppIcons.instant,width: 30),
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
                                  Image(image: AppIcons.instantSub,width: 12),
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
    );
  }
}
