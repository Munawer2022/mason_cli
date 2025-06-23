import '/utils/typedef_models.dart';

abstract class SignUpBaseApiServices {
  Future<TypedefSignUp> signUp({required Map<String, dynamic> body});
}
