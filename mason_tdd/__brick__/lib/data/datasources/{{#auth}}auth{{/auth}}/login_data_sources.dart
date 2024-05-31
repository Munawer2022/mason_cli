import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/entities/local/mock_local_user_info_store_model.dart';

class LoginDataSources extends Cubit<MockLocalUserInfoStoreModel> {
  LoginDataSources() : super(MockLocalUserInfoStoreModel.empty());
  setLoginDataSources(
          MockLocalUserInfoStoreModel mockLocalUserInfoStoreModel) =>
      emit(mockLocalUserInfoStoreModel);
}
