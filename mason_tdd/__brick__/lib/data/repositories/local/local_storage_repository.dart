import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/data/models/user/user_info_store_model.dart';
import '/domain/failures/local/get_local_storage_failure.dart';
import '/domain/failures/local/remove_local_storage_failure.dart';
import '/domain/failures/local/set_local_storage_failure.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';

class LocalStorageRepository implements LocalStorageBaseApiService {
  @override
  Future<Either<SetLocalStorageFailure, bool>> setUserData({
    required UserInfoStoreModel userInfoStoreModel,
  }) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      String userJson = jsonEncode(userInfoStoreModel.toJson());
      await sp.setString('user_info', userJson);
      // await prefs.setString("token", mockLoginSuccessModel.token);
      return right(true);
    } catch (ex) {
      return left(SetLocalStorageFailure(error: ex.toString()));
    }
  }

  @override
  Future<Either<GetLocalStorageFailure, UserInfoStoreModel>>
  getUserData() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      String? userJson = sp.getString('user_info');
       if (userJson == null) {
        return right(UserInfoStoreModel.empty().copyWith());
      }
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return right(UserInfoStoreModel.fromJson(userMap));
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

  @override
  Future<Either<GetLocalStorageFailure, bool>> getBool({
    required String key,
  }) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      return right(sp.getBool(key) ?? false);
    } catch (ex) {
      return left(GetLocalStorageFailure(error: ex.toString()));
    }
  }

  @override
  Future<Either<SetLocalStorageFailure, bool>> setBool({
    required String key,
    required bool value,
  }) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setBool(key, value);
      return right(true);
    } catch (ex) {
      return left(SetLocalStorageFailure(error: ex.toString()));
    }
  }
}
