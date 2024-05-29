import '/utils/typedef_models.dart';

abstract class ForgotPasswordBaseApiServices {
  Future<TypedefForgotPassword> forgotPassword(
      {required Map<String, dynamic> body});
}
