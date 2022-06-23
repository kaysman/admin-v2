import 'dart:convert';

import 'package:lng_adminapp/data/models/credentials.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage? _instance;
  static SharedPreferences? _preferences;

  // lazy initialization
  static Future<LocalStorage> get instance async {
    _instance = _instance ?? LocalStorage();
    _preferences = _preferences ?? await SharedPreferences.getInstance();
    return _instance!;
  }

  reload() async {
    await _preferences!.reload();
  }

  // GETTERS & SETTERS

  set credentials(Credentials? value) => _saveToDisk(
      'credentials', value == null ? '' : json.encode(value.toJson()));
  Credentials? get credentials {
    var credJson = _getFromDisk('credentials');
    if (credJson == null || credJson == '') return null;
    return Credentials.fromJson(json.decode(credJson));
  }

  set selectedUser(User? value) => _saveToDisk(
      'selectedUser', value == null ? '' : json.encode(value.toJson()));
  User? get selectedUser {
    var user = _getFromDisk('selectedUser');
    if (user == null || user == '') return null;
    return User.fromJson(json.decode(user));
  }

  // stores data using type-specific methods
  void _saveToDisk<T>(String key, T content) {
    try {
      if (content is String) {
        _preferences!.setString(key, content);
      } else if (content is bool) {
        _preferences!.setBool(key, content);
      } else if (content is int) {
        _preferences!.setInt(key, content);
      } else if (content is double) {
        _preferences!.setDouble(key, content);
      } else if (content is List<String>) {
        _preferences!.setStringList(key, content);
      } else if (content is DateTime) {
        _preferences!.setString(key, content.toIso8601String());
      } else {
        _preferences!.remove(key);
      }
    } catch (_) {
      throw _;
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    return value;
  }
}
