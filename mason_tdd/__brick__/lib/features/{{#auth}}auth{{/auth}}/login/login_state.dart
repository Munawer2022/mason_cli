import 'login_initial_params.dart';

class LoginState {
  final bool isLoading;

  LoginState({required this.isLoading});
  factory LoginState.initial({required LoginInitialParams initialParams}) =>
      LoginState(isLoading: false);
  LoginState copyWith({bool? isLoading}) =>
      LoginState(isLoading: isLoading ?? this.isLoading);
}
