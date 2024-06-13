import 'package:flutter/material.dart';
import '/utils/routes/routes_name.dart';
import '/resource/navigation/app_navigator.dart';
import '/view_model/local/insecure_local_storage.dart';
import '/view_model/local/local_user_info_store_view_model.dart';
{{#isGet}}
import '/view_model/{{folder_name}}/{{folder_name}}_view_model.dart';
{{/isGet}}

class SplashViewModel {
  final AppNavigator _navigator;
  final InsecureLocalStorage _userInfo;
  final LocalUserInfoStoreViewModel _userInfoDataSources;
  {{#isGet}}
    final {{class_name}}ViewModel _viewModel;
  {{/isGet}}


  SplashViewModel(this._navigator, this._userInfo, this._userInfoDataSources
  {{#isGet}}
  , this._viewModel
  {{/isGet}}
  );

  void checkAuthentication(BuildContext context) => _userInfo
      .getUserInfo()
      .then((userInfo) => userInfo.token.toString() == 'null' ||
                  userInfo.token.toString() == ''
              ? _navigator.pushNamed(
                  context: context, routeName: RoutesName.login)
              : _userInfoDataSources
                  .setUserInfoDataSources(userInfo: userInfo)
                  .then((value) =>
                  {{#isGet}}
                   _viewModel.{{folder_name}}().then((value) => 
                  {{/isGet}}
                   _navigator
                      .pushNamed(context: context, routeName: RoutesName.{{folder_name}}))
                      {{#isGet}}
                      )
                      {{/isGet}}
                 
          // Future.delayed(const Duration(seconds: 2),
          //     () => _navigator.pushNamed(context, RoutesName.test)
          );
}
