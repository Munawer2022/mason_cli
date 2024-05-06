import 'package:fpdart/fpdart.dart';

import '../../../entities/auth/login/mock_login_success_model.dart';
import '../../../failure/auth/login/login_use_cases_failure.dart';

class LoginUseCases {
  Future<Either<LoginUseCasesFailure, MockLoginSuccessModel>> execute() =>
      throw {};
}
