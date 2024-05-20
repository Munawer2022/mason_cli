import 'package:fpdart/fpdart.dart';

import '/data/datasources/auth/login_data_sources.dart';
import '../../../entities/auth/login/mock_login_success_model.dart';
import '../../../failure/auth/login/login_failure.dart';
import '/domain/repositories/auth/login/login_base_api_service.dart';
import '../../../repositories/local/local_storage_base_api_service.dart';

class LoginUseCases {
  final LoginBaseApiService _loginBaseApiService;
  final LoginDataSources _loginDataSources;
  final LocalStorageRepository _localStorageRepository;
  LoginUseCases(this._loginBaseApiService, this._loginDataSources,
      this._localStorageRepository);
  Future<Either<LoginFailure, MockLoginSuccessModel>> execute(
          {required Map<String, dynamic> body}) async =>
      await _loginBaseApiService.login(body: body).then((value) => value.fold(
          (l) => left(l),
          (r) => _localStorageRepository
              .setUserData(mockLoginSuccessModel: r)
              .then((value) => value.fold(
                      (l) => left(LoginFailure(error: l.error)), (tokenRight) {
                    _loginDataSources.setLoginDataSources(r);
                    return right(r);
                  }))));
}
