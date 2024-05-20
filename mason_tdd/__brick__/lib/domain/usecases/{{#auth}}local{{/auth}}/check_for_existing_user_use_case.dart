import 'package:fpdart/fpdart.dart';
import '/domain/entities/auth/login/mock_login_success_model.dart';
import '/domain/failure/local/existing_user_failure.dart';
import '../../repositories/local/local_storage_base_api_service.dart';
import '/domain/repositories/auth/login/login_base_api_service.dart';

import '/data/datasources/auth/login_data_sources.dart';

class CheckForExistingUserUseCase {
  final LoginBaseApiService _loginBaseApiService;
  final LoginDataSources _loginDataSources;
  final LocalStorageRepository _localStorageRepository;
  CheckForExistingUserUseCase(
    this._loginBaseApiService,
    this._loginDataSources,
    this._localStorageRepository,
  );

  Future<Either<ExistingUserFailure, MockLoginSuccessModel>> execute() {
    return _localStorageRepository.getUserData().then(
          (value) => value.fold(
            (l) => left(ExistingUserFailure(error: l.error)),
            (mockLoginSuccessModel) {
              if (mockLoginSuccessModel.token.isNotEmpty) {
                _loginDataSources.setLoginDataSources(mockLoginSuccessModel);
                return right(mockLoginSuccessModel);
              }
              return left(ExistingUserFailure(error: 'User doesn\'t exist '));
            },
          ),
        );
  }
}
