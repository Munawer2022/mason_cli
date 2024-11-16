import 'package:fpdart/fpdart.dart';
import '/domain/failures/auth/login/login_failure.dart';
import '/data/models/local/local_user_info_store_model.dart';

abstract class LoginBaseApiService {
  Future<Either<LoginFailure, LocalUserInfoStoreModel>> login(
      {required Map<String, dynamic> body});
}
