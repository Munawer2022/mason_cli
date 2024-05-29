import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/model/local/local_user_info_store_model.dart';

class InsecureLocalStorage extends ChangeNotifier {
  Future<bool> saveUserInfo({required LocalUserInfoStoreModel userInfo}) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String userJson = jsonEncode(userInfo.toJson());
    sp.setString('user_info', userJson);
    notifyListeners();
    return true;
  }

  Future<LocalUserInfoStoreModel> getUserInfo() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? userJson = sp.getString('user_info');
    if (userJson == null) {
      return LocalUserInfoStoreModel.empty();
    }

    Map<String, dynamic> userMap = jsonDecode(userJson);
    return LocalUserInfoStoreModel.fromJson(userMap);
  }

  Future<bool> removeUserInfo() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('user_info');
    notifyListeners();
    return true;
  }

  Future<bool> getBool({required String key}) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(key) ?? false;
  }

  Future<bool> setBool({required String key, required bool value}) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool(key, value);
    return true;
  }
}
