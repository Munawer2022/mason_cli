import 'package:flutter_bloc/flutter_bloc.dart';
import '/repository/{{repo_file_name}}';
import '{{folder_name}}_state.dart';

class Cubit{{class_name}}ViewModel extends Cubit<{{class_name}}State> {
  final {{folder_name}}Repository = {{class_name}}Repository();

Cubit{{class_name}}ViewModel() : super(
  {{class_name}}State.initial());

Future<void> fetch{{class_name}}() async {
    emit(state.copyWith(isloading: true, error: null));
    final {{folder_name}} = await {{folder_name}}Repository.get{{class_name}}();
    {{folder_name}}.fold((l) {
      emit(state.copyWith(error: l.error));
    }, ((r) {
      emit(state.copyWith(model: r, isloading: false));
    }));
  }
}