import 'dart:convert';
import 'dart:developer';

import 'package:fonofy/model/RamModel.dart';
import 'package:fonofy/services/web_constants.dart';
import 'package:http/http.dart' as http;

class DashboardServices {
  static Future<RamModel> ramListData(
      ) async {
    var url = baseurl + common + ramList;

    var request = http.Request('GET', Uri.parse(url));
    log(request.toString());

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    log(data.toString());

    if (response.statusCode == 200) {
      return RamModel.fromJson(data);
    } else {
      return RamModel.fromJson(data);
    }
  }
}
