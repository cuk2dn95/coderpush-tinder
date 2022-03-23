import 'package:shared_preferences/shared_preferences.dart';

class Database {
  Database(SharedPreferences sharedPreferences) {
    _pref = sharedPreferences;
  }

  late SharedPreferences _pref;

  Future<void> saveMapEntry(MapEntry<String, dynamic> entry) async {
    final value = entry.value;
    final key = entry.key;
    if (value is int) {
      await _pref.setInt(key, value);
      return;
    }
    if (value is bool) {
      await _pref.setBool(key, value);
      return;
    }
    if (value is double) {
      await _pref.setDouble(key, value);
      return;
    }
    if (value is String) {
      await _pref.setString(key, value);
      return;
    }

    if (value is List<String>) {
      await _pref.setStringList(key, value);
      return;
    }

    throw Exception('not support type, $value');
  }

  T? getValue<T>(String key) {
    if (T is List<String>) {
      return _pref.getStringList(key) as T?;
    }

    return _pref.get(key) as T?;
  }
}
