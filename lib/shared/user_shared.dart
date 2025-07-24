import 'package:shared_preferences/shared_preferences.dart';

class UserShared {
  static getDataUser() async {
    var prefs = await SharedPreferences.getInstance();
    var saveData = prefs.getString('SHARED.USER');
    saveData ??= '';
    return saveData;
  }

  static saveDatauser(data) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('SHARED.USER', data);
  }

  static deleteDataUser() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('SHARED.USER', "");
  }
}
