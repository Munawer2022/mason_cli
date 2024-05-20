import 'package:fpdart/fpdart.dart';
{{#isPost}}
import '../../entities/{{folder_name}}/mock_{{folder_name}}_success_model.dart';
{{/isPost}}
{{#isGet}}
import '../../entities/{{folder_name}}/mock_{{folder_name}}_model.dart';
{{/isGet}}
import '../../failure/{{folder_name}}/{{folder_name}}_failure.dart';

abstract class {{class_name}}BaseApiService {
  {{#isGet}}
  Future<Either<{{class_name}}Failure, Mock{{class_name}}Model>> {{folder_name}}();
  {{/isGet}}
  {{#isPost}}
  Future<Either<{{class_name}}Failure, Mock{{class_name}}SuccessModel>> {{folder_name}}(
    {required Map<String, dynamic> body});
  {{/isPost}}
}
