import 'package:fpdart/fpdart.dart';
import '/data/datasources/auth/login_data_sources.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';
import '/data/models/local/local_user_info_store_model.dart';
import '/domain/failures/local/existing_user_failure.dart';

class CheckForExistingUserUseCase {
  final LoginDataSources _loginDataSources;
  final LocalStorageRepository _localStorageRepository;
  CheckForExistingUserUseCase(
      this._loginDataSources, this._localStorageRepository);

  Future<Either<ExistingUserFailure, LocalUserInfoStoreModel>> execute() {
    return _localStorageRepository.getUserData().then((value) => value
            .fold((l) => left(ExistingUserFailure(error: l.error)),
                (localUserInfoStoreModel) {
          if (localUserInfoStoreModel.token.isNotEmpty) {
            _loginDataSources.setLoginDataSources(
                localUserInfoStoreModel: localUserInfoStoreModel);
            return right(localUserInfoStoreModel);
          }
          return left(ExistingUserFailure(error: 'User doesn\'t exist '));
        }));
  }
}
