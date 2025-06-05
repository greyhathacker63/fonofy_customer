import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../models/ListShippingAddressModel/ListShippingAddressModel.dart';

class ShippingService {

  final String baseUrl = "https://api.fonofy.in/api/forb2c";

  Future<List> getShippingAddress({
    required int id,
    required String shipmentId,
    required String token
  }) async {

    final String apiUrl = "$baseUrl/get-shipping-address?Id=$id&ShippmentId=$shipmentId";

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
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
