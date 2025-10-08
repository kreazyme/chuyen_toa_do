import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/coordinate.dart';

class HistoryService {
  static const String _historyKey = 'conversion_history';
  static const int _maxHistoryItems = 20;

  /// Save a conversion record to history
  static Future<void> saveConversion(ConversionRecord record) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();

    // Add new record at the beginning
    history.insert(0, record);

    // Limit history size
    if (history.length > _maxHistoryItems) {
      history.removeRange(_maxHistoryItems, history.length);
    }

    // Save to preferences
    final jsonList = history.map((r) => r.toJson()).toList();
    await prefs.setString(_historyKey, jsonEncode(jsonList));
  }

  /// Get all conversion history
  static Future<List<ConversionRecord>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_historyKey);

    if (jsonString == null) {
      return [];
    }

    try {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList
          .map(
            (json) => ConversionRecord.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Clear all history
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  /// Delete a specific record from history
  static Future<void> deleteRecord(ConversionRecord record) async {
    final history = await getHistory();
    history.removeWhere(
      (r) =>
          r.timestamp == record.timestamp &&
          r.vn2000.northing == record.vn2000.northing &&
          r.vn2000.easting == record.vn2000.easting,
    );

    final prefs = await SharedPreferences.getInstance();
    final jsonList = history.map((r) => r.toJson()).toList();
    await prefs.setString(_historyKey, jsonEncode(jsonList));
  }
}
