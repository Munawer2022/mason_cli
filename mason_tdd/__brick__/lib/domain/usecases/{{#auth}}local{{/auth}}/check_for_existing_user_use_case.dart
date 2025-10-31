import 'package:fpdart/fpdart.dart';

import '/data/datasources/auth/user_data_sources.dart';
import '/data/models/user/user_info_store_model.dart';
import '/domain/failures/local/existing_user_failure.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';

class CheckForExistingUserUseCase {
  final UserDataSources _userDataSources;
  final LocalStorageRepository _localStorageRepository;
  CheckForExistingUserUseCase(
    this._userDataSources,
    this._localStorageRepository,
  );

  Future<Either<ExistingUserFailure, UserInfoStoreModel>> execute() {
    return _localStorageRepository.getUserData().then(
      (value) => value.fold((l) => left(ExistingUserFailure(error: l.error)), (
        localUserInfoStoreModel,
      ) {
        if (localUserInfoStoreModel.accessToken.isNotEmpty) {
          _userDataSources.setUserDataSources(
            userInfoStoreModel: localUserInfoStoreModel,
          );
          return right(localUserInfoStoreModel);
        }
        return left(ExistingUserFailure(error: 'User doesn\'t exist '));
      }),
    );
  }
}
