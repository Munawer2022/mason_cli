import 'package:fpdart/fpdart.dart';
{{#auth}}
import '/data/models/local/local_user_info_store_model.dart';
import '/domain/failures/local/remove_local_storage_failure.dart';
{{/auth}}
import '/domain/failures/local/get_local_storage_failure.dart';
import '/domain/failures/local/set_local_storage_failure.dart';

abstract class LocalStorageRepository {
  {{#auth}}
  Future<Either<SetLocalStorageFailure, bool>> setUserData(
      {required LocalUserInfoStoreModel localUserInfoStoreModel});

  Future<Either<GetLocalStorageFailure, LocalUserInfoStoreModel>> getUserData();
  Future<Either<RemoveLocalStorageFailure, bool>> removeUserData();
  {{/auth}}

  Future<Either<SetLocalStorageFailure, bool>> setBool(
      {required String key, required bool value});

  Future<Either<GetLocalStorageFailure, bool>> getBool({required String key});
}
