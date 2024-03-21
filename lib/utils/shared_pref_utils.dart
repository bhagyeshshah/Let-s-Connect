import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum SharedPrefKey {
  locale, //String
}
class SharedPrefUtils {

  static final SharedPrefUtils _singleton = SharedPrefUtils._internal();

  SharedPrefUtils._internal();

  static SharedPrefUtils get instance => _singleton;

  factory SharedPrefUtils() {
    return _singleton;
  }

  Future setValue({required SharedPrefKey key, var value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case String:
        prefs.setString(key.name, value);
        break;
      case int:
        prefs.setInt(key.name, value);
        break;
      case bool:
        prefs.setBool(key.name, value);
        break;
      case double:
        prefs.setDouble(key.name, value);
        break;
      default: 
        prefs.setString(key.name, value.toString());
        break;
    }
  }

  Future getValue({required SharedPrefKey key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key.name);
  }

  Future setJson({required SharedPrefKey key, required value})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key.name, jsonEncode(value));
  }

  Future<T?> getObjectOf<T>({required SharedPrefKey key, required T Function(Map<String, dynamic>) fromJson})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final stringObject = prefs.getString(key.name);
    if (stringObject == null) return null;
    final jsonObject = jsonDecode(stringObject) as Map<String, dynamic>;
    return fromJson(jsonObject);
  }

  clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}