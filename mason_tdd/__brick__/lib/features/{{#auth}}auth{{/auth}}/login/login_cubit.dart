import 'package:flutter_bloc/flutter_bloc.dart';
import '/domain/usecases/login/login_use_cases.dart';
import '/features/{{folder_name}}/{{folder_name}}_initial_params.dart';
import 'login_initial_params.dart';
import 'login_navigator.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginInitialParams _initialParams;
  final LoginUseCases _useCases;
  final LoginNavigator navigator;

  LoginCubit(this._initialParams, this._useCases, this.navigator)
      : super(LoginState.initial(initialParams: _initialParams));

  void postLogin({required Map<String, dynamic> body}) {
    emit(state.copyWith(isLoading: true));
    _useCases.execute(body: body).then((value) => value
            .fold((l) => emit(state.copyWith(error: l.error, isLoading: false)),
                ((r) {
          emit(state.copyWith(success: r, isLoading: false));
          return navigator.open{{class_name}}({{class_name}}InitialParams());
        })));
  }
}
