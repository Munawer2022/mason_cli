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
{{#isBloc}}
import 'package:flutter_bloc/flutter_bloc.dart';
import '/view_model/local/local_user_info_store_state.dart';

import 'local_user_info_store_event.dart';

class LocalUserInfoStoreViewModel
    extends Bloc<LocalUserInfoStoreEvent, LocalUserInfoStoreState> {
  LocalUserInfoStoreViewModel()
      : super(LocalUserInfoStoreState.initial().copyWith()) {
    on<SetUserInfoDataSources>(_setUserInfoDataSources);
  }

  Future<void> _setUserInfoDataSources(SetUserInfoDataSources event,
          Emitter<LocalUserInfoStoreState> emit) async =>
      emit(state.copyWith(userInfo: event.userInfo));
}
{{/isBloc}}
