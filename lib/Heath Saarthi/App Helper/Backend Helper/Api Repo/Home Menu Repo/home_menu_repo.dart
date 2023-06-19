import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Drawer%20Menu/booking_history_model.dart';

import '../../Api Service/api_service_post_get.dart';
import '../../Api Service/api_service_type_post_get.dart';
import '../../Models/Cart Menu/cart_model.dart';
import '../../Models/Dashboard Model/banner_model.dart';
import '../../Models/Dashboard Model/today_deal_model.dart';
import '../../Models/Home Menu/package_model.dart';
import '../../Models/Home Menu/test_model.dart';

class HomeMenuRepo{
  ApiServicesTypePostGet apiServicesTypePostGet = ApiServicePostGet();

  Future<TestModel> testData(var index,var access_token)async{
    print("Access->$access_token");
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.testListUrls}?page=$index", access_token, '');
    print("Response Test->$response");
    try{return response = TestModel.fromJson(response);}catch(e){throw e;}
  }

  Future<PackageModel> packageData(var index,var access_token)async{
    print("Access->$access_token");
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.packageListUrls}?page=$index", access_token, '');
    print("Response Package->$response");
    try{return response = PackageModel.fromJson(response);}catch(e){throw e;}
  }

  Future<BannerModel> bannerData(var index,var access_token)async{
    print("Access->$access_token");
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.bannerUrls}", access_token, '');
    print("Response Banner->$response");
    try{return response = BannerModel.fromJson(response);}catch(e){throw e;}
  }

  Future<TodayDealModel> todayDealData(var index,var access_token)async{
    print("Access->$access_token");
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.todayDealUrls}", access_token, '');
    print("Response Banner->$response");
    try{return response = TodayDealModel.fromJson(response);}catch(e){throw e;}
  }

  Future<CartModel> cartData(var index,var access_token)async{
    print("calling cartData");
    print("Access->$access_token");
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse("${ApiUrls.cartItemsUrls}", access_token);
    print("Response cart->$response");
    print("called cartData");
    try{return response = CartModel.fromJson(response);}catch(e){throw e;}
  }

  Future<BookingHistoryModel> bookingData(var access_token, var data)async{
    print("Access->$access_token");
    print("revive data->$data");
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiUrls.bookingHistoryUrls}", access_token, data);
    print("Response cart->$response");
    try{return response = BookingHistoryModel.fromJson(response);}catch(e){throw e;}
  }
}