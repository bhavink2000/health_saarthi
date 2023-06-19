import 'package:flutter/cupertino.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Repo/Home%20Menu%20Repo/home_menu_repo.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Drawer%20Menu/booking_history_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Home%20Menu/package_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Home%20Menu/test_model.dart';

import '../../Enums/api_response_type.dart';
import '../../Models/Cart Menu/cart_model.dart';
import '../../Models/Dashboard Model/banner_model.dart';
import '../../Models/Dashboard Model/today_deal_model.dart';

class HomeMenusProvider with ChangeNotifier{
  final homeRepo = HomeMenuRepo();

  ApiResponseType<TestModel> testList = ApiResponseType.loading();
  setTestResponse(ApiResponseType<TestModel> testResponse){
    testList = testResponse;
    notifyListeners();
  }
  Future<void> fetchTest(var index,var access_token)async{
    setTestResponse(ApiResponseType.loading());
    homeRepo.testData(index,access_token).then((value){
      setTestResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setTestResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<PackageModel> packageList = ApiResponseType.loading();
  setPackageResponse(ApiResponseType<PackageModel> packageResponse){
    packageList = packageResponse;
    notifyListeners();
  }
  Future<void> fetchPackage(var index,var access_token)async{
    setPackageResponse(ApiResponseType.loading());
    homeRepo.packageData(index,access_token).then((value){
      setPackageResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setPackageResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<BannerModel> bannerList = ApiResponseType.loading();
  setBannerResponse(ApiResponseType<BannerModel> bannerResponse){
    bannerList = bannerResponse;
    notifyListeners();
  }
  Future<void> fetchBanner(var index,var access_token)async{
    setBannerResponse(ApiResponseType.loading());
    homeRepo.bannerData(index,access_token).then((value){
      setBannerResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setBannerResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<TodayDealModel> todayDealList = ApiResponseType.loading();
  setTodayDealResponse(ApiResponseType<TodayDealModel> todayDealResponse){
    todayDealList = todayDealResponse;
    notifyListeners();
  }
  Future<void> fetchTodayDeal(var index,var access_token)async{
    setTodayDealResponse(ApiResponseType.loading());
    homeRepo.todayDealData(index,access_token).then((value){
      setTodayDealResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setTodayDealResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<CartModel> cartList = ApiResponseType.loading();
  setCartResponse(ApiResponseType<CartModel> cartResponse){
    cartList = cartResponse;
    notifyListeners();
  }
  Future<void> fetchCart(var index,var access_token)async{
    print("in fetchCart");
    setCartResponse(ApiResponseType.loading());
    homeRepo.cartData(index,access_token).then((value){
      setCartResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setCartResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
    print("called fetchCart");
  }

  ApiResponseType<BookingHistoryModel> bookingList = ApiResponseType.loading();
  setBookingResponse(ApiResponseType<BookingHistoryModel> bookingResponse){
    bookingList = bookingResponse;
    notifyListeners();
  }
  Future<void> fetchBookingHistory(var access_token, var data)async{
    setBookingResponse(ApiResponseType.loading());
    homeRepo.bookingData(access_token, data).then((value){
      setBookingResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setBookingResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }
}