import 'dart:convert';

import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:http/http.dart' as http;
class ApiController {

  static Future<Map<String, String>?> getHeaders() async {

    var token = await TokenHelper.getToken();

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }
  static Future<http.Response> get({required String url, bool isHeader = true})async{
    return await http.get(Uri.parse(url),headers: isHeader?await getHeaders():{});
  }
  static Future<http.Response> post({required String url, bool isHeader = true,required Map<String,dynamic> body})async{
    return await http.post(Uri.parse(url),headers: isHeader?await getHeaders():{},body: jsonEncode(body));
  }
  static Future<http.Response> put({required String url, bool isHeader = true,required Map<String,dynamic> body})async{
    return await http.put(Uri.parse(url),headers: isHeader?await getHeaders():{},body: jsonEncode(body));

  } static Future<http.Response> delete({required String url, bool isHeader = true})async{
    return await http.delete(Uri.parse(url),headers: isHeader?await getHeaders():{});
  }
}