// import 'package:flutter/material.dart';
//
// import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
//
// class CustomButton extends StatelessWidget {
//   final Color color;
//   final Color textColor;
//   final String text;
//   final Widget? image;
//   final VoidCallback onPressed;
//
//   const CustomButton({Key? key,
//     required this.color,
//     required this.textColor,
//     required this.text,
//     required this.onPressed,
//     this.image,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: const BoxConstraints(
//         minWidth: double.infinity,
//       ),
//       child: image != null
//           ? OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: color, shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               onPressed: onPressed,
//               child: Row(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(right: hsPaddingL),
//                     child: image,
//                   ),
//                   Text(
//                     text,
//                     style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,fontWeight: FontWeight.bold,color: Colors.white),
//                   ),
//                 ],
//               ),
//             )
//           : TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: color,
//                 padding: const EdgeInsets.all(hsPaddingM),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               onPressed: onPressed,
//               child: Text(
//                 text,
//                 style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,fontWeight: FontWeight.bold,color: Colors.white),
//               ),
//             ),
//     );
//   }
// }
