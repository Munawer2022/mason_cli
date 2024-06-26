{{#isGet}}
import 'package:flutter_bloc/flutter_bloc.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_event.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_state.dart';
import '/repository/{{folder_name}}/{{folder_name}}_base_api_service.dart';
import '/data/response/api_response.dart';

class {{class_name}}ViewModel extends Bloc<{{class_name}}Event,{{class_name}}State> {
  final {{class_name}}BaseApiServices _baseApiService;

  {{class_name}}ViewModel(this._baseApiService)
      : super({{class_name}}State.initial()) {
        on<{{class_name}}>(_{{folder_name}});
        on<Refresh>(_refresh);
      }

  Future<void> _{{folder_name}}({{class_name}} event, Emitter<{{class_name}}State> emit) async {
    emit(state.copyWith(response: ApiResponse.loading()));
    _baseApiService
        .{{folder_name}}()
        .then((value) =>
            emit(state.copyWith(response: ApiResponse.completed(value))))
        .onError((error, stackTrace) => emit(
            state.copyWith(response: ApiResponse.error(error.toString()))));
  }

  Future<void> _refresh(Refresh event, Emitter<{{class_name}}State> emit) async {
    await _{{folder_name}}();
  }
}
{{/isGet}}
{{#isPost}}
import 'package:flutter_bloc/flutter_bloc.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_state.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_event.dart';
import '/repository/{{folder_name}}/{{folder_name}}_base_api_service.dart';

class {{class_name}}ViewModel extends Bloc<{{class_name}}Event,{{class_name}}State> {
  final {{class_name}}BaseApiServices _baseApiService;

  {{class_name}}ViewModel(this._baseApiService): super({{class_name}}State.initial()) {
     on<{{class_name}}>(_{{folder_name}});
  }

  Future<void> _{{folder_name}}({{class_name}} event, Emitter<{{class_name}}State> emit) async {
    emit(state.copyWith(isLoading: true));
    _baseApiService.{{folder_name}}(body: event.body).then((value) {
      emit(state.copyWith(isLoading: false));
      
    }).onError((error, stackTrace) {
      emit(state.copyWith(isLoading: false, error: error.toString()));
    });
  }
}
{{/isPost}}
{{#isNoThing}}
import 'package:flutter_bloc/flutter_bloc.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_event.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_state.dart';

class {{class_name}}ViewModel extends Bloc<{{class_name}}Event,{{class_name}}State> {

  {{class_name}}ViewModel(): super({{class_name}}State.initial()) {
    
  }
}
{{/isNoThing}}
