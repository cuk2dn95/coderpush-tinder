import 'package:shared_preferences/shared_preferences.dart';

class Database {
  Database() {
    SharedPreferences.getInstance().then((value) => _pref = value);
  }

  late SharedPreferences _pref;

  void saveMapEntry(MapEntry<String, dynamic> entry) {
    final value = entry.value;
    final key = entry.key;
    if (value is int) {
      _pref.setInt(key, value);
    }
    if (value is bool) {
      _pref.setBool(key, value);
    }
    if (value is double) {
      _pref.setDouble(key, value);
    }
    if (value is String) {
      _pref.setString(key, value);
    }

    if (value is List<String>) {
      _pref.setStringList(key, value);
    }

    throw Exception('not support type');
  }

  T? getValue<T>(String key) {
    if (T is List<String>) {
      return _pref.getStringList(key) as T?;
    }

    return _pref.get(key) as T?;
  }
}
