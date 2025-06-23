class ForgotPasswordState {
  final bool isLoading;
  final String? error;

  ForgotPasswordState({required this.isLoading, this.error});
  factory ForgotPasswordState.initial() =>
      ForgotPasswordState(isLoading: false);
  ForgotPasswordState copyWith({bool? isLoading, String? error}) =>
      ForgotPasswordState(
          isLoading: isLoading ?? this.isLoading, error: error ?? this.error);
}
