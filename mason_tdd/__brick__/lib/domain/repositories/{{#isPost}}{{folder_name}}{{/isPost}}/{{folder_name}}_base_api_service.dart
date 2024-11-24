import 'package:fpdart/fpdart.dart';
import '/domain/failures/{{folder_name}}/{{folder_name}}_failure.dart';


abstract class {{class_name}}BaseApiService {
  Future<Either<{{class_name}}Failure, Map<String,dynamic>>> {{folder_name_camelCase}}(
    {required Map<String, dynamic> body});
}
