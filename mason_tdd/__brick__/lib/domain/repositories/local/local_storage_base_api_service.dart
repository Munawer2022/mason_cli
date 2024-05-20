import 'package:fpdart/fpdart.dart';
{{#auth}}
import '/domain/entities/auth/login/mock_login_success_model.dart';
{{/auth}}
import '/domain/failure/local/get_local_storage_failure.dart';
import '/domain/failure/local/remove_local_storage_failure.dart';
import '/domain/failure/local/set_local_storage_failure.dart';

abstract class LocalStorageRepository {
  {{#auth}}
  Future<Either<SetLocalStorageFailure, bool>> setUserData(
      {required MockLoginSuccessModel mockLoginSuccessModel});

  Future<Either<GetLocalStorageFailure, MockLoginSuccessModel>> getUserData();
  Future<Either<RemoveLocalStorageFailure, bool>> removeUserData();
  {{/auth}}

  Future<Either<SetLocalStorageFailure, bool>> setBool(
      {required String key, required bool value});

  Future<Either<GetLocalStorageFailure, bool>> getBool({required String key});
}
