import 'package:fpdart/fpdart.dart';
import '/config/network/network_repository.dart';
import '/domain/entities/auth_entitie/login/mock_login_success_model.dart';
import '/domain/failure/auth_failure/login/login_failure.dart';
import '/domain/repositories/auth_repositorie_base_api_service/login_repositorie_base_api_service/login_repositorie_base_api_service.dart';
import '../../../models/auth_model/login/login_success_model.dart';
import '/core/app_url.dart';

class LoginRepository implements LoginRepositorieBaseApiService {
  final NetworkRepository _networkRepository;

  LoginRepository(this._networkRepository);

  @override
  Future<Either<LoginFailure, MockLoginSuccessModel>> login(
          {required Map<String, dynamic> body}) =>
      _networkRepository
          .post<Map<String, dynamic>>(url: AppUrl.login, body: body)
          .then((value) => value.fold((l) => left(LoginFailure(error: l.error)),
              (r) => right(LoginSuccessModel.fromJson(r).toDomain())));
}
