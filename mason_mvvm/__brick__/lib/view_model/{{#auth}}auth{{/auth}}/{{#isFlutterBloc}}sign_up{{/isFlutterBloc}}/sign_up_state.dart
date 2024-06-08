class SignUpState {
  final bool isLoading;
  final String? error;

  SignUpState({required this.isLoading, this.error});
  factory SignUpState.initial() => SignUpState(isLoading: false);
  SignUpState copyWith({bool? isLoading, String? error}) => SignUpState(
      isLoading: isLoading ?? this.isLoading, error: error ?? this.error);
}
