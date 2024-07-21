import 'package:fpdart/fpdart.dart';
import '/domain/failure/auth/login/login_failure.dart';
import '/domain/entities/local/mock_local_user_info_store_model.dart';

abstract class LoginBaseApiService {
  Future<Either<LoginFailure, MockLocalUserInfoStoreModel>> login(
      {required Map<String, dynamic> body});
}
