import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/repository/auth/forgot_password/forgot_password_base_api_service.dart';
import '/view_model/local/insecure_local_storage.dart';
import '/view_model/local/local_user_info_store_view_model.dart';
import '/resource/app_navigator.dart';
import '/utils/routes/routes_name.dart';
import 'forgot_password_state.dart';

class ForgotPasswordViewModel extends Cubit<ForgotPasswordState> {
  final ForgotPasswordBaseApiServices _baseApiService;
  final InsecureLocalStorage _userInfo;
  final AppNavigator _navigator;
  final LocalUserInfoStoreViewModel _userInfoDataSources;

  ForgotPasswordViewModel(this._baseApiService, this._userInfo, this._navigator,
      this._userInfoDataSources)
      : super(ForgotPasswordState.initial());

  Future<void> forgotPassword(
      {required Map<String, dynamic> body,
      required BuildContext context}) async {
    emit(state.copyWith(isLoading: true));
    _baseApiService.forgotPassword(body: body).then((userInfo) {
      emit(state.copyWith(isLoading: false));
      _userInfo.saveUserInfo(userInfo: userInfo).then((value) {
        _userInfoDataSources
            .setUserInfoDataSources(userInfo: userInfo)
            .then((value) => _navigator.pushNamed(context, RoutesName.login));
      });
    }).onError((error, stackTrace) {
      emit(state.copyWith(isLoading: false, error: error.toString()));
    });
  }
}
