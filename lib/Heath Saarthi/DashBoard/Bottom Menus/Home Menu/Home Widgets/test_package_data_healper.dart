import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';

class TestPackageData extends StatelessWidget {

  final GestureTapCallback? onTap,bookedOnTap;
  String? serviceName,specimenVolume,mrpAmount,bookedStatus;
  TestPackageData({super.key,this.onTap,this.bookedOnTap,this.serviceName,this.specimenVolume,this.bookedStatus,this.mrpAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: InkWell(
        onTap: onTap,
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
                  color: hsPrime.withOpacity(0.8),
                ),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                    serviceName!,
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
                        child: Text("${specimenVolume == null ? 'N/A': specimenVolume}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12.sp),)
                    ),
                    Row(
                      children: [
                        Text("\u{20B9}${mrpAmount}",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18.sp,color: hsBlack)),
                        const Spacer(),
                        InkWell(
                          onTap: bookedOnTap,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                color: bookedStatus.toString() == '1' ? hsPrime.withOpacity(0.2): hsPrime
                            ),
                            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                            child: Text(
                              bookedStatus.toString() == '1' ? "Booked" :"+ Book Now",
                              style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 13.sp,color: Colors.white),),
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
    );
  }
}
