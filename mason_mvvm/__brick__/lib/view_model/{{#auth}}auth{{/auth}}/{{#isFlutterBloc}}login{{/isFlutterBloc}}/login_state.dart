class LoginState {
  bool isLoading;
  String? error;
  LoginState({required this.isLoading, this.error});
  factory LoginState.initial() => LoginState(isLoading: false);
  LoginState copyWith({bool? isLoading, String? error}) => LoginState(
      isLoading: isLoading ?? this.isLoading, error: error ?? this.error);
}
