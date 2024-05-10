import 'package:fpdart/fpdart.dart';

import '../../../entities/auth_entitie/login/mock_login_success_model.dart';
import '../../../failure/auth_failure/login/login_failure.dart';

abstract class LoginRepositorieBaseApiService {
  Future<Either<LoginFailure, MockLoginSuccessModel>> login(
      {required Map<String, dynamic> body});
}
