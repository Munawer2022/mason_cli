import '/domain/entities/auth/login/mock_login_success_model.dart';
import 'login_initial_params.dart';

class LoginState {
  final MockLoginSuccessModel success;
  final bool isloading;
  final String? error;

  LoginState({required this.success, required this.isloading, this.error});
  factory LoginState.initial({required LoginInitialParams initialParams}) =>
      LoginState(
          success: MockLoginSuccessModel.empty().copyWith(), isloading: false);
  LoginState copyWith(
          {MockLoginSuccessModel? success, bool? isloading, String? error}) =>
      LoginState(
          success: success ?? this.success,
          isloading: isloading ?? this.isloading,
          error: error ?? this.error);
}
