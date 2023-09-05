import 'dart:convert';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Dashboard%20Model/Reports%20Model/day_report_model.dart';
import 'package:http/http.dart' as http;
import '../../Api Urls/api_urls.dart';
import '../../Models/Dashboard Model/Reports Model/month_report_model.dart';
import '../../Models/Dashboard Model/Reports Model/yers_report_model.dart';

class ChartFuture{
  Future<DayReportModel> fetchDayData(var accessToken, var monthYear) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
        Uri.parse(ApiUrls.dayReportUrls),
        headers: headers,
        body: {
          'month_year': monthYear.toString()
        }
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print("Day Data->$jsonResponse");
        return DayReportModel.fromJson(jsonResponse);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<MonthReportModel> fetchMonthData(var accessToken, var year) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
        Uri.parse(ApiUrls.monthReportUrls),
        headers: headers,
        body: {
          'year': year.toString()
        }
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print("Month Data->$jsonResponse");
        return MonthReportModel.fromJson(jsonResponse);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<YearsReportModel> fetchYearData(var accessToken, var fromDate, var toDate) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
        Uri.parse(ApiUrls.yearReportUrls),
        headers: headers,
        body: {
          'from_year': fromDate.toString(),
          'to_year': toDate.toString()
        }
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print("Year Data->$jsonResponse");
        return YearsReportModel.fromJson(jsonResponse);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}