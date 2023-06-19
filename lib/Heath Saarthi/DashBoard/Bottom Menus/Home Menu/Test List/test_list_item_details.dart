//@dart=2.9
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../Add To Cart/test_cart.dart';

class TestItemDetails extends StatefulWidget {
  var imageBaner;
  var title,mrp,serviceCode,collect,serviceClassification,serviceVolume,orderingInfo,reported;
  var state,city,area,branch,accessToken,testId;
  TestItemDetails({Key key,
  this.imageBaner,this.title,this.mrp,this.serviceCode,this.collect,this.serviceClassification,this.serviceVolume,
  this.orderingInfo,this.reported,this.state,this.city,this.area,this.branch,this.accessToken,this.testId}) : super(key: key);

  @override
  State<TestItemDetails> createState() => _TestItemDetailsState();
}

class _TestItemDetailsState extends State<TestItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: hsTestColor,
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
                      child: Text("${widget.serviceCode}",style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.right,))
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${widget.title}",style: const TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,fontSize: 16,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text("${widget.serviceVolume}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
                      child: Row(
                        children: [
                          Text("\u{20B9}${widget.mrp}",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18,color: hsTestColor)),
                          const Spacer(),
                          InkWell(
                            onTap: (){
                              CartFuture().addToCartTest(widget.accessToken, widget.testId, context).then((value) {
                                final response = value;
                                final snackBar = SnackBar(
                                  backgroundColor: hsTestColor,
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: Text("${response.message} (${response.count})", style: const TextStyle(color: Colors.white, fontFamily: FontType.MontserratRegular))),
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
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsTestColor.withOpacity(0.8)),
                              padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                              child: const Text("+ Book Now",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 13,color: Colors.white),),
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
                            "${widget.collect}",
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
                              "${widget.orderingInfo}",
                              style: const TextStyle(
                                  fontFamily: FontType.MontserratRegular,
                                  letterSpacing: 0.5,fontSize: 14
                              )
                          ),
                          const SizedBox(height: 10),
                          Text("${widget.reported}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12),),
                        ],
                      ),
                    ),
                   /* Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width.w,
                        height: MediaQuery.of(context).size.height / 20.h,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsOne),
                                child: Text(
                                  "Location",
                                  style: TextStyle(
                                      fontFamily: FontType.MontserratMedium,color: Colors.white,
                                    fontSize: 16,fontWeight: FontWeight.bold
                                  )
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(":-",style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: 5),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsTwo),
                                child: Text(
                                    "${widget.state}",
                                    style: TextStyle(
                                        fontFamily: FontType.MontserratRegular,color: Colors.white,
                                        fontSize: 14,
                                    )
                                ),
                              ),
                              Icon(Icons.arrow_forward_rounded,color: hsOne,),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsTwo),
                                child: Text(
                                    "${widget.city}",
                                    style: TextStyle(
                                      fontFamily: FontType.MontserratRegular,color: Colors.white,
                                      fontSize: 14,
                                    )
                                ),
                              ),
                              Icon(Icons.arrow_forward_rounded,color: hsOne,),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsTwo),
                                child: Text(
                                    "${widget.area}",
                                    style: TextStyle(
                                      fontFamily: FontType.MontserratRegular,color: Colors.white,
                                      fontSize: 14,
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),*/
                    /*Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          shadowColor: hsTwo.withOpacity(0.5),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 20,
                                decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),color: hsOne),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text("Test Name",style: TextStyle(color: Colors.white,fontFamily: FontType.MontserratMedium,fontSize: 16)),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: ExpansionTile(
                                  title: Text("CBC (Complete Blood Count)",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14)),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("1. RDW",style: TextStyle(fontFamily: FontType.MontserratRegular),textAlign: TextAlign.left)
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("2. MCHC",style: TextStyle(fontFamily: FontType.MontserratRegular),textAlign: TextAlign.left)
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("3. WBC (Total Leukocyte) count",style: TextStyle(fontFamily: FontType.MontserratRegular),textAlign: TextAlign.left)
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("4. Lymphocytes (%)",style: TextStyle(fontFamily: FontType.MontserratRegular),textAlign: TextAlign.left)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ExpansionTile(
                                  title: Text("Lipid Profile",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14)),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("1. VLDL",style: TextStyle(fontFamily: FontType.MontserratRegular),textAlign: TextAlign.left)
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("2. Direct LDL",style: TextStyle(fontFamily: FontType.MontserratRegular),textAlign: TextAlign.left)
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("3. Triglyceride",style: TextStyle(fontFamily: FontType.MontserratRegular),textAlign: TextAlign.left)
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("4. Cholesterol",style: TextStyle(fontFamily: FontType.MontserratRegular),textAlign: TextAlign.left)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ExpansionTile(
                                  title: Text("Calcium",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14)),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("1. Calcium",style: TextStyle(fontFamily: FontType.MontserratRegular),textAlign: TextAlign.left)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ExpansionTile(
                                  title: Text("Serum",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14)),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("1. Urea(Serum)",style: TextStyle(fontFamily: FontType.MontserratRegular),textAlign: TextAlign.left)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )*/
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
