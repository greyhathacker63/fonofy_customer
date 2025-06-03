
import 'package:http/http.dart' as http;


class DeleteAccountService {
   static const String _baseUrl = 'https://api.fonofy.in/api/forb2c';
  static Future<bool> deleteUserProfile(String token, String userCode) async {
    final url = Uri.parse('$_baseUrl/delete-account?CustomerId=$userCode');

    print('📡 DELETE Request URL: $url');
    print('🛂 Token: $token');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('🔁 Status Code: ${response.statusCode}');
      print('🔁 Response Body: ${response.body}');

      return response.statusCode == 200;
    } catch (e) {
      print('❌ Exception while deleting account: $e');
      return false;
    }
  }

}



