import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/models/user/user_info_store_model.dart';

class UserDataSources extends Cubit<UserInfoStoreModel> {
  UserDataSources() : super(UserInfoStoreModel.empty().copyWith());
  void setUserDataSources({required UserInfoStoreModel userInfoStoreModel}) =>
      emit(userInfoStoreModel);
}
