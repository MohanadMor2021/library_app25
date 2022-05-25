import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({ String key,  bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }
  static bool getBoolean ({ String key}){
    return sharedPreferences.getBool(key)??false;
  }
}
