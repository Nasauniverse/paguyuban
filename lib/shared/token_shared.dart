import 'package:shared_preferences/shared_preferences.dart';

class TokenShared {
  static saveToken(String token) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('SHARED.TOKEN', token);
  }

  static getToken() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('SHARED.TOKEN');
    return token ?? '';
  }

  static deleteToken() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('SHARED.TOKEN');
  }
}
