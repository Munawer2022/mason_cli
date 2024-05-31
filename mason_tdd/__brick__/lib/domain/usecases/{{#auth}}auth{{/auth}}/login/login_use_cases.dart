import 'package:fpdart/fpdart.dart';
import '/data/datasources/auth/login_data_sources.dart';
import '/domain/failure/auth/login/login_failure.dart';
import '/domain/repositories/auth/login/login_base_api_service.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';
import '/domain/entities/local/mock_local_user_info_store_model.dart';

class LoginUseCases {
  final LoginBaseApiService _loginBaseApiService;
  final LoginDataSources _loginDataSources;
  final LocalStorageRepository _localStorageRepository;
  LoginUseCases(this._loginBaseApiService, this._loginDataSources,
      this._localStorageRepository);
  Future<Either<LoginFailure, MockLocalUserInfoStoreModel>> execute(
          {required Map<String, dynamic> body}) async =>
      await _loginBaseApiService.login(body: body).then((value) => value.fold(
          (l) => left(l),
          (r) => _localStorageRepository
              .setUserData(mockLocalUserInfoStoreModel: r)
              .then((value) => value.fold(
                      (l) => left(LoginFailure(error: l.error)), (tokenRight) {
                    _loginDataSources.setLoginDataSources(r);
                    return right(r);
                  }))));
}
