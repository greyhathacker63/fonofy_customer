
import 'package:http/http.dart' as http;

import '../TokenHelper/TokenHelper.dart';

// class DeleteAccountService {
//   static const String _baseUrl = 'https://api.fonofy.in/api/forb2c';
//
//   static Future<bool> deleteMyAccount(String token, String userCode) async {
//     final url = Uri.parse('$_baseUrl/delete-account?CustomerId=$userCode');
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         print('Account deleted successfully');
//         await TokenHelper.deleteUserCode();
//         return true;
//       } else {
//         print('Failed to delete account. Status code: ${response.statusCode}');
//         print('ERROR: ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       print('Error occurred while deleting account: $e');
//       return false;
//     }
//   }
//
//   static Future<bool> deleteUserProfile(String userCode, String token) async {
//     final url = Uri.parse('https://api.fonofy.in/api/forb2c/delete-account?CustomerId=$userCode');
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         print('User deleted successfully');
//         return true;
//       } else {
//         print('Failed to delete user. Status: ${response.statusCode}');
//         print('Error: ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       print('Exception while deleting user: $e');
//       return false;
//     }
//   }
// }

class DeleteAccountService {
  // static const String _baseUrl = 'https://api.fonofy.in/api/forb2c';

  // static Future<bool> deleteUserProfile(String userCode, String token) async {
  //   final url = Uri.parse('$_baseUrl/delete-account?CustomerId=$userCode');
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('✅ Account deleted successfully');
  //       await TokenHelper.deleteUserCode();
  //       await TokenHelper.deleteToken();
  //       return true;
  //     } else {
  //       print('❌ Failed to delete account. Status: ${response.statusCode}');
  //       print('❌ Response: ${response.body}');
  //       return false;
  //     }
  //   } catch (e) {
  //     print('❌ Exception while deleting account: $e');
  //     return false;
  //   }
  // }
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



