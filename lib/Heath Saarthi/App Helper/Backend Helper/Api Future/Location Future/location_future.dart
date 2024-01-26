import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Location%20Model/city_model.dart';
import '../../../Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../Api Urls/api_urls.dart';
import '../../Models/Location Model/area_model.dart';
import '../../Models/Location Model/branch_model.dart';
import '../../Models/Location Model/state_model.dart';

class LocationFuture{

  Future<List<StateData>> getState() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        ApiUrls.stateUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'connection': 'keep-alive',
          },
        ),
      );

      if (response.statusCode == 200) {
        StateModel stateModel = StateModel.fromJson(response.data);
        List<StateData>? stateList = stateModel.data;
        log("State List data ----> $stateList");
        return stateList ?? [];
      } else {
        throw Exception('Failed to fetch state list. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioError) {
        if (e.error is SocketException) {
          log("Socket exception: ${e.error.toString()}");
          GetXSnackBarMsg.getWarningMsg('Failed to connect to the server. \nPlease check your internet connection.');
          throw Exception('Failed to connect to the server. Please check your internet connection.');
        } else if (e.error is TimeoutException) {
          log("Timeout exception: ${e.error.toString()}");
          GetXSnackBarMsg.getWarningMsg('Request timed out. \nPlease try again.');
          throw Exception('Request timed out. Please try again.');
        } else {
          log("Dio unknown exception: ${e.toString()}");
          throw Exception('An unknown error occurred. Please try again.');
        }
      } else {
        log("Unknown exception: ${e.toString()}");
        throw Exception('An unknown error occurred. Please try again.');
      }
    }
  }

  Future<List<CityData>> getCity(var stateId) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        "${ApiUrls.cityUrl}$stateId",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'connection': 'keep-alive',
          },
        ),
      );
      if (response.statusCode == 200) {
        CityModel cityModel = CityModel.fromJson(response.data);
        List<CityData>? cityList = cityModel.data;
        print("City List -> $cityList");
        return cityList ?? [];
      } else {
        throw Exception('Failed to fetch city list. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioError) {
        if (e.error is SocketException) {
          log("Socket exception: ${e.error.toString()}");
          GetXSnackBarMsg.getWarningMsg('Failed to connect to the server. \nPlease check your internet connection.');
          throw Exception('Failed to connect to the server. Please check your internet connection.');
        } else if (e.error is TimeoutException) {
          log("Timeout exception: ${e.error.toString()}");
          GetXSnackBarMsg.getWarningMsg('Request timed out. \nPlease try again.');
          throw Exception('Request timed out. Please try again.');
        } else {
          log("Dio unknown exception: ${e.toString()}");
          throw Exception('An unknown error occurred. Please try again.');
        }
      } else {
        log("Unknown exception: ${e.toString()}");
        throw Exception('An unknown error occurred. Please try again.');
      }
    }
  }

  Future<List<AreaData>> getArea(var stateId, var cityId) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        "${ApiUrls.areaUrl}$stateId/$cityId",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'connection': 'keep-alive',
          },
        ),
      );
      if (response.statusCode == 200) {
        AreaModel areaModel = AreaModel.fromJson(response.data);
        List<AreaData>? areaList = areaModel.data;
        print("Area List -> $areaList");
        return areaList ?? [];
      } else {
        throw Exception('Failed to fetch area list. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioError) {
        if (e.error is SocketException) {
          log("Socket exception: ${e.error.toString()}");
          GetXSnackBarMsg.getWarningMsg('Failed to connect to the server. \nPlease check your internet connection.');
          throw Exception('Failed to connect to the server. Please check your internet connection.');
        } else if (e.error is TimeoutException) {
          log("Timeout exception: ${e.error.toString()}");
          GetXSnackBarMsg.getWarningMsg('Request timed out. \nPlease try again.');
          throw Exception('Request timed out. Please try again.');
        } else {
          log("Dio unknown exception: ${e.toString()}");
          throw Exception('An unknown error occurred. Please try again.');
        }
      } else {
        log("Unknown exception: ${e.toString()}");
        throw Exception('An unknown error occurred. Please try again.');
      }
    }
  }

  Future<List<BranchData>> getBranch(var stateId, var cityId, var areaId) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        "${ApiUrls.branchUrl}$stateId/$cityId/$areaId",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'connection': 'keep-alive',
          },
        ),
      );
      if (response.statusCode == 200) {
        BranchModel branchModel = BranchModel.fromJson(response.data);
        List<BranchData>? branchList = branchModel.data;
        print("Branch List -> $branchList");
        return branchList ?? [];
      } else {
        throw Exception('Failed to fetch branch list. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioError) {
        if (e.error is SocketException) {
          log("Socket exception: ${e.error.toString()}");
          GetXSnackBarMsg.getWarningMsg('Failed to connect to the server. \nPlease check your internet connection.');
          throw Exception('Failed to connect to the server. Please check your internet connection.');
        } else if (e.error is TimeoutException) {
          log("Timeout exception: ${e.error.toString()}");
          GetXSnackBarMsg.getWarningMsg('Request timed out. \nPlease try again.');
          throw Exception('Request timed out. Please try again.');
        } else {
          log("Dio unknown exception: ${e.toString()}");
          throw Exception('An unknown error occurred. Please try again.');
        }
      } else {
        log("Unknown exception: ${e.toString()}");
        throw Exception('An unknown error occurred. Please try again.');
      }
    }
  }
}