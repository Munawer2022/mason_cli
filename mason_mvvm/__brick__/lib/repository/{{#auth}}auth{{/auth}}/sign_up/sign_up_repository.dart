import '/model/local/local_user_info_store_model.dart';

import '/repository/auth/sign_up/sign_up_base_api_service.dart';
import '/utils/typedef_models.dart';
import '/data/network/network_base_api_services.dart';
import '/resource/app_url.dart';

class SignUpRepository implements SignUpBaseApiServices {
  final NetworkBaseApiServices _baseApiServices;
  SignUpRepository(this._baseApiServices);

  @override
  Future<TypedefSignUp> signUp({required Map<String, dynamic> body}) async {
    try {
      var response = await _baseApiServices.postApi<Map<String, dynamic>>(
          url: AppUrl.signUp, body: body);
      return LocalUserInfoStoreModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
