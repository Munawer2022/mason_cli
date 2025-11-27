import 'package:fpdart/fpdart.dart';

import '/data/datasources/auth/user_data_sources.dart';
import '/data/models/user/user_info_store_model.dart';
import '/domain/failures/network/network_failure.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';

class UserUseCases {
  final UserDataSources _userDataSources;
  final LocalStorageRepository _localStorageRepository;
  UserUseCases(this._userDataSources, this._localStorageRepository);
  Future<Either<NetworkFailure, UserInfoStoreModel>> execute({
    required Map<String, dynamic> r,
  }) async => await _localStorageRepository
      .setUserData(userInfoStoreModel: UserInfoStoreModel.fromJson(r))
      .then(
        (value) => value.fold((l) => left(NetworkFailure(error: l.error)), (
          tokenRight,
        ) {
          _userDataSources.setUserDataSources(
            userInfoStoreModel: UserInfoStoreModel.fromJson(r),
          );
          return right(UserInfoStoreModel.fromJson(r));
        }),
      );
}
