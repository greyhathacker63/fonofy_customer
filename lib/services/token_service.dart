import 'dart:async';
import 'package:http/http.dart' as http;

class TokenService {
  static Timer? _refreshTimer;

  static void startTokenRefreshTimer() {
     const duration = Duration(minutes: 14);
    _refreshTimer = Timer.periodic(duration, (Timer t) async {
      await refreshToken();
    });
  }

  static void stopTokenRefreshTimer() {
    _refreshTimer?.cancel();
  }

  static Future<void> refreshToken() async {
    try {
      final response = await http.post(
        Uri.parse('https://your-api.com/refresh-token'),
        headers: {
          'Authorization': 'Bearer YOUR_REFRESH_TOKEN',
        },
      );

      if (response.statusCode == 200) {
      } else {
      }
    } catch (e, stack) {
    }
  }
}
