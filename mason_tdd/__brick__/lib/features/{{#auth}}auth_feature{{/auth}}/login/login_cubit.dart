import 'package:flutter_bloc/flutter_bloc.dart';
import '/domain/repositories/auth_repositorie_base_api_service/login_repositorie_base_api_service/login_repositorie_base_api_service.dart';
import 'login_initial_params.dart';
import 'login_navigator.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepositorieBaseApiService baseApiServices;
  final LoginNavigator navigator;
  final LoginInitialParams initialParams;
  LoginCubit(this.initialParams, this.baseApiServices, this.navigator)
      : super(LoginState.initial(initialParams: initialParams));

  Future<void> login({required Map<String, dynamic> body}) async {
    emit(state.copyWith(isloading: true));
    final login = await baseApiServices.login(body: body);
    login.fold(
        (left) => emit(state.copyWith(error: left.error, isloading: false)),
        ((right) => emit(state.copyWith(success: right, isloading: false))));
  }
}
