import 'package:flutter_bloc/flutter_bloc.dart';
{{#isBloc}}
import '/data/datasources/login/login_data_sources_event.dart';
import '/data/datasources/login/login_data_sources_state.dart';
{{/isBloc}}
import '/data/models/local/local_user_info_store_model.dart';
{{#isFlutterBloc}}
class LoginDataSources extends Cubit<LocalUserInfoStoreModel> {
  LoginDataSources() : super(LocalUserInfoStoreModel.empty().copyWith());
  setLoginDataSources(
          {required LocalUserInfoStoreModel localUserInfoStoreModel}) =>
      emit(localUserInfoStoreModel);
}
{{/isFlutterBloc}}

{{#isBloc}}
class LoginDataSources
    extends Bloc<LoginDataSourcesEvent, LoginDataSourcesState> {
  LoginDataSources() : super(LoginDataSourcesState.initial().copyWith()) {
    on<SetLoginDataSources>(_setLoginDataSources);
  }
  _setLoginDataSources(
          SetLoginDataSources event, Emitter<LoginDataSourcesState> emit) =>
      emit(state.copyWith(mockLoginSuccessModel: event.mockLoginSuccessModel));
}
{{/isBloc}}

{{#isProvider}}
class LoginDataSources extends ChangeNotifier {
  MockLocalUserInfoStoreModel _mockLoginSuccessModel =
      MockLocalUserInfoStoreModel.empty().copyWith();

  MockLocalUserInfoStoreModel get mockLoginSuccessModel =>
      _mockLoginSuccessModel;

  setLoginDataSources(
      {required MockLocalUserInfoStoreModel mockLoginSuccessModel}) {
    _mockLoginSuccessModel = mockLoginSuccessModel;
    notifyListeners();
  }
}
{{/isProvider}}
