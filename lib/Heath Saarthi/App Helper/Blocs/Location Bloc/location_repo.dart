import 'dart:convert';

import 'package:http/http.dart';

import '../../Backend Helper/Api Urls/api_urls.dart';
import '../../Backend Helper/Models/Location Model/state_model.dart';

class LocationRepo{
  String stateUrl = ApiUrls.stateUrl;

  Future<List<StateModel>> getState()async{
    Response response = await get(Uri.parse(stateUrl));

    if(response.statusCode == 200){
      final List stateResult = jsonDecode(response.body);
      return stateResult.map((e) => StateModel.fromJson(e)).toList();
    }
    else{
      throw Exception(response.reasonPhrase);
    }
  }
}