import 'splash_initial_params.dart';

class SplashState {
  final bool isloading;

  SplashState({required this.isloading});
  factory SplashState.initial({required SplashInitialParams initialParams}) =>
      SplashState(isloading: false);
  SplashState copyWith({bool? isloading}) =>
      SplashState(isloading: isloading ?? this.isloading);
}
