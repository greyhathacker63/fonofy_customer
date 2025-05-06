import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Services/web_constants.dart';
import '../../model/AddToCartModel/CreateOrderModel.dart';
import '../BaseUrl/AllBaseUrl.dart';

// class CreateOrderService {
//
//   static Future<bool> createOrder(CreateOrderModel createModel) async {
//     try {
//       final response = await http.post(Uri.parse(createOrderUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(createModel.toJson()),
//       );
//
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         if (jsonData["status"] == true || jsonData["Status"] == true) {
//           return true;
//         } else {
//           print("Server returned error: ${jsonData["message"]}");
//         }
//       } else {
//         print("HTTP Error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Exception in createOrder: $e");
//     }
//     return false;
//   }
// }

class CreateOrderService {
  Future<List<CreateOrderModel>> fetchCreateOrderData({
    required String customerId,
    required String shippingId,
    required String name,
    required String mobileNo,
    required String emailId,
    required String address,
    required String city,
    required String state,
    required String pincode,
    required String workType,
  }) async {
    try {
      var url = Uri.parse(productDetailsUrl);
      final Map<String, dynamic> requestBody = {
        "CustomerId": customerId,
        "ShippingId": shippingId,
        "Name": name,
        "Address": address,
        "EmailId": emailId,
        "MobileNo": mobileNo,
        "City": city,
        "State": state,
        "Pincode": pincode,
        "WorkType": workType,
      };

      var response = await http.post(url, headers: headers,
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is List) {
          return decodedResponse
              .map((item) => CreateOrderModel.fromJson(item))
              .toList();
        } else {
          print("❌ Error: Unexpected data format");
          return [];
        }
      } else {
        print('❌ Error: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('❌ Exception: $e');
      return [];
    }
  }
}
