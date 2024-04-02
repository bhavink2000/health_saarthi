import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiHelper{
  static Future<Map<String, dynamic>> filterPostData(String url, dynamic data) async {
    final response = await http.post(Uri.parse(url), body: data);

    final prefix = 'ï»¿';

    // Remove prefix if present
    var body = response.body;
    if (body.startsWith(prefix)) {
      body = body.substring(prefix.length);
    }

    // Decode JSON
    final decodedBody = json.decode(body);

    return decodedBody;
  }
}

