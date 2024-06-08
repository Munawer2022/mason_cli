import 'package:flutter/material.dart';
import '/repository/auth/login/login_base_api_service.dart';
import '/resource/app_navigator.dart';
import '/utils/routes/routes_name.dart';
import '/view_model/local/insecure_local_storage.dart';
import '/view_model/local/local_user_info_store_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginBaseApiServices _baseApiService;
  final InsecureLocalStorage _userInfo;
  final AppNavigator _navigator;
  final LocalUserInfoStoreViewModel _userInfoDataSources;

  LoginViewModel(this._baseApiService, this._userInfo, this._navigator,
      this._userInfoDataSources);

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> login(
      {required Map<String, dynamic> body,
      required BuildContext context}) async {
    setLoading(true);
    _baseApiService.login(body: body).then((userInfo) {
      setLoading(false);
      _userInfo.saveUserInfo(userInfo: userInfo).then((value) {
        _userInfoDataSources
            .setUserInfoDataSources(userInfo: userInfo)
            .then((value) => _navigator.pushNamed(context, RoutesName.{{folder_name}}));
      });
    }).onError((error, stackTrace) => setLoading(false));
  }
}
