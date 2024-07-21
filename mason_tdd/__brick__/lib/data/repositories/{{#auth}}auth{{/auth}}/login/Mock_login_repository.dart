import 'package:fpdart/fpdart.dart';
import '/domain/repositories/auth/login/login_base_api_service.dart';
import '/domain/entities/local/mock_local_user_info_store_model.dart';
import '/domain/failures/auth/login/login_failure.dart';
import '/core/global.dart';

class MockLoginRepository implements LoginBaseApiService {
  @override
  Future<Either<LoginFailure, MockLocalUserInfoStoreModel>> login(
      {required Map<String, dynamic> body}) async {
    await GlobalConstants.mockRepoTime;
    return right(
        MockLocalUserInfoStoreModel.empty().copyWith(token: 'newToken 123'));
  }
}
