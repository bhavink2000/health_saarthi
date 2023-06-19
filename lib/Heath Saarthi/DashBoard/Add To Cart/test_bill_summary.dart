// //@dart=2.9
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
// import '../Bottom Menus/Test Menu/thank_you_msg.dart';
//
// class TestBillSummery extends StatefulWidget {
//   var tPatient;
//   TestBillSummery({Key key,this.tPatient}) : super(key: key);
//
//   @override
//   State<TestBillSummery> createState() => _TestBillSummeryState();
// }
//
// class _TestBillSummeryState extends State<TestBillSummery> {
//
//   List<String> testDiscount = ['10%', '25%', '45%'];
//   List<String> packageDiscount = ['20%', '35%', '40%'];
//   List<String> profileDiscount = ['10%', '15%', '30%'];
//   String testD;
//   String packageD;
//   String profileD;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                         onTap: (){
//                           Navigator.pop(context);
//                         },
//                         child: const Icon(Icons.arrow_back,size: 30,)
//                     ),
//                     const Text("Bill Summery",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18,letterSpacing: 0.5),)
//                   ],
//                 ),
//               ),
//               Divider(color: hsOne,thickness: 1),
//               Container(
//                 width: MediaQuery.of(context).size.width.w,
//                 height: MediaQuery.of(context).size.height / 1.65.h,
//                 padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                 child: ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, index){
//                     return ListTile(
//                       contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
//                       title: const Text("Cardiac Evaluation",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14)),
//                       subtitle: Text("Patient :- ${widget.tPatient}",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 12)),
//                       leading: CircleAvatar(
//                         radius: 20,
//                         backgroundColor: hsOne,
//                         child: Text(index/2 == 1 ? "T" : "P",style: const TextStyle(color: Colors.white,fontFamily: FontType.MontserratMedium),),
//                       ),
//                       trailing: const Text("\u{20B9}500",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16)),
//                     );
//                   },
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Container(width: 100.w,height: 1,color: hsOne),
//                     Text("Price Details",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 1,color: hsOne),),
//                     Container(width: 100.w,height: 1,color: hsOne),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                 child: Card(
//                   elevation: 8,
//                   color: hsTwo,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                   shadowColor: hsOne.withOpacity(0.8),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width.w,
//                           //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                           alignment: Alignment.topLeft,
//                           child: Row(
//                             children: [
//                               Text("Test Discount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16.sp,color: Colors.white),),
//                               const Spacer(),
//                               Container(
//                                   width: MediaQuery.of(context).size.width / 2.5.w,
//                                   height: MediaQuery.of(context).size.height / 20.h,
//                                   child: DropdownButtonFormField<String>(
//                                     value: testD,
//                                     style: const TextStyle(color: Colors.black54,fontFamily: FontType.MontserratMedium),
//                                     decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Colors.white),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Colors.white),
//                                       ),
//                                       hintText: 'Test Discount',
//                                       hintStyle: TextStyle(
//                                         color: Colors.white70,
//                                         fontFamily: FontType.MontserratRegular,
//                                         fontSize: 12.sp,
//                                       ),
//                                     ),
//                                     onChanged: (newValue) {
//                                       testD = newValue;
//                                     },
//                                     items: testDiscount.map<DropdownMenuItem<String>>((String state) {
//                                       return DropdownMenuItem<String>(
//                                         value: state,
//                                         child: Text(state),
//                                       );
//                                     }).toList(),
//                                   )
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                           alignment: Alignment.topLeft,
//                           child: Row(
//                             children: [
//                               Text("Package \nDiscount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16.sp,color: Colors.white),),
//                               const Spacer(),
//                               Container(
//                                   width: MediaQuery.of(context).size.width / 2.5.w,
//                                   height: MediaQuery.of(context).size.height / 20.h,
//                                   child: DropdownButtonFormField<String>(
//                                     value: packageD,
//                                     style: const TextStyle(color: Colors.black54,fontFamily: FontType.MontserratMedium),
//                                     decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Colors.white),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Colors.white),
//                                       ),
//                                       hintText: 'Package Discount',
//                                       hintStyle: TextStyle(
//                                         color: Colors.white70,
//                                         fontFamily: FontType.MontserratRegular,
//                                         fontSize: 12.sp,
//                                       ),
//                                     ),
//                                     onChanged: (newValue) {
//                                       packageD = newValue;
//                                     },
//                                     items: packageDiscount.map<DropdownMenuItem<String>>((String state) {
//                                       return DropdownMenuItem<String>(
//                                         value: state,
//                                         child: Text(state),
//                                       );
//                                     }).toList(),
//                                   )
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                           alignment: Alignment.topLeft,
//                           child: Row(
//                             children: [
//                               Text("Profile \nDiscount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16.sp,color: Colors.white),),
//                               const Spacer(),
//                               Container(
//                                   width: MediaQuery.of(context).size.width / 2.5.w,
//                                   height: MediaQuery.of(context).size.height / 20.h,
//                                   child: DropdownButtonFormField<String>(
//                                     value: profileD,
//                                     style: const TextStyle(color: Colors.black54,fontFamily: FontType.MontserratMedium),
//                                     decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Colors.white),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Colors.white),
//                                       ),
//                                       hintText: 'Profile Discount',
//                                       hintStyle: TextStyle(
//                                         color: Colors.white70,
//                                         fontFamily: FontType.MontserratRegular,
//                                         fontSize: 12.sp,
//                                       ),
//                                     ),
//                                     onChanged: (newValue) {
//                                       profileD = newValue;
//                                     },
//                                     items: profileDiscount.map<DropdownMenuItem<String>>((String state) {
//                                       return DropdownMenuItem<String>(
//                                         value: state,
//                                         child: Text(state),
//                                       );
//                                     }).toList(),
//                                   )
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                           alignment: Alignment.topLeft,
//                           child: Row(
//                             children: [
//                               Text("Prome Offer",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16.sp,color: Colors.white),),
//                               const Spacer(),
//                               Container(
//                                   width: MediaQuery.of(context).size.width / 2.5.w,
//                                   height: MediaQuery.of(context).size.height / 20.h,
//                                   child: const TextField(
//                                     //controller: controller,
//                                     style: TextStyle(color: Colors.black54,fontFamily: FontType.MontserratMedium),
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.all(hsPaddingM),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Colors.white),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Colors.white),
//                                       ),
//                                       hintText: 'Coupon Code',
//                                       hintStyle: TextStyle(
//                                           color: Colors.white70,
//                                           fontFamily: FontType.MontserratRegular,
//                                           fontSize: 14
//                                       ),
//                                       //prefixIcon: Icon(iconData, color: hsBlack,size: 20),
//                                     ),
//                                   )
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
//                         child: Card(
//                           elevation: 8,
//                           color: Colors.white,
//                           shadowColor: hsTwo.withOpacity(0.8),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width.w,
//                             height: MediaQuery.of(context).size.height / 16.sp,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                   child: Text("PLACE ORDER :-",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 1,fontSize: 18.sp,color: hsTwo),),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//                                   child: InkWell(
//                                     onTap: (){
//                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                         backgroundColor: hsColorFour,
//                                         content: const Text("Your booking Is Confirm",style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white),),
//                                       ));
//                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const ThankYouPage()));
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: hsTwo),
//                                       padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
//                                       child: Text("\u{20B9}9500",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white,fontSize: 20.sp),),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
