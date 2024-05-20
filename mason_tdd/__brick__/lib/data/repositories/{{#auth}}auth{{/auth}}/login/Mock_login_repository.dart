import 'package:fpdart/fpdart.dart';
import '/domain/repositories/auth/login/login_base_api_service.dart';
import '/domain/entities/auth/login/mock_login_success_model.dart';
import '/domain/failure/auth/login/login_failure.dart';

class MockLoginRepository implements LoginBaseApiService {
  @override
  Future<Either<LoginFailure, MockLoginSuccessModel>> login(
      {required Map<String, dynamic> body}) async {
    await Future.delayed(const Duration(seconds: 2));
    return right(MockLoginSuccessModel.empty().copyWith(token: 'newToken 123'));
  }
}
