//@dart=2.9
// ignore_for_file: prefer_typing_uninitialized_variables

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
// import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
//
//
// class TestItemDetails extends StatefulWidget {
//   var imageBaner;
//   var title,mrp,serviceCode,collect,serviceClassification,serviceVolume,orderingInfo,reported;
//   var state,city,area,branch,accessToken,testId,bookedStatus;
//   TestItemDetails({Key key,
//   this.imageBaner,this.title,this.mrp,this.serviceCode,this.collect,this.serviceClassification,this.serviceVolume,
//   this.orderingInfo,this.reported,this.state,this.city,this.area,this.branch,this.accessToken,this.testId,this.bookedStatus}) : super(key: key);
//
//   @override
//   State<TestItemDetails> createState() => _TestItemDetailsState();
// }
//
// class _TestItemDetailsState extends State<TestItemDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               color: hsTestColor,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: (){
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(
//                         Icons.arrow_back,size: 30,color: Colors.white,
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width / 1.5,
//                       child: Text("${widget.serviceCode}",style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.right,))
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("${widget.title}",style: const TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,fontSize: 16,fontWeight: FontWeight.bold)),
//                           const SizedBox(height: 10),
//                           Text("${widget.serviceVolume}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12),),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
//                       child: Row(
//                         children: [
//                           Text("\u{20B9}${widget.mrp}",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18,color: hsTestColor)),
//                           const Spacer(),
//                           InkWell(
//                             onTap: (){
//                               CartFuture().addToCartTest(widget.accessToken, widget.testId, context);
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsTestColor),
//                               padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
//                               child: Text(widget.bookedStatus == 1 ? "Booked": "+ Book Now",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 13,color: Colors.white),),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
//                       child: Container(
//                         width: MediaQuery.of(context).size.width / 1.5.w,
//                         child: Text(
//                             "${widget.collect}",
//                             style: const TextStyle(
//                                 fontFamily: FontType.MontserratRegular,
//                                 letterSpacing: 0.5,fontSize: 14,
//                             )
//                         )
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                               "${widget.orderingInfo}",
//                               style: const TextStyle(
//                                   fontFamily: FontType.MontserratRegular,
//                                   letterSpacing: 0.5,fontSize: 14
//                               )
//                           ),
//                           const SizedBox(height: 10),
//                           Text("${widget.reported}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12),),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
