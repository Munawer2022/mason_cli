{{#isProvider}}
import 'package:flutter/material.dart';

import '/model/local/local_user_info_store_model.dart';

class LocalUserInfoStoreViewModel extends ChangeNotifier {
  LocalUserInfoStoreModel _userInfo = LocalUserInfoStoreModel.empty();
  LocalUserInfoStoreModel get userInfo => _userInfo;

  Future<void> setUserInfoDataSources(
      {required LocalUserInfoStoreModel userInfo}) async {
    _userInfo = userInfo;
    notifyListeners();
  }
}
{{/isProvider}}
{{#isFlutterBloc}}
import 'package:flutter_bloc/flutter_bloc.dart';

import '/model/local/local_user_info_store_model.dart';

class LocalUserInfoStoreViewModel extends Cubit<LocalUserInfoStoreModel> {
  LocalUserInfoStoreViewModel()
      : super(LocalUserInfoStoreModel.empty().copyWith());

  Future<void> setUserInfoDataSources(
          {required LocalUserInfoStoreModel userInfo}) async =>
      emit(userInfo);
}
{{/isFlutterBloc}}
