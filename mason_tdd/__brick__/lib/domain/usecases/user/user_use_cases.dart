import 'package:fpdart/fpdart.dart';

import '/data/datasources/user/user_data_sources.dart';
import '/data/models/user/user_info_store_model.dart';
import '/domain/failures/network/network_failure.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';

class UserUseCases {
  final UserDataSources _userDataSources;
  final LocalStorageRepository _localStorageRepository;
  UserUseCases(this._userDataSources, this._localStorageRepository);
  Future<Either<NetworkFailure, UserInfoStoreModel>> execute({
    required Map<String, dynamic> userData,
  }) async => await _localStorageRepository
      .setUserData(userInfoStoreModel: UserInfoStoreModel.fromJson(userData))
      .then(
        (value) => value.fold((l) => left(NetworkFailure(error: l.error)), (
          tokenRight,
        ) {
          _userDataSources.setUserDataSources(
            userInfoStoreModel: UserInfoStoreModel.fromJson(userData),
          );
          return right(UserInfoStoreModel.fromJson(userData));
        }),
      );
}
