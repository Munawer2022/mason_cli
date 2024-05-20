import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/entities/auth/login/mock_login_success_model.dart';

class LoginDataSources extends Cubit<MockLoginSuccessModel> {
  LoginDataSources() : super(MockLoginSuccessModel.empty());
  setLoginDataSources(MockLoginSuccessModel mockLoginSuccessModel) =>
      emit(mockLoginSuccessModel);
}
