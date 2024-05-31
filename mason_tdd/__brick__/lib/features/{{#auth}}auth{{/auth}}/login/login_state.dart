import '/domain/entities/local/mock_local_user_info_store_model.dart';

import 'login_initial_params.dart';

class LoginState {
  final MockLocalUserInfoStoreModel success;
  final bool isloading;
  final String? error;

  LoginState({required this.success, required this.isloading, this.error});
  factory LoginState.initial({required LoginInitialParams initialParams}) =>
      LoginState(
          success: MockLocalUserInfoStoreModel.empty().copyWith(),
          isloading: false);
  LoginState copyWith(
          {MockLocalUserInfoStoreModel? success,
          bool? isloading,
          String? error}) =>
      LoginState(
          success: success ?? this.success,
          isloading: isloading ?? this.isloading,
          error: error ?? this.error);
}
