import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../../model/ShippingAddressModel/ListShippingAddressModel.dart';

class ListShippingAddressService {
  Future<List<ListShippingAddressModel>> listShippingAddress({
    required String customerId,
    required String token,
  }) async {
    final String apiUrl = 'https://api.fonofy.in/api/forb2c/list-shipping-address?CustomerId=$customerId';

    try {
      HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await httpClient.getUrl(Uri.parse(apiUrl));
      request.headers.set('Content-Type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');

      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(responseBody);
        return data.map((item) => ListShippingAddressModel.fromJson(item)).toList();
      } else {
        debugPrint("❌ API Error (${response.statusCode}): $responseBody");
        return [];
      }
    } catch (e) {
      debugPrint("❌ Exception in listShippingAddress: $e");
      return [];
    }
  }
}
