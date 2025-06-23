import 'package:flutter/material.dart';
import '/repository/auth/forgot_password/forgot_password_base_api_service.dart';
import '/resource/navigation/app_navigator.dart';
import '/utils/routes/routes_name.dart';
import '/view_model/local/insecure_local_storage.dart';
import '/view_model/local/local_user_info_store_view_model.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final ForgotPasswordBaseApiServices _baseApiService;
  final InsecureLocalStorage _userInfo;
  final AppNavigator _navigator;
  final LocalUserInfoStoreViewModel _userInfoDataSources;

  ForgotPasswordViewModel(this._baseApiService, this._userInfo, this._navigator,
      this._userInfoDataSources);

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> forgotPassword(
      {required Map<String, dynamic> body,
      required BuildContext context}) async {
    setLoading(true);
    _baseApiService.forgotPassword(body: body).then((userInfo) {
      setLoading(false);
      _userInfo.saveUserInfo(userInfo: userInfo).then((value) {
        _userInfoDataSources.setUserInfoDataSources(userInfo: userInfo).then(
            (value) => _navigator.pushNamed(
                context: context, routeName: RoutesName.login));
      });
    }).onError((error, stackTrace) => setLoading(false));
  }
}
