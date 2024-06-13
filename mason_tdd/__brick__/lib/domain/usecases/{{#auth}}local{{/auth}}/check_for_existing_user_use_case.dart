import 'package:fpdart/fpdart.dart';
import '/data/datasources/login/login_data_sources.dart';
import '/domain/entities/local/mock_local_user_info_store_model.dart';
import '/domain/failure/local/existing_user_failure.dart';
import '/domain/repositories/local/local_storage_base_api.dart';

class CheckForExistingUserUseCase {
  final LoginDataSources _dataSources;
  final LocalStorageRepository _localStorageRepository;
  CheckForExistingUserUseCase(
    this._dataSources,
    this._localStorageRepository,
  );

  Future<Either<ExistingUserFailure, MockLocalUserInfoStoreModel>> execute() {
    return _localStorageRepository.getUserData().then(
          (value) => value.fold(
            (l) => left(ExistingUserFailure(error: l.error)),
            (mockLocalUserInfoStoreModel) {
              if (mockLocalUserInfoStoreModel.token.isNotEmpty) {
                _dataSources.setLoginDataSources(mockLocalUserInfoStoreModel);
                return right(mockLocalUserInfoStoreModel);
              }
              return left(ExistingUserFailure(error: 'User doesn\'t exist '));
            },
          ),
        );
  }
}
