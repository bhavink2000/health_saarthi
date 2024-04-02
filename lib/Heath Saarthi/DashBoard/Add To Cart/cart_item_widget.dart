// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/UI%20Helper/app_icons_helper.dart';
// import '../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
// import '../../App Helper/Backend Helper/Models/Cart Menu/cart_model.dart';
// import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
// import 'test_cart.dart';
//
// class CartItemWidget extends StatelessWidget {
//
//   String? cartItemLabel,itemDiscount,dropdownValue,accessToken;
//   final VoidCallback? addOnPressed;
//   final Function(String?)? dropdownOnChange;
//   List<Item>? cartItem;
//   List<GlobalSettingSlot>? globalSettingItemSlot;
//   CartItemWidget({super.key,
//     this.cartItemLabel,this.itemDiscount,this.addOnPressed,
//     this.dropdownOnChange,this.cartItem,
//     this.globalSettingItemSlot,this.dropdownValue,this.accessToken});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//       child: Container(
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: hsPrime.withOpacity(0.1)),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(15, 8, 10, 0),
//               child: Row(
//                 children: [
//                   //Container(width: 2, height: 18,color: hsTwo,),
//                   //const SizedBox(width: 5),
//                   Text("$cartItemLabel",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,fontWeight: FontWeight.bold),),
//                   const Spacer(),
//                   InkWell(
//                     onTap: addOnPressed,
//                     child: Container(
//                       padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime.withOpacity(0.8)),
//                       child: const Text("+ Add",style: TextStyle(color: Colors.white,fontFamily: FontType.MontserratMedium,fontSize: 14),),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Divider(color: Colors.grey.withOpacity(0.5),),
//             Container(
//               width: MediaQuery.of(context).size.width.w,
//               //height: value.cartList.data!.data!.cartItems!.packageItems!.length == 1 ? 50.h : 120.h,
//               height: cartItem!.length == 1 ? 50.h : 120.h,
//               //child: value.cartList.data!.data!.cartItems!.packageItems!.isNotEmpty
//               child: cartItem!.isNotEmpty
//                   ? Scrollbar(
//                 //thumbVisibility: true,
//                 thickness: 5,
//                 radius: const Radius.circular(50),
//                 child: ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   //itemCount: value.cartList.data?.data?.cartItems?.packageItems?.length,
//                   itemCount: cartItem?.length,
//                   itemBuilder: (context, pIndex){
//
//                     //var cartP = value.cartList.data?.data?.cartItems?.packageItems?[pIndex];
//                     var cartI = cartItem?[pIndex].testItemInfo;
//                     var cartP = cartItem?[pIndex].packageItemInfo;
//                     var cartPr = cartItem?[pIndex].profileItemInfo;
//                     return Padding(
//                       padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
//                       child: Column(
//                         children: [
//                           Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width / 1.9.w,
//                                   child: Text(cartItemLabel== 'Tests'
//                                       ? "${cartI?.serviceName}"
//                                       : cartItemLabel == 'Package'
//                                         ? "${cartP?.serviceName}"
//                                         : "${cartPr?.serviceName}",style: const TextStyle(fontFamily: FontType.MontserratLight,fontSize: 13)),
//                                 ),
//                                 Text("\u{20B9}${cartItemLabel== 'Tests'
//                                     ? "${cartI?.mrpAmount}"
//                                     : cartItemLabel == 'Package'
//                                     ? "${cartP?.mrpAmount}"
//                                     : "${cartPr?.mrpAmount}"}",style: const TextStyle(fontFamily: FontType.MontserratLight,fontSize: 14,fontWeight: FontWeight.bold)
//                                 ),
//                                 InkWell(
//                                   onTap: (){
//                                     showDialog(
//                                         context: context,
//                                         barrierDismissible: false,
//                                         builder: (BuildContext context) {
//                                           return BackdropFilter(
//                                             filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
//                                             child: AlertDialog(
//                                               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
//                                               content: Container(
//                                                 decoration: BoxDecoration(
//                                                   //color: Colors.white,
//                                                   borderRadius: BorderRadius.circular(30),
//                                                 ),
//                                                 child: Column(
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   children: <Widget>[
//                                                     Image(image: AppIcons.hsTransparent,width: 150),
//                                                     const Padding(
//                                                       padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                                                       child: Text(
//                                                         "Are you sure would like to delete package item?",
//                                                         style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 12),
//                                                         textAlign: TextAlign.center,
//                                                       ),
//                                                     ),
//                                                     Row(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                       children: <Widget>[
//                                                         TextButton(
//                                                           child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 2),),
//                                                           onPressed: () => Navigator.of(context).pop(),
//                                                         ),
//                                                         TextButton(
//                                                           child: const Text("Delete",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 2),),
//                                                           onPressed: (){
//                                                             CartFuture().removeToCartTest(
//                                                                 accessToken, cartItemLabel == 'Tests' ? cartI?.id : cartItemLabel== 'Package' ? cartP?.id : cartPr?.id , context).then((value){}).then((value){
//                                                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const TestCart()));
//                                                             });
//                                                           },
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         }
//                                     );
//                                   },
//                                   child: SizedBox(
//                                     width: MediaQuery.of(context).size.width / 6.w,
//                                     child: Icon(Icons.delete_forever_rounded,color: hsPrime,size: 20),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Divider(color: Colors.white,)
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               )
//                   : const Center(child: Text('No Items Available, \nSo You Need To Shopping.'),),
//             ),
//             SizedBox(height: 5.h),
//             Container(
//               width: MediaQuery.of(context).size.width.w,
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.only(
//                     bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)
//                 ),
//                 color: hsPrime.withOpacity(0.8),
//               ),
//               padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//               child: Row(
//                 children: [
//                   Text("$itemDiscount",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),
//                   const Spacer(),
//                   Container(
//                       width: MediaQuery.of(context).size.width / 3.w,
//                       height: MediaQuery.of(context).size.height / 25.h,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: Colors.white
//                       ),
//                       child: DropdownButtonFormField<String>(
//                         value: dropdownValue,
//                         style: const TextStyle(color: Colors.black,fontFamily: FontType.MontserratMedium),
//                         dropdownColor: Colors.white,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                           contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(15)
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(15)
//                           ),
//                           hintText: 'Discount',
//                           hintStyle: TextStyle(
//                             color: Colors.black,
//                             fontFamily: FontType.MontserratRegular,
//                             fontSize: 12.sp,
//                           ),
//                         ),
//                         onChanged: dropdownOnChange,
//                         items: [
//                           const DropdownMenuItem(
//                             value: '',
//                             child: Text("Discount"),
//                           ),
//                           ...globalSettingItemSlot?.map((itemDrop) => DropdownMenuItem<String>(
//                             value: itemDrop.id.toString() ?? '',
//                             child: Text("${itemDrop.slotValue}%"),
//                           ))?.toList() ?? []
//                         ],
//                       )
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
