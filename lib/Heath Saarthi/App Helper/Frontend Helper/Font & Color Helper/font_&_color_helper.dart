// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';

Color hsPrime = const Color(0xff7c54a4);
Color hsPrimeOne = const Color(0xff593c76);
Color hsPrimeTwo = const Color(0xff734e98);
Color hsPrimeThree = const Color(0xff8c67b1);

Color qrCodeColor = Color(0xffd5ecfa);


class FontType{
  static const String MontserratExtra = "Montserrat-Extra";
  static const String MontserratLight = "Montserrat-Light";
  static const String MontserratMedium = "Montserrat-Medium";
  static const String MontserratRegular = "Montserrat-Regular";
}

const Color hsWhite = Color(0xFFFFFFFF);
const Color hsGrey = Color(0xFFF4F5F7);
const Color hsBlack = Color(0xFF2D3243);

// Padding
const double hsPaddingS = 8.0;
const double hsPaddingM = 10.0;
const double hsPaddingL = 32.0;

// Spacing
const double hsSpaceS = 8.0;
const double hsSpaceM = 16.0;

// Animation
const Duration hsButtonAnimationD = Duration(milliseconds: 600);
const Duration hsCardAnimationD = Duration(milliseconds: 400);
const Duration hsRippleAnimationD = Duration(milliseconds: 400);
const Duration hsLoginAnimationD = Duration(milliseconds: 1500);


final InputDecoration mobileNumberDecoration = InputDecoration(
  contentPadding: const EdgeInsets.all(8.0),
  border: const OutlineInputBorder(),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
    borderRadius: BorderRadius.circular(15),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
    borderRadius: BorderRadius.circular(15),
  ),
  label: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text("Select mobile number"),
      Text(" *", style: TextStyle(color: Colors.red)),
    ],
  ),
  labelStyle: const TextStyle(
    color: Colors.black54,
    fontFamily: FontType.MontserratRegular,
    fontSize: 14,
  ),
  prefixIcon: const Icon(Icons.mobile_friendly_rounded, color: Colors.black, size: 20),
);