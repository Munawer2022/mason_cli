import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/models/local/local_user_info_store_model.dart';

class LoginDataSources extends Cubit<UserInfoStoreModel> {
  LoginDataSources() : super(UserInfoStoreModel.empty().copyWith());
  setLoginDataSources({required UserInfoStoreModel userInfoStoreModel}) =>
      emit(userInfoStoreModel);
}
