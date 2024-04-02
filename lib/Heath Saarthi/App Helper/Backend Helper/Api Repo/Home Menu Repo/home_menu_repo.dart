// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Dashboard%20Model/notification_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Dashboard%20Model/today_deal_details_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Drawer%20Menu/booking_history_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/getx_snackbar_msg.dart';
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

  final box = GetStorage();

  // Future<TestModel> testData(var index,var access_token, var testData)async{
  //   dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.testListUrls}?page=$index", access_token, testData);
  //   print("Response Test->$response");
  //   if (response['status'] == '402') {
  //     //GetXSnackBarMsg.getWarningMsg('${response['message']}');
  //     throw response['status'];
  //   } else {
  //     try {
  //       return response = TestModel.fromJson(response);
  //     } catch (e) {
  //       print("test Data error->$e");
  //       throw e;
  //     }
  //   }
  // }
  //
  // Future<PackageModel> packageData(var index,var packageData)async{
  //   dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.packageListUrls}?page=$index", box.read('accessToken'), packageData);
  //   print("Response Package->$response");
  //   if (response['status'] == '402') {
  //     //GetXSnackBarMsg.getWarningMsg('${response['message']}');
  //     throw response['status'];
  //   } else {
  //     try {
  //       return response = PackageModel.fromJson(response);
  //     } catch (e) {
  //       print("package Data error->$e");
  //       throw e;
  //     }
  //   }
  // }

  Future<dynamic> popularPackageData(var index,var packageData) async {
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse("${ApiUrls.popularPackage}", box.read('accessToken'));
    log("Response Popular Package->$response");

    if (response['status'] == '402') {
      throw response['status'];
    } else {
      try {
        return response; // Just return the parsed response directly
      } catch (e) {
        print("package Data error->$e");
        throw e;
      }
    }
  }

  Future<BannerModel> bannerData(var index) async {
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.bannerUrls}", box.read('accessToken'), '');
    log("Response Banner->$response");
    if (response['status'] == '402') {
      throw response['status'];
    } else {
      try {
        return BannerModel.fromJson(response);
      } catch (e) {
        throw e;
      }
    }
  }

  Future<TodayDealModel> todayDealData(var index)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.todayDealUrls}", box.read('accessToken'), '');
    log("Response Today Deal->$response");
    if (response['status'] == '402') {
      throw response['status'];
    } else {
      try {
        return response = TodayDealModel.fromJson(response);
      } catch (e) {
        throw e;
      }
    }
  }

  Future<TodayDealDetailsModel> todayDealDetailsData(var index,var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.todayDealDetailsUrls}?page=$index", box.read('accessToken'), data);
    log("Response Today Deal Details->$response");
    if (response['status'] == '402') {
      throw response['status'];
    } else {
      try {
        return response = TodayDealDetailsModel.fromJson(response);
      } catch (e) {
        throw e;
      }
    }
  }

  Future<CartModel> cartData(var index, BuildContext context, var data) async {
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.cartItemsUrls}", box.read('accessToken'), data);
    log("Response cart -> $response");

    if (response['status'] == '402') {
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

  Future<BookingHistoryModel> bookingData(var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.bookingHistoryUrls}", box.read('accessToken'), data);
    log("Response Booking->$response");
    if (response['status'] == '402') {
      throw response['status'];
    } else {
      try {
        return response = BookingHistoryModel.fromJson(response);
      } catch (e) {
        throw e;
      }
    }
  }

  Future<FaqsModel> faqsData()async{
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse("${ApiUrls.faqsUrls}", box.read('accessToken'));
    log("Response faq->$response");
    if (response['status'] == '402') {
      throw response['status'];
    } else {
      try {
        return response = FaqsModel.fromJson(response);
      } catch (e) {
        print("faq e->$e");
        throw e;
      }
    }
  }
  Future<NotificationModel> notificationData()async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.notificationUrls}", box.read('accessToken'), '');
    log("Response Notification->$response");
    if (response['status'] == '402') {
      throw response['status'];
    } else {
      try {
        return response = NotificationModel.fromJson(response);
      } catch (e) {
        print("noti e->$e");
        throw e;
      }
    }
  }
}