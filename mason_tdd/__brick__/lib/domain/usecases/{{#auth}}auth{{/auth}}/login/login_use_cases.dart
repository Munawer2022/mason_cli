import 'package:fpdart/fpdart.dart';
import '/data/datasources/auth/login_data_sources.dart';
import '/domain/failure/auth/login/login_failure.dart';
import '/domain/repositories/auth/login/login_base_api_service.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';
import '/domain/entities/local/mock_local_user_info_store_model.dart';

class LoginUseCases {
  final LoginBaseApiService _baseApiService;
  final LoginDataSources _dataSources;
  final LocalStorageRepository _localStorageRepository;
  LoginUseCases(
      this._baseApiService, this._dataSources, this._localStorageRepository);
  Future<Either<LoginFailure, MockLocalUserInfoStoreModel>> execute(
          {required Map<String, dynamic> body}) async =>
      await _baseApiService.login(body: body).then((value) => value.fold(
          (l) => left(l),
          (r) => _localStorageRepository
              .setUserData(mockLocalUserInfoStoreModel: r)
              .then((value) => value.fold(
                      (l) => left(LoginFailure(error: l.error)), (tokenRight) {
                    _dataSources.setLoginDataSources(mockLoginSuccessModel: r);
                    return right(r);
                  }))));
}
