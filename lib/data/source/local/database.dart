import 'package:shared_preferences/shared_preferences.dart';

class Database {
  Database() {
    SharedPreferences.getInstance().then((value) => pref = value);
  }
  late SharedPreferences pref;

  void saveMapEntry(MapEntry<String, dynamic> entry) {
    final value = entry.value;
    final key = entry.key;
    if(value is int) {
      pref.setInt(key, value);
    }
    if(value is bool) {
      pref.setBool(key, value);
    }
    if(value is double) {
      pref.setDouble(key, value);
    }
    if(value is String) {
      pref.setString(key, value);
    }

    if(value is List<String>) {
      pref.setStringList(key, value);
    }

    throw  Exception('not support type');
  }

  T? getValue<T>(String key) {
    if(T is List<String>) {
      return pref.getStringList(key) as T?;
    }

    return pref.get(key) as T?;
  }
}