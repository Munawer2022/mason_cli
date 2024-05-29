import 'package:flutter/material.dart';
import '/utils/routes/routes_name.dart';
import '/resource/app_navigator.dart';
import '/view_model/local/insecure_local_storage.dart';
import '/view_model/local/local_user_info_store_view_model.dart';

class SplashViewModel {
  final AppNavigator _navigator;
  final InsecureLocalStorage _userInfo;
  final LocalUserInfoStoreViewModel _userInfoDataSources;

  SplashViewModel(this._navigator, this._userInfo, this._userInfoDataSources);

  void checkAuthentication(BuildContext context) => _userInfo
      .getUserInfo()
      .then((userInfo) => userInfo.token.toString() == 'null' ||
                  userInfo.token.toString() == ''
              ? _navigator.pushNamed(context, RoutesName.login)
              : _userInfoDataSources
                  .setUserInfoDataSources(userInfo: userInfo)
                  .then(
                      (value) => _navigator.pushNamed(context, RoutesName.{{folder_name}}))
          // Future.delayed(const Duration(seconds: 2),
          //     () => _navigator.pushNamed(context, RoutesName.test)
          );
}
