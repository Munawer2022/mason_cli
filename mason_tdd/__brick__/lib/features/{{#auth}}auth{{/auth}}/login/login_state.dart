import 'login_initial_params.dart';

class LoginState {
  final bool isLoading;
  final String? error;

  LoginState({required this.isLoading, this.error});
  factory LoginState.initial({required LoginInitialParams initialParams}) =>
      LoginState(isLoading: false);
  LoginState copyWith({bool? isLoading, String? error}) => LoginState(
      isLoading: isLoading ?? this.isLoading, error: error ?? this.error);
}
