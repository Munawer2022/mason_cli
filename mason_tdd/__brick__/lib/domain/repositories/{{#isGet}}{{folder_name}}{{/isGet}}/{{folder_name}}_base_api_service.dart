import 'package:fpdart/fpdart.dart';
import '/data/models/{{folder_name}}/{{folder_name}}_model.dart';
import '/domain/failures/{{folder_name}}/{{folder_name}}_failure.dart';

abstract class {{class_name}}BaseApiService {
  Future<Either<{{class_name}}Failure, {{class_name}}Model>> {{folder_name_camelCase}}();
}
