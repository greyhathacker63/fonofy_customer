import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferencesEmail {
  static const String _keyEmail = "Email";
  static const String _keyPassword = "Password";

  Future<void> saveUserCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
  }
  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }
  Future<String?> getUserPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword);
  }
}
