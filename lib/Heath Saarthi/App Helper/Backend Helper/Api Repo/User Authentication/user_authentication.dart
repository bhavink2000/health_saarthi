
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import '../../Api Service/api_service_post_get.dart';
import '../../Api Service/api_service_type_post_get.dart';

class UserAuthentication {
  ApiServicesTypePostGet apiServicesTypePostGet = ApiServicePostGet();

  Future<dynamic> loginApi(dynamic data)async{
    try{
      dynamic response = await apiServicesTypePostGet.postApiResponse(ApiUrls.loginUrl, data);
      return response;
    }catch(e){
      print("Login Error->$e");
      throw e;
    }
  }
}