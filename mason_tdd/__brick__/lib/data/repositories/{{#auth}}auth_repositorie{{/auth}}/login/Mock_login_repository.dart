import 'package:fpdart/fpdart.dart';
import '/domain/entities/auth_entitie/login/mock_login_success_model.dart';
import '/domain/failure/auth_failure/login/login_failure.dart';
import '/domain/repositories/auth_repositorie_base_api_service/login_repositorie_base_api_service/login_repositorie_base_api_service.dart';

class MockLoginRepository implements LoginRepositorieBaseApiService {
  @override
  Future<Either<LoginFailure, MockLoginSuccessModel>> login(
      {required Map<String, dynamic> body}) async {
    await Future.delayed(const Duration(seconds: 2));
    return right(MockLoginSuccessModel.empty().copyWith(token: 'newToken 123'));
  }
}
