import 'package:fpdart/fpdart.dart';
import '/data/models/{{folder_name}}/{{folder_name}}_success_model.dart';
import '/domain/failures/{{folder_name}}/{{folder_name}}_failure.dart';


abstract class {{class_name}}BaseApiService {
  Future<Either<{{class_name}}Failure, {{class_name}}SuccessModel>> {{folder_name_camelCase}}(
    {required Map<String, dynamic> body});
}
