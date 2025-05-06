import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fonofy/model/DeliveryPinCodeModel/DeliveryPinCodeModel.dart';

import '../BaseUrl/AllBaseUrl.dart';

class DeliveryPinCodeService {
  // static const String _baseUrl = 'https://track.delhivery.com/c/api/pin-codes/json/';
  static const String _tokenDelivery = 'af1dfea2064c40db6ad10d893fdc20e7bfc0b547';

  static Future<DeliveryPinCodeModel?> fetchPinCodeDetails(String pinCode) async {
    final url = '$deliveryPinCodeUrl?token=$_tokenDelivery&filter_codes=$pinCode';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("TokenDelivery: $_tokenDelivery PinCode: $pinCode");
        final jsonBody = json.decode(response.body);
        return DeliveryPinCodeModel.fromJson(jsonBody);
      } else {
        print('Failed to fetch pin code data: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while fetching pin code data: $e');
    }
    return null;
  }
}
