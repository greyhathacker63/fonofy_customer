import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/models/RepairServicesTableModel/RepairServicesTableModel.dart';
import 'package:http/http.dart' as http;

import '../../../services/web_constants.dart';
import '../../BaseUrl/AllBaseUrl.dart';


// class RepairTableService {
//
//   static Future<RepairServicesTableModel> fetchRepairTableData(String brandId , String productId,String colorId) async {
//     var url = repairTableUrl ;
//     var request = http.Request('GET', Uri.parse(url));
//     log(request.toString());
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//     var data = jsonDecode(await response.stream.bytesToString());
//     // print("$data");
//     if (response.statusCode == 200) {
//       return RepairServicesTableModel.fromJson(data);
//     } else {
//       return RepairServicesTableModel.fromJson(data);
//     }
//   }
// }

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
      log('Request: $request');

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      log('Response: $responseBody');

      final data = jsonDecode(responseBody);
      return RepairServicesTableModel.fromJson(data);
    } catch (e) {
      log('Error fetching repair table data: $e');
      rethrow;
    }
  }
}

