import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:http/http.dart' as http;
 import '../../model/AddToCartModel/GetBuynowModel.dart';

// class GetBuyNowService {
//
//   Future<List<GetBuyNowModel>?> fetchGetBuyNowData({required String customerId, required String cartRef,}) async {
//     try {
//       final uri = Uri.parse("$getBuyNowUrl?CustomerId=$customerId&CartRef=$cartRef");
//       final response = await http.get(uri);
//
//       if (response.statusCode == 200) {
//
//         return getBuyNowModelFromJson(response.body);
//       } else {
//         print("❌ HTTP Error: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("❌ Exception: $e");
//       return null;
//     }
//   }
// }

class GetBuyNowService {
  Future<GetBuyNowModel?> fetchGetBuyNowData({
    required String customerId,
    required String cartRef,
  }) async {
    try {
      if (customerId.isEmpty || cartRef.isEmpty) {
        print("🚫 customerId or cartRef is empty");
        return null;
      }

      final uri = Uri.parse("$getBuyNowUrl?CustomerId=$customerId&CartRef=$cartRef");
      print("📤 Hitting URL: $uri");

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        print("✅ API Success");
        print("📩 Response: ${response.body}");

        final jsonData = json.decode(response.body);

        if (jsonData is List && jsonData.isNotEmpty) {
          return GetBuyNowModel.fromJson(jsonData[0]);
        } else if (jsonData is Map<String, dynamic>) {
          return GetBuyNowModel.fromJson(jsonData);
        } else {
          print("❌ Unexpected JSON format");
          return null;
        }
      } else {
        print("❌ HTTP Error: ${response.statusCode}");
        print("❌ Body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Exception during fetch: $e");
      return null;
    }
  }
}



