import 'dart:convert';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/models/TrackingModel/TrackingModel.dart';
import 'package:http/http.dart' as http;
import '../services/web_constants.dart';

class TrackingService {
  static Future<List<TrackingModel>> getTrackingData(String orderId, String customerId) async {
    final token = await TokenHelper.getToken();

    if (customerId.isEmpty || orderId.isEmpty) {
      throw Exception("OrderId or CustomerId is missing");
    }

    final url = Uri.parse('$baseurl$b2c$tracking?OrderId=$orderId&CustomerId=$customerId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((item) => TrackingModel.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load tracking data");
    }
  }
}
