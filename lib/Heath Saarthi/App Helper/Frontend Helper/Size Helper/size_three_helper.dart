//@dart=2.9
import 'package:flutter/material.dart';

class ResponsiveLayout {
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double textScaleFactor;

  static Orientation currentOrientation;
  static DeviceScreenType currentDeviceScreenType;

  static void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    textScaleFactor = mediaQuery.textScaleFactor;

    currentOrientation = mediaQuery.orientation;
    currentDeviceScreenType = _getDeviceType(mediaQuery);
  }

  static DeviceScreenType _getDeviceType(MediaQueryData mediaQuery) {
    double deviceWidth = mediaQuery.size.shortestSide;

    if (deviceWidth >= 600) {
      return DeviceScreenType.Tablet;
    }

    return DeviceScreenType.Mobile;
  }

  static bool isMobile() {
    return currentDeviceScreenType == DeviceScreenType.Mobile;
  }

  static bool isTablet() {
    return currentDeviceScreenType == DeviceScreenType.Tablet;
  }

  static bool isPortrait() {
    return currentOrientation == Orientation.portrait;
  }

  static bool isLandscape() {
    return currentOrientation == Orientation.landscape;
  }
}

enum DeviceScreenType {
  Mobile,
  Tablet,
}