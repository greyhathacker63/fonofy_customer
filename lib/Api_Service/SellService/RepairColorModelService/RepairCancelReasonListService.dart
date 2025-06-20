import 'dart:convert';
import 'dart:developer';

import '../../../TokenHelper/TokenHelper.dart';
import 'package:http/http.dart' as http;

import '../../../model/RepairModel/RepairCancelReasonListModel.dart';
import '../../BaseUrl/AllBaseUrl.dart';

class RepairCancelReasonListService {
  static Future<RepairCancelReasonListModel> fetchRepairCancelReasonData() async {
    try {
      final token = await TokenHelper.getToken();
      final url = repairCancelReasonListUrl;
      final request = http.Request('GET', Uri.parse(url));

       request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      log("Request URL: $url");
      log("Request Headers: ${request.headers}");

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);

      print("Response: $data");

      if (response.statusCode == 200) {
        return RepairCancelReasonListModel.fromJson(data);
      } else {
        return RepairCancelReasonListModel.fromJson(data);
      }
    } catch (e) {
      log("Error in fetchRepairCancelReasonData: $e");
      rethrow;
    }
  }
}
