{{#isGet}}
import 'package:flutter_bloc/flutter_bloc.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_state.dart';
import '/repository/{{folder_name}}/{{folder_name}}_base_api_service.dart';
import '/data/response/api_response.dart';

class {{class_name}}ViewModel extends Cubit<{{class_name}}State> {
  final {{class_name}}BaseApiServices _baseApiService;

  {{class_name}}ViewModel(this._baseApiService)
      : super({{class_name}}State.initial());

  Future<void> {{folder_name}}() async {
    emit(state.copyWith(response: ApiResponse.loading()));
    _baseApiService
        .{{folder_name}}()
        .then((value) =>
            emit(state.copyWith(response: ApiResponse.completed(value))))
        .onError((error, stackTrace) => emit(
            state.copyWith(response: ApiResponse.error(error.toString()))));
  }

  Future<void> refresh() async {
    await {{folder_name}}();
  }
}
{{/isGet}}
{{#isPost}}
import 'package:flutter_bloc/flutter_bloc.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_state.dart';
import '/repository/{{folder_name}}/{{folder_name}}_base_api_service.dart';

class {{class_name}}ViewModel extends Cubit<{{class_name}}State> {
  final {{class_name}}BaseApiServices _baseApiService;

  {{class_name}}ViewModel(this._baseApiService): super({{class_name}}State.initial());

  Future<void> {{folder_name}}({required Map<String, dynamic> body}) async {
    emit(state.copyWith(isLoading: true));
    _baseApiService.{{folder_name}}(body: body).then((value) {
      emit(state.copyWith(isLoading: false));
      
    }).onError((error, stackTrace) {
      emit(state.copyWith(isLoading: false, error: error.toString()));
    });
  }
}
{{/isPost}}
{{#isNoThing}}
import 'package:flutter_bloc/flutter_bloc.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_state.dart';

class {{class_name}}ViewModel extends Cubit<{{class_name}}State> {

  {{class_name}}ViewModel(): super({{class_name}}State.initial());
}
{{/isNoThing}}
