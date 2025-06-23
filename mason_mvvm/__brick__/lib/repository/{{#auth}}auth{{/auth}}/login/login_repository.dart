import '/model/local/local_user_info_store_model.dart';

import '/repository/auth/login/login_base_api_service.dart';
import '/utils/typedef_models.dart';
import '/data/network/network_base_api_services.dart';
import '/resource/app_url.dart';

class LoginRepository implements LoginBaseApiServices {
  final NetworkBaseApiServices _baseApiServices;
  LoginRepository(this._baseApiServices);

  @override
  Future<TypedefLogin> login({required Map<String, dynamic> body}) async {
    try {
      var response = await _baseApiServices.postApi<Map<String, dynamic>>(
          url: AppUrl.login, body: body);
      return LocalUserInfoStoreModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
