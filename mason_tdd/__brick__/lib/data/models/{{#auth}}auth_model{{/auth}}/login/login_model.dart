import '/domain/entities/auth_entitie/login/mock_login_model.dart';

class LoginModel {
  String email;
  String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {"email": email, "password": password};

  MockLoginModel toDomain() => MockLoginModel(email: email, password: password);
}
