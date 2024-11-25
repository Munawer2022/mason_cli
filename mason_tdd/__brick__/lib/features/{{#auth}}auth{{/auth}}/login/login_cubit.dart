import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/models/{{#auth}}auth{{/auth}}/login/login_model.dart';
import '/features/{{folder_name}}/{{folder_name}}_initial_params.dart';
import 'login_initial_params.dart';
import 'login_navigator.dart';
import 'login_state.dart';
import '/domain/usecases/auth/login/login_use_cases.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginInitialParams initialParams;
  final LoginUseCases useCases;
  final LoginNavigator navigator;

  LoginCubit(this.initialParams, this.useCases, this.navigator)
      : super(LoginState.initial(initialParams: initialParams));

  void postLogin({required LoginModel body}) {
    emit(state.copyWith(isLoading: true));
    useCases.execute(body: body.toJson()).then((value) => value
            .fold((l) => emit(state.copyWith(error: l.error, isLoading: false)),
                ((r) {
          emit(state.copyWith(success: r, isLoading: false));
          return navigator.open{{class_name}}({{class_name}}InitialParams());
        })));
  }
}
