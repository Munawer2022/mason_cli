import 'package:fpdart/fpdart.dart';
import '/domain/entities/{{folder_name}}/mock_{{folder_name}}_success_model.dart';
import '/domain/failures/{{folder_name}}/{{folder_name}}_failure.dart';


abstract class {{class_name}}BaseApiService {
  Future<Either<{{class_name}}Failure, Mock{{class_name}}SuccessModel>> {{folder_name_camelCase}}(
    {required Map<String, dynamic> body});
}
