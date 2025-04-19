import 'dart:convert';
import 'dart:io';

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
    required String userCode,
  }) async {
    try {
      final String apiUrl = 'https://api.fonofy.in/api/forb2c/add-shipping-address';

      // ✅ Create HttpClient & Bypass SSL (for Development Only)
      final HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      // ✅ Create HTTP Request
      final HttpClientRequest request = await httpClient.postUrl(Uri.parse(apiUrl));

      // ✅ Set Headers
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');

      // ✅ Prepare Request Body
      final Map<String, dynamic> requestBody = {
        "Id": 0,
        "ShippmentId": "",
        "Name": name,
        "MobileNo": mobileNo,
        "CustomerId": userCode,
        "EmailId": emailId,
        "Address": address,
        "City": city,
        "State": state,
        "PinCode": pinCode,
        "WorkType": workType,
        "Isdefault": 1
      };
      request.add(utf8.encode(json.encode(requestBody)));

      // ✅ Send Request & Get Response
      final HttpClientResponse response = await request.close();
      final String responseBody = await response.transform(utf8.decoder).join();

      // ✅ Close HttpClient
      httpClient.close();

      // ✅ Handle Response
      if (response.statusCode == 200) {
        print('✅ Address inserted successfully: $responseBody');
        return true;
      } else {
        print('❌ Error ${response.statusCode}: $responseBody');
        return false;
      }
    } catch (e) {
      print('❗ Exception: $e');
      return false;
    }
  }
}
