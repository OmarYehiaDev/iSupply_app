import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show PlatformException;

class CacheService {
  static SharedPreferences? _preferences;
  static CacheService? _instance;

  static CacheService getInstance() {
    _instance ??= CacheService();
    return _instance!;
  }

  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  bool has(String key) {
    assert(_preferences != null);
    return _preferences!.containsKey(key);
  }

  /// T is the  `runTimeType` data which you are trying to save (bool - String - double)
  Future<bool> saveData<T>(String key, T value) async {
    if (kDebugMode) {
      print("SharedPreferences: [Saving data] -> key: $key, value: $value");
    }
    assert(_instance != null);
    assert(_preferences != null);
    if (value is String) {
      return await _preferences!.setString(key, value);
    } else if (value is bool) {
      return await _preferences!.setBool(key, value);
    } else if (value is double) {
      return await _preferences!.setDouble(key, value);
    } else if (value is int) {
      return await _preferences!.setInt(key, value);
    } else {
      return false;
    }
  }

  getData(String key, {bool bypassValueChecking = true}) {
    assert(_preferences != null);
    assert(_instance != null);
    var value = _preferences!.get(key);
    if (value == null && !bypassValueChecking) {
      throw PlatformException(
          code: "SHARED_PREFERENCES_VALUE_CAN'T_BE_NULL",
          message: "you have ordered a value which doesn't exist in Shared Preferences",
          details: "make sure you have saved the value in advance in order to get it back");
    }
    if (kDebugMode) {
      print("SharedPreferences: [Reading data] -> key: $key, value: $value");
    }
    return value;
  }

  Future<bool> clearData(String key) async {
    assert(_preferences != null);
    assert(_instance != null);
    try {
      return await _preferences!.remove(key);
    } on Exception {
      rethrow;
    }
  }
}
