
import 'package:http/http.dart' as http;


class DeleteAccountService {
   static const String _baseUrl = 'https://api.fonofy.in/api/forb2c';
  static Future<bool> deleteUserProfile(String token, String userCode) async {
    final url = Uri.parse('$_baseUrl/delete-account?CustomerId=$userCode');


    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

}



