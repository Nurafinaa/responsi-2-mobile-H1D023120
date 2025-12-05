import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  // Simpan token
  Future<bool> setToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString("token", value);
  }

  // Ambil token
  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  // Simpan userID
  Future<bool> setUserID(int value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setInt("userID", value);
  }

  // Ambil userID
  Future<int?> getUserID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("userID");
  }

  // Simpan nama user
  Future<bool> setNama(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString("nama", value);
  }

  // Ambil nama user
  Future<String?> getNama() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("nama");
  }

  // Simpan email user
  Future<bool> setEmail(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString("email", value);
  }

  // Ambil email user
  Future<String?> getEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("email");
  }

  // Logout / clear semua data
  Future<bool> logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.clear();
  }
}
