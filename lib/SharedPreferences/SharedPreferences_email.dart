import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferencesEmail {
  static const String _emailKey = "email";
  static const String _passwordKey = "password";

  Future<void> saveUserCredentials(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
  }
  Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }
  Future<String?> getUserPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_passwordKey);
  }
}
