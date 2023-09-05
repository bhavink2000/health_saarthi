import 'dart:convert';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Location%20Model/city_model.dart';
import 'package:http/http.dart' as http;
import '../../Api Urls/api_urls.dart';
import '../../Models/Location Model/area_model.dart';
import '../../Models/Location Model/branch_model.dart';
import '../../Models/Location Model/state_model.dart';

class LocationFuture{

  Future<List<StateData>> getState() async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.stateUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        StateModel stateModel = StateModel.fromJson(data);
        List<StateData>? stateList = stateModel.data;
        print("State List -> $stateList");
        return stateList ?? [];
      } else {
        throw Exception('Failed to fetch state list');
      }
    } catch (e) {
      print("Error -> $e");
      throw Exception('Failed to fetch state list');
    }
  }

  Future<List<CityData>> getCity(var stateId) async {
    try{
      final response = await http.get(
        Uri.parse("${ApiUrls.cityUrl}$stateId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
      );
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        CityModel cityModel = CityModel.fromJson(data);
        List<CityData>? cityList = cityModel.data;
        print("city List ->$cityList");
        return cityList ?? [];
      }
      else{
        throw Exception('Failed to fetch state list');
      }
    }
    catch(e){
      print("Error -> $e");
      throw Exception('Failed to fetch City list');
    }
  }

  Future<List<AreaData>> getArea(var stateId, var cityId) async {
    try{
      final response = await http.get(
          Uri.parse("${ApiUrls.areaUrl}$stateId/$cityId"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        AreaModel areaModel = AreaModel.fromJson(data);
        List<AreaData>? areaList = areaModel.data;
        print("area List ->$areaList");
        return areaList ?? [];
      }
      else{
        throw Exception('Failed to fetch state list');
      }
    }
    catch(e){
      print("Error -> $e");
      throw Exception('Failed to fetch Area list');
    }
  }

  Future<List<BranchData>> getBranch(var stateId, var cityId, var areaId) async {
    try{
      final response = await http.get(
          Uri.parse("${ApiUrls.branchUrl}$stateId/$cityId/$areaId"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        BranchModel branchModel = BranchModel.fromJson(data);
        List<BranchData>? branchList = branchModel.data;
        print("branch List ->$branchList");
        return branchList ?? [];
      }
      else{
        throw Exception('Failed to fetch state list');
      }
    }
    catch(e){
      print("Error -> $e");
      throw Exception('Failed to fetch Area list');
    }
  }
}