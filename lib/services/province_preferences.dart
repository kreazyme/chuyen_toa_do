import 'package:shared_preferences/shared_preferences.dart';

class ProvincePreferences {
  static const String _provinceKey = 'last_selected_province';

  /// Get the last selected province, returns default if not found
  static Future<String> getLastProvince() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_provinceKey) ?? 'VN2000_TP_HCM';
  }

  /// Save the selected province
  static Future<void> saveProvince(String province) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_provinceKey, province);
  }
}
