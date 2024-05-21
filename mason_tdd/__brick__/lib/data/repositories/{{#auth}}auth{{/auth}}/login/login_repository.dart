import 'package:fpdart/fpdart.dart';
import '/domain/repositories/auth/login/login_base_api_service.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import '/domain/entities/auth/login/mock_login_success_model.dart';
import '/domain/failure/auth/login/login_failure.dart';
import '../../../models/auth/login/login_success_model.dart';
import '/core/app_url.dart';

class LoginRepository implements LoginBaseApiService {
  final NetworkBaseApiService _networkRepository;

  LoginRepository(this._networkRepository);

  @override
  Future<Either<LoginFailure, MockLoginSuccessModel>> login(
          {required Map<String, dynamic> body}) =>
      _networkRepository
          .post<Map<String, dynamic>>(url: AppUrl.login, body: body)
          .then((value) => value.fold((l) => left(LoginFailure(error: l.error)),
              (r) => right(LoginSuccessModel.fromJson(r).toDomain())));
}
