// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Dashboard%20Model/notification_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Dashboard%20Model/today_deal_details_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Drawer%20Menu/booking_history_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/hs_dashboard.dart';

import '../../../Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../Api Service/api_service_post_get.dart';
import '../../Api Service/api_service_type_post_get.dart';
import '../../Models/Cart Menu/cart_model.dart';
import '../../Models/Dashboard Model/banner_model.dart';
import '../../Models/Dashboard Model/today_deal_model.dart';
import '../../Models/Drawer Menu/faqs_model.dart';
import '../../Models/Home Menu/package_model.dart';
import '../../Models/Home Menu/test_model.dart';

class HomeMenuRepo{
  ApiServicesTypePostGet apiServicesTypePostGet = ApiServicePostGet();

  Future<TestModel> testData(var index,var access_token, var testData)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.testListUrls}?page=$index", access_token, testData);
    print("Response Test->$response");
    if (response['status'] == 'Token is Expired') {
      throw response['status'];
    } else {
      try {
        return response = TestModel.fromJson(response);
      } catch (e) {
        throw e;
      }
    }
  }

  Future<PackageModel> packageData(var index,var access_token, var packageData)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.packageListUrls}?page=$index", access_token, packageData);
    print("Response Package->$response");
    if (response['status'] == 'Token is Expired') {
      throw response['status'];
    } else {
      try {
        return response = PackageModel.fromJson(response);
      } catch (e) {
        throw e;
      }
    }
  }

  Future<BannerModel> bannerData(var index, var access_token) async {
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.bannerUrls}", access_token, '');
    print("Response Banner->$response");
    if (response['status'] == 'Token is Expired') {
      throw response['status'];
    } else {
      try {
        return BannerModel.fromJson(response);
      } catch (e) {
        throw e;
      }
    }
  }

  Future<TodayDealModel> todayDealData(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.todayDealUrls}", access_token, '');
    print("Response Today Deal->$response");
    if (response['status'] == 'Token is Expired') {
      throw response['status'];
    } else {
      try {
        return response = TodayDealModel.fromJson(response);
      } catch (e) {
        throw e;
      }
    }
  }

  Future<TodayDealDetailsModel> todayDealDetailsData(var index,var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.todayDealDetailsUrls}", access_token, data);
    print("Response Today Deal Details->$response");
    if (response['status'] == 'Token is Expired') {
      throw response['status'];
    } else {
      try {
        return response = TodayDealDetailsModel.fromJson(response);
      } catch (e) {
        throw e;
      }
    }
  }

  Future<CartModel> cartData(var index, var access_token, BuildContext context) async {
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse("${ApiUrls.cartItemsUrls}", access_token);
    print("Response cart -> $response");

    if (response['status'] == 'Token is Expired') {
      throw response['status'];
    } else {
      if (response['data']['cart_items'] == null) {
        throw 'Cart is Empty';
      } else {
        try {
          return CartModel.fromJson(response);
        } catch (e) {
          print("Cart Catch Error ->$e");
          throw e;
        }
      }
    }
  }

  Future<BookingHistoryModel> bookingData(var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.bookingHistoryUrls}", access_token, data);
    print("Response Booking->$response");
    if (response['status'] == 'Token is Expired') {
      throw response['status'];
    } else {
      try {
        return response = BookingHistoryModel.fromJson(response);
      } catch (e) {
        throw e;
      }
    }
  }

  Future<FaqsModel> faqsData(var access_token)async{
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse("${ApiUrls.faqsUrls}", access_token);
    print("Response Booking->$response");
    if (response['status'] == 'Token is Expired') {
      throw response['status'];
    } else {
      try {
        return response = FaqsModel.fromJson(response);
      } catch (e) {
        throw e;
      }
    }
  }
  Future<NotificationModel> notificationData(var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.notificationUrls}", access_token, '');
    print("Response Notification->$response");
    if (response['status'] == 'Token is Expired') {
      throw response['status'];
    } else {
      try {
        return response = NotificationModel.fromJson(response);
      } catch (e) {
        throw e;
      }
    }
  }
}