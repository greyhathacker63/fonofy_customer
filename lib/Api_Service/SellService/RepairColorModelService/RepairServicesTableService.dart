import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/models/RepairServicesTableModel/RepairServicesTableModel.dart';
import 'package:http/http.dart' as http;

import '../../../services/web_constants.dart';
import '../../BaseUrl/AllBaseUrl.dart';




class RepairTableService {
  static Future<RepairServicesTableModel> fetchRepairTableData(String bid, String pid, String cid,) async {
    try {
       final uri = Uri.parse(repairTableUrl).replace(queryParameters: {
        'bid': bid,
        'pid': pid,
        'cid': cid,
      });

      final request = http.Request('GET', uri);
      request.headers.addAll(headers);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      final data = jsonDecode(responseBody);
      return RepairServicesTableModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}

