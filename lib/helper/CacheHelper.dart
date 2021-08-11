import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CacheHelper{
  static SharedPreferences? sharedPreferences1;
  static init() async{
    sharedPreferences1=await SharedPreferences.getInstance();
  }
  static Future<bool> putbool({required String key,required bool value}) async{
    return sharedPreferences1!.setBool(key, value);
  }

  static bool? getbool({required String key}){
    return sharedPreferences1!.getBool(key);

  }
}