//@dart=2.9
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../Api Urls/api_urls.dart';

class LocationProvider with ChangeNotifier {
  String selectedState;
  List<dynamic> stateList = [];

  String selectedCity;
  List<dynamic> cityList = [];

  String selectedArea;
  List<dynamic> areaList = [];

  String selectedBranch;
  List<dynamic> branchList = [];

  Future<void> getStateList() async {
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
        stateList = data['data'];
        print("StateList -> $stateList");
        notifyListeners();
      } else {
        // Handle API error here
      }
    } catch (e) {
      // Handle network or other errors here
    }
  }
  Future<void> getCityList() async {
    await http.get(Uri.parse(ApiUrls.cityUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      cityList = data['data'];
      print("CityList ->$cityList");
      notifyListeners();
    });
  }
  Future<void> getAreaList() async {
    await http.get(Uri.parse(ApiUrls.areaUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      areaList = data['data'];
      print("AreaList -> $areaList");
      notifyListeners();
    });
  }
  Future<void> getBranchList() async {
    await http.get(Uri.parse(ApiUrls.branchUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      branchList = data['data'];
      print("BranchList -> $branchList");
      notifyListeners();
    });
  }
}