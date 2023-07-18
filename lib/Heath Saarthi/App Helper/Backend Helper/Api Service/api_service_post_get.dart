
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../App Exceptions/app_exceptions.dart';
import 'api_service_type_post_get.dart';

class ApiServicePostGet extends ApiServicesTypePostGet{

  @override
  Future getApiResponse(String url)async {
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url),);
      responseJson = returnResponse(response);
    }on SocketMessage{
      throw FetchDataException(message: "");
    }
    return responseJson;
  }

  @override
  Future postApiResponse(String url, data)async {
    dynamic responseJson;
    try {
      http.Response response = await http.post(Uri.parse(url), body: data);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "");
    }
    return responseJson;
  }

  @override
  Future aftergetApiResponse(String url, access_token)async {
    dynamic responseJson;
    try{
      final response = await http.get(
          Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $access_token',
        },
      ).timeout(Duration(seconds: 5));
      responseJson = returnResponse(response);
    }on SocketMessage{
      throw FetchDataException(message: "");
    }
    return responseJson;
  }

  @override
  Future afterpostApiResponse(String url, access_token, data)async {
    dynamic responseJson;
    try {
      http.Response response = await http.post(
          Uri.parse(url),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $access_token',
          },
          body: data
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response){
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(message: response.body.toString());
      case 401:
        throw UnAuthorizedException(message: response.body.toString());
      default:
        throw FetchDataException(
            message: " Error occurred while communicating with server " +
                " with status code " + response.statusCode.toString()
        );
    }
  }

}