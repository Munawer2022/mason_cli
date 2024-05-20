import 'package:fpdart/fpdart.dart';

import '../../../entities/auth/login/mock_login_success_model.dart';
import '../../../failure/auth/login/login_failure.dart';

abstract class LoginBaseApiService {
  Future<Either<LoginFailure, MockLoginSuccessModel>> login(
      {required Map<String, dynamic> body});
}
