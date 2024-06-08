import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/repository/auth/sign_up/sign_up_base_api_service.dart';
import '/view_model/auth/sign_up/sign_up_state.dart';
import '/view_model/local/insecure_local_storage.dart';
import '/view_model/local/local_user_info_store_view_model.dart';
import '/resource/app_navigator.dart';
import '/utils/routes/routes_name.dart';

class SignUpViewModel extends Cubit<SignUpState> {
  final SignUpBaseApiServices _baseApiService;
  final InsecureLocalStorage _userInfo;
  final AppNavigator _navigator;
  final LocalUserInfoStoreViewModel _userInfoDataSources;

  SignUpViewModel(this._baseApiService, this._userInfo, this._navigator,
      this._userInfoDataSources)
      : super(SignUpState.initial());

  Future<void> signUp(
      {required Map<String, dynamic> body,
      required BuildContext context}) async {
    emit(state.copyWith(isLoading: true));
    _baseApiService.signUp(body: body).then((userInfo) {
      emit(state.copyWith(isLoading: false));
      _userInfo.saveUserInfo(userInfo: userInfo).then((value) {
        _userInfoDataSources
            .setUserInfoDataSources(userInfo: userInfo)
            .then((value) => _navigator.pushNamed(context, RoutesName.{{folder_name}}));
      });
    }).onError((error, stackTrace) {
      emit(state.copyWith(isLoading: false, error: error.toString()));
    });
  }
}
