import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/domain/repositories/local/local_storage_base_api_service.dart';
{{#auth}}
import '/domain/entities/auth/login/mock_login_success_model.dart';
{{/auth}}

import '/domain/failure/local/get_local_storage_failure.dart';
import '/domain/failure/local/remove_local_storage_failure.dart';
import '/domain/failure/local/set_local_storage_failure.dart';
class InsecureLocalStorageRepository implements LocalStorageRepository {
  {{#auth}}
  @override
  Future<Either<SetLocalStorageFailure, bool>> setUserData(
      {required MockLoginSuccessModel mockLoginSuccessModel}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", mockLoginSuccessModel.token);
      return right(true);
    } catch (ex) {
      return left(SetLocalStorageFailure(error: ex.toString()));
    }
  }

  @override
  Future<Either<GetLocalStorageFailure, MockLoginSuccessModel>>
      getUserData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return right(MockLoginSuccessModel.empty()
          .copyWith(token: prefs.getString("token")));
    } catch (ex) {
      return left(GetLocalStorageFailure(error: ex.toString()));
    }
  }

  @override
  Future<Either<RemoveLocalStorageFailure, bool>> removeUserData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return right(prefs.getBool(key) ?? false);
    } catch (ex) {
      return left(GetLocalStorageFailure(error: ex.toString()));
    }
  }

  @override
  Future<Either<SetLocalStorageFailure, bool>> setBool(
      {required String key, required bool value}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
      return right(true);
    } catch (ex) {
      return left(SetLocalStorageFailure(error: ex.toString()));
    }
  }
}
