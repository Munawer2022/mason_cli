import '/model/local/local_user_info_store_model.dart';
import '/repository/auth/forgot_password/forgot_password_base_api_service.dart';
import '/utils/typedef_models.dart';
import '/data/network/network_base_api_services.dart';
import '/resource/app_url.dart';

class ForgotPasswordRepository implements ForgotPasswordBaseApiServices {
  final NetworkBaseApiServices _baseApiServices;
  ForgotPasswordRepository(this._baseApiServices);

  @override
  Future<TypedefForgotPassword> forgotPassword(
      {required Map<String, dynamic> body}) async {
    try {
      var response = await _baseApiServices.postApi<Map<String, dynamic>>(
          url: AppUrl.forgotPassword, body: body);
      return LocalUserInfoStoreModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
