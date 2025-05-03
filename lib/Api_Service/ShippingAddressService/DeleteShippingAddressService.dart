import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../TokenHelper/TokenHelper.dart';
import '../../model/ShippingAddressModel/DeleteShippingAddressModel.dart';
import '../BaseUrl/AllBaseUrl.dart';

class DeleteAddressService {
  static Future<DeleteShippingAddressModel?> deleteAddress({
    required int id,
    required String shipmentId,
  }) async {
    try {
      String? token = await TokenHelper.getToken();
      if (token == null) {
        print('❌ Error: No authentication token found.');
        return null;
      }
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.parse("$deleteShippingUrl?Id=$id&ShippmentId=$shipmentId");
      var response = await http.get(url, headers: headers);
      print("🔍 Response body: ${response.body}");
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is List && decodedResponse.isNotEmpty) {
          return DeleteShippingAddressModel.fromJson(decodedResponse[0]);
        } else {
           return null;
        }
      } else {
        print("❌ Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Exception during delete: $e");
      return null;
    }
  }
}
