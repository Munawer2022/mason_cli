import '/utils/typedef_models.dart';

abstract class LoginBaseApiServices {
  Future<TypedefLogin> login({required Map<String, dynamic> body});
}
