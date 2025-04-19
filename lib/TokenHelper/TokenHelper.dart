import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {
  static const String _tokenKey = "token";
  static const String _UserCode = "UserCode";


    static Future<void> saveUserCode(String userCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_UserCode, userCode);
  }
    static Future<String?> getUserCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_UserCode);
  }

    static Future<String?> removeUserCode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_UserCode);
  }

  //token save
    static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }
    static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> changePasswordToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Delete both userCode and token
  static Future<void> deleteUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_UserCode);
    await prefs.remove(_tokenKey);
  }
}

