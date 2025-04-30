import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {
  static const String _tokenKey = "token";
  static const String _userCodeKey = "UserCode";

  // Save User Code (mobile number)
  static Future<void> saveUserCode(String userCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userCodeKey, userCode);
  }

  // Get User Code (mobile number)
  static Future<String?> getUserCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userCodeKey);
  }

  // Remove User Code (mobile number)
  static Future<String?> removeUserCode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userCodeKey);
  }

  // Save Token (JWT token)
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }
  static Future<String?> changePasswordToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Get Token (JWT token)
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Remove Token
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Delete both userCode and token
  static Future<void> deleteUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userCodeKey);
    await prefs.remove(_tokenKey);
  }

  // Check if the Token has expired
  static bool isTokenExpired(String token) {
    try {
      var decodedToken = _decodeToken(token);
      var exp = decodedToken['exp']; // Assuming 'exp' is the expiry time in seconds
      var expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return expiryDate.isBefore(DateTime.now());
    } catch (e) {
      return true; // If decoding fails, assume expired
    }
  }

  // Decode JWT Token (optional method for checking expiry)
  static Map<String, dynamic> _decodeToken(String token) {
    var parts = token.split('.');
    if (parts.length == 3) {
      String payload = parts[1];
      String normalized = _base64UrlDecode(payload);
      return jsonDecode(normalized);
    }
    throw FormatException("Invalid JWT token format");
  }
  

  // Base64 URL Decode
  static String _base64UrlDecode(String input) {
    String normalized = input.replaceAll('-', '+').replaceAll('_', '/');
    switch (normalized.length % 4) {
      case 2:
        normalized += '==';
        break;
      case 3:
        normalized += '=';
        break;
    }
    return utf8.decode(base64Url.decode(normalized));
  }
}
