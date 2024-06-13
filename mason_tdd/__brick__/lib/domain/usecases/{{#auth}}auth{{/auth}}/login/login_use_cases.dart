import 'package:fpdart/fpdart.dart';
import '/domain/entities/local/mock_local_user_info_store_model.dart';
import '/domain/failure/login/login_failure.dart';
import '/data/datasources/login/login_data_sources.dart';
import '/domain/repositories/local/local_storage_base_api.dart';
import '/domain/repositories/login/login_base_api_service.dart';

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
                    _dataSources.setLoginDataSources(r);
                    return right(r);
                  }))));
}
