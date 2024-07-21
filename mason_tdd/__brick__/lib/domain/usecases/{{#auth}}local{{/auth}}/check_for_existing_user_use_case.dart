import 'package:fpdart/fpdart.dart';
import '/data/datasources/auth/login_data_sources.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';
import '/domain/entities/local/mock_local_user_info_store_model.dart';
import '/domain/failure/local/existing_user_failure.dart';

class CheckForExistingUserUseCase {
  final LoginDataSources _loginDataSources;
  final LocalStorageRepository _localStorageRepository;
  CheckForExistingUserUseCase(
      this._loginDataSources, this._localStorageRepository);

  Future<Either<ExistingUserFailure, MockLocalUserInfoStoreModel>> execute() {
    return _localStorageRepository.getUserData().then((value) => value
            .fold((l) => left(ExistingUserFailure(error: l.error)),
                (mockLocalUserInfoStoreModel) {
          if (mockLocalUserInfoStoreModel.token.isNotEmpty) {
            _loginDataSources.setLoginDataSources(
                mockLoginSuccessModel: mockLocalUserInfoStoreModel);
            return right(mockLocalUserInfoStoreModel);
          }
          return left(ExistingUserFailure(error: 'User doesn\'t exist '));
        }));
  }
}
