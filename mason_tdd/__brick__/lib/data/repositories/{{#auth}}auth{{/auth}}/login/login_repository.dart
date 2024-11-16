import 'package:fpdart/fpdart.dart';
import '/domain/repositories/auth/login/login_base_api_service.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import '/domain/failures/auth/login/login_failure.dart';
import '/data/models/local/local_user_info_store_model.dart';
import '/core/app_url.dart';

class LoginRepository implements LoginBaseApiService {
  final NetworkBaseApiService _networkRepository;

  LoginRepository(this._networkRepository);

  @override
  Future<Either<LoginFailure, LocalUserInfoStoreModel>> login(
          {required Map<String, dynamic> body}) =>
      _networkRepository
          .post<Map<String, dynamic>>(url: AppUrl.login, body: body)
          .then((value) => value.fold((l) => left(LoginFailure(error: l.error)),
              (r) => right(LocalUserInfoStoreModel.fromJson(r).toDomain())));
}
