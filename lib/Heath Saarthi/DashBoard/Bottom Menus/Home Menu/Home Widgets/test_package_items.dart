import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';

class TestPackageItemsData extends StatelessWidget {
  var serviceName,specimenVolme,mrpAmount,bookedStatus,collect,orderInfo,reported,testList;
  final GestureTapCallback? onTap;
  TestPackageItemsData({super.key,this.serviceName,this.specimenVolme,this.mrpAmount,this.testList,this.bookedStatus,this.collect,this.orderInfo,this.reported,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${serviceName}",style: const TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,fontSize: 16,fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("${specimenVolme == null ? 'N/A': specimenVolme}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12),),
              const SizedBox(height: 10),
              Text("${testList == null ? 'N/A': testList}",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,color: Colors.black,fontSize: 14),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
          child: Row(
            children: [
              Text("\u{20B9}${mrpAmount}",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18,color: hsPrime)),
              const Spacer(),
              InkWell(
                onTap: onTap,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsPrime),
                  padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                  child: Text(bookedStatus == 1 ? "Booked": "+ Book Now",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 13,color: Colors.white),),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Container(
              width: MediaQuery.of(context).size.width / 1.5.w,
              child: Text(
                  "${collect == null ? 'N/A': collect}",
                  style: const TextStyle(
                    fontFamily: FontType.MontserratRegular,
                    letterSpacing: 0.5,fontSize: 14,
                  )
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${orderInfo == null ? 'N/A': orderInfo}",
                  style: const TextStyle(
                      fontFamily: FontType.MontserratRegular,
                      letterSpacing: 0.5,fontSize: 14
                  )
              ),
              const SizedBox(height: 10),
              Text("${reported == null ? 'N/A': reported}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12),),
            ],
          ),
        ),
      ],
    );
  }
}


class TestPackageItemAppBar extends StatelessWidget {
  var serviceCode;
  bool? pItemsLoading;
  TestPackageItemAppBar({super.key,this.serviceCode,this.pItemsLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: hsPrime,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,size: 30,color: Colors.white,
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Text(pItemsLoading == false ? "${serviceCode}" : '',
                  style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.right,)
            )
          ],
        ),
      ),
    );
  }
}
