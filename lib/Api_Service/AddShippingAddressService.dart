import 'dart:convert';
import 'package:http/http.dart' as http;
import '../TokenHelper/TokenHelper.dart';

class AddShippingAddressService {
  Future<bool> addShippingAddress({
    required String name,
    required String mobileNo,
    required String emailId,
    required String address,
    required String city,
    required String state,
    required String pinCode,
    required String workType,
    required String token,
    required String userCode
  }) async {
    try {

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // ✅ API Request Body
      var body = json.encode({
        "Id": 0,
        "ShippmentId": "",
        "Name": name,
        "MobileNo": mobileNo,
        "CustomerId": userCode, // Using fetched userCode
        "EmailId": emailId,
        "Address": address,
        "City": city,
        "State": state,
        "PinCode": pinCode,
        "WorkType": workType,
        "Isdefault": 1
      });

      // ✅ Send HTTP POST Request
      var response = await http.post(
        Uri.parse('https://api.fonofy.in/api/forb2c/add-shipping-address'),
        headers: headers,
        body: body,
      );

      // ✅ Handle Response
      if (response.statusCode == 200) {
        print('✅ Address inserted successfully: ${response.body}');
        return true;
      } else {
        print('❌ Error ${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (e) {
      print('❗ Exception: $e');
      return false;
    }
  }
}
