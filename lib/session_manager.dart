import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<void> saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('twitterUserToken', token);
  }

  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('twitterUserToken');
  }

  static Future<void> clearUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('twitterUserToken');
  }
}
