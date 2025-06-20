// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../../TokenHelper/TokenHelper.dart';
// import '../../../model/RepairModel/CancelRepairOrderModel.dart';
// import '../../BaseUrl/AllBaseUrl.dart';
//
// class CancelRepairOrderService {
//   static Future<CancelRepairOrderModel?> cancelRepairOrder({
//     required String orderId,
//     required String customerId,
//     required String reasone,
//     required dynamic reasonId,
//     required String reasonRemark,
//   }) async {
//     final token = await TokenHelper.getToken();
//
//     try {
//       final response = await http.post(
//         Uri.parse(cancelRepairOrderUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({
//           "OrderId": orderId,
//           "CustomerId": customerId,
//           "Reason": reasone,
//           "ReasonId": reasonId,
//           "ReasonRemark": reasonRemark,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return CancelRepairOrderModel.fromJson(data);
//       } else {
//         print("Cancel Error: ${response.statusCode} => ${response.body}");
//         return null;
//       }
//     } catch (e) {
//       print("Cancel Exception: $e");
//       return null;
//     }
//   }
// }


import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../TokenHelper/TokenHelper.dart';
import '../../../model/RepairModel/CancelRepairOrderModel.dart';
import '../../BaseUrl/AllBaseUrl.dart';

class CancelRepairOrderService {
  static Future<CancelRepairOrderModel?> cancelRepairOrder({
    required String orderId,
    required String customerId,
    required String reasone,
    required dynamic reasonId,
    required String reasonRemark,

  }) async {
    final token = await TokenHelper.getToken();

    try {
      final response = await http.post(
        Uri.parse(cancelRepairOrderUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "OrderId": orderId,
          "CustomerId": customerId,
          "Reason": reasone,
          "ReasonId": reasonId,
          "ReasonRemark": reasonRemark,
        }),
      );

      if (response.statusCode == 200) {
        final body = response.body;

        try {
          final dynamic decoded = json.decode(body);

          if (decoded is Map<String, dynamic>) {
            return CancelRepairOrderModel.fromJson(decoded);
          } else if (decoded is String) {
            return CancelRepairOrderModel(message: decoded);
          } else {
            print("Unexpected cancel response: $decoded");
            return null;
          }
        } catch (e) {
          print("Decode Error: $e");
          return null;
        }
      } else {
        print("Cancel Failed: ${response.statusCode} => ${response.body}");
        return null;
      }
    } catch (e) {
      print("Cancel Exception: $e");
      return null;
    }
  }
}

