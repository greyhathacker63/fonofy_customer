import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:http/http.dart' as http;
 import '../../models/GetBuyNowModel/GetBuynowModel.dart';



class GetBuyNowService {
  Future<GetBuyNowModel?> fetchGetBuyNowData({
    required String customerId,
    required String cartRef,
  }) async {
    try {
      if (customerId.isEmpty || cartRef.isEmpty) {
        return null;
      }

      final uri = Uri.parse("$getBuyNowUrl?CustomerId=$customerId&CartRef=$cartRef");

      final response = await http.get(uri);

      if (response.statusCode == 200) {

        final jsonData = json.decode(response.body);

        if (jsonData is List && jsonData.isNotEmpty) {
          return GetBuyNowModel.fromJson(jsonData[0]);
        } else if (jsonData is Map<String, dynamic>) {
          return GetBuyNowModel.fromJson(jsonData);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}



