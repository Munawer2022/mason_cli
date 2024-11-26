import 'package:fpdart/fpdart.dart';
import '/core/utils/app_url.dart';
import '/domain/failures/network/network_failure.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import '/data/datasources/auth/login_data_sources.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';
import '/data/models/local/local_user_info_store_model.dart';

class LoginUseCases {
  final NetworkBaseApiService networkRepository;
  final LoginDataSources _dataSources;
  final LocalStorageRepository _localStorageRepository;
  LoginUseCases(
      this.networkRepository, this._dataSources, this._localStorageRepository);
  Future<Either<NetworkFailure, LocalUserInfoStoreModel>> execute(
          {required Map<String, dynamic> body}) async =>
      await networkRepository
          .post<Map<String, dynamic>>(url: AppUrl.login, body: body)
          .then((value) => value.fold(
              (l) => left(l),
              (r) => _localStorageRepository
                  .setUserData(
                      localUserInfoStoreModel:
                          LocalUserInfoStoreModel.fromJson(r))
                  .then((value) => value
                          .fold((l) => left(NetworkFailure(error: l.error)),
                              (tokenRight) {
                        _dataSources.setLoginDataSources(
                            localUserInfoStoreModel:
                                LocalUserInfoStoreModel.fromJson(r));
                        return right(LocalUserInfoStoreModel.fromJson(r));
                      }))));
}
