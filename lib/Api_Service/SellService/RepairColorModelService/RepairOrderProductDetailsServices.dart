
import 'package:http/http.dart' as http;
import 'package:fonofy/model/RepairModel/RepairOrderProductDetailsModel.dart';

import '../../BaseUrl/AllBaseUrl.dart';

class RepairOrderProductDetailsService {
  static Future<RepairOrderProductDetailsModel> fetchRepairOrderProductDetails({
    required String orderId,
    required String customerId,
    required String token,
  }) async {
    final uri = Uri.parse('$repairOrderProductDetailsUrl?OrderId=$orderId&CustomerId=$customerId');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return repairOrderProductDetailsModelFromJson(response.body);
    } else {
      throw Exception('Failed to load order product details: ${response.body}');
    }
  }
}
