import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/domain/repositories/local/local_storage_base_api_service.dart';
{{#auth}}
import '/domain/entities/local/mock_local_user_info_store_model.dart';
import 'dart:convert';
import '/domain/failure/local/remove_local_storage_failure.dart';
{{/auth}}

import '/domain/failure/local/get_local_storage_failure.dart';
import '/domain/failure/local/set_local_storage_failure.dart';

class InsecureLocalStorageRepository implements LocalStorageRepository {
  {{#auth}}
  @override
  Future<Either<SetLocalStorageFailure, bool>> setUserData(
      {required MockLocalUserInfoStoreModel mockLocalUserInfoStoreModel}) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      String userJson = jsonEncode(mockLocalUserInfoStoreModel.toJson());
      await sp.setString('user_info', userJson);
      // await prefs.setString("token", mockLoginSuccessModel.token);
      return right(true);
    } catch (ex) {
      return left(SetLocalStorageFailure(error: ex.toString()));
    }
  }

  @override
  Future<Either<GetLocalStorageFailure, MockLocalUserInfoStoreModel>>
      getUserData() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      String? userJson = sp.getString('user_info');
      if (userJson == null) {
        return right(MockLocalUserInfoStoreModel.empty().copyWith());
      }

      Map<String, dynamic> userMap = jsonDecode(userJson);
      return right(MockLocalUserInfoStoreModel.fromJson(userMap));
      // return right(MockLoginSuccessModel.empty()
      //     .copyWith(token: prefs.getString("token")));
    } catch (ex) {
      return left(GetLocalStorageFailure(error: ex.toString()));
    }
  }

  @override
  Future<Either<RemoveLocalStorageFailure, bool>> removeUserData() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.remove("user_info");
      return right(true);
    } catch (ex) {
      return left(RemoveLocalStorageFailure(error: ex.toString()));
    }
  }
{{/auth}}
  @override
  Future<Either<GetLocalStorageFailure, bool>> getBool(
      {required String key}) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      return right(sp.getBool(key) ?? false);
    } catch (ex) {
      return left(GetLocalStorageFailure(error: ex.toString()));
    }
  }

  @override
  Future<Either<SetLocalStorageFailure, bool>> setBool(
      {required String key, required bool value}) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setBool(key, value);
      return right(true);
    } catch (ex) {
      return left(SetLocalStorageFailure(error: ex.toString()));
    }
  }
}
