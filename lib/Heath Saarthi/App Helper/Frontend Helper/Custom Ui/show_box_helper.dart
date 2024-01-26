import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    );
  }
}
