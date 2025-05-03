import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:http/http.dart' as http;
import '../../model/AddToCartModel/GetBuynowModel.dart';

class GetBuyNowService {
  Future<List<GetBuyNowModel>?> fetchGetBuyNowData({required String customerId}) async {
    try {
      final url = Uri.parse('$getBuyNowUrl?CustomerId=$customerId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return getBuyNowModelFromJson(response.body);
      } else {
        print("❌ HTTP Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return null;
    }
  }
}
