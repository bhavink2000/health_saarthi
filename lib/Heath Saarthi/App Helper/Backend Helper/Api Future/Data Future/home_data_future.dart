import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Dashboard%20Model/banner_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Dashboard%20Model/today_deal_details_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Dashboard%20Model/today_deal_model.dart';
import 'package:http/http.dart' as http;
import '../../../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../../Frontend Helper/Text Helper/test_helper.dart';
import '../../Api Urls/api_urls.dart';

class HomeDataFuture extends GetxController{
  final box = GetStorage();
  getHeader(){
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('accessToken')}',
    };
  }

  @override
  void onInit() {
    super.onInit();
  }


  Rx<BannerModel> bannerModel = BannerModel().obs;
  RxBool bannerLoad = false.obs;
  Future<void> fetchBanner() async {
    bannerLoad(true);
    try {
      final response = await http.post(
          Uri.parse('${ApiUrls.bannerUrls}'),
          headers: getHeader(),
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 200) {
          bannerModel.value = BannerModel.fromJson(responseBody);
          bannerLoad(false);
        }
        else if(responseBody['status'] == 402){
          bannerLoad(false);
          throw Exception(responseBody['status']);
        }
      }
      else if(response.statusCode == 500){
        bannerLoad(false);
        GetXSnackBarMsg.getWarningMsg(AppTextHelper().internalServerError);
        throw Exception(response.statusCode);
      }
      else {
        log('something went wrong in fetch banner status code -> ${response.statusCode}');
        bannerLoad(false);
      }
    } catch (e) {
      log('error in fetch banner $e');
      bannerLoad(false);
    }
  }


  Rx<TodayDealModel> todayDeal = TodayDealModel().obs;
  RxBool todayDealLoad = false.obs;
  Future<void> fetchTodayDeal() async{
    todayDealLoad(true);
    try{
      final response = await http.post(
        Uri.parse(ApiUrls.todayDealUrls),
        headers: getHeader()
      );
      if(response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        if(responseBody['status'] == 200){
          todayDeal.value = TodayDealModel.fromJson(responseBody);
          todayDealLoad(false);
        }
        else if(responseBody['status'] == 402){
          todayDealLoad(false);
          throw Exception(responseBody['status']);
        }
      }
      else if(response.statusCode == 500){
        GetXSnackBarMsg.getWarningMsg('${AppTextHelper().internalServerError}');
        todayDealLoad(false);
      }
      else{
        log('something went wrong in fetch todayDeal status code -> ${response.statusCode}');
        todayDealLoad(false);
      }
    }catch(e){
      log('error in fetch today deals ->$e');
      todayDealLoad(false);
    }
  }

  Rx<TodayDealDetailsModel> tDealDetails = TodayDealDetailsModel().obs;
  RxBool tDealDetailsLoad = false.obs;
  Future<void> fetchTodayDealDetails(dealId) async{
    tDealDetailsLoad(true);
    try{
      final response = await http.post(
        Uri.parse(ApiUrls.todayDealDetailsUrls),
        headers: getHeader(),
        body: {
          'id': dealId,
        }
      );
      if(response.statusCode == 200){
       var responseBody = jsonDecode(response.body);
       if(responseBody['status'] == 200){
         tDealDetails.value = TodayDealDetailsModel.fromJson(responseBody);
         tDealDetailsLoad(false);
       }
       else if(responseBody['status'] == 402){
         tDealDetailsLoad(false);
         throw Exception(responseBody['status']);
       }
      }
      else if(response.statusCode == 500){
        GetXSnackBarMsg.getWarningMsg('${AppTextHelper().internalServerError}');
        tDealDetailsLoad(false);
      }
      else{
        log('something went wrong in fetch todayDeal status code -> ${response.statusCode}');
        tDealDetailsLoad(false);
      }
    }
    catch(e){
      log('error in fetch today deals details -->>$e');
      tDealDetailsLoad(false);
    }
  }


}