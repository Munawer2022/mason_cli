import '/data/models/local/local_user_info_store_model.dart';

import 'login_initial_params.dart';

class LoginState {
  final LocalUserInfoStoreModel success;
  final bool isLoading;
  final String? error;

  LoginState({required this.success, required this.isLoading, this.error});
  factory LoginState.initial({required LoginInitialParams initialParams}) =>
      LoginState(
          success: LocalUserInfoStoreModel.empty().copyWith(),
          isLoading: false);
  LoginState copyWith(
          {LocalUserInfoStoreModel? success, bool? isLoading, String? error}) =>
      LoginState(
          success: success ?? this.success,
          isLoading: isLoading ?? this.isLoading,
          error: error ?? this.error);
}
