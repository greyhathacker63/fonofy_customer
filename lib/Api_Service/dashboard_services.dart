import 'dart:convert';
import 'dart:developer';

import 'package:fonofy/model/RamModel.dart';
import 'package:fonofy/services/web_constants.dart';
import 'package:http/http.dart' as http;

class DashboardServices {
  static Future<List<RamModel>> ramListData() async {
  var url = baseurl + common + ramList;

  var request = http.Request('GET', Uri.parse(url));
  log("Request: $url");

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var responseBody = await response.stream.bytesToString();
  var data = jsonDecode(responseBody);
  log("Response Data: $data");

  if (response.statusCode == 200) {
    return List<RamModel>.from(data.map((item) => RamModel.fromJson(item)));
  } else {
    throw Exception("Failed to fetch RAM list: ${response.reasonPhrase}");
  }
}
}
