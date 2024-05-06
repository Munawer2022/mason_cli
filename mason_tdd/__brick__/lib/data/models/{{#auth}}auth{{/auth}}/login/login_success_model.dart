import '/domain/entities/auth/login/mock_login_success_model.dart';

class LoginSuccessModel {
  LoginSuccessModel({
    required this.id,
    required this.token,
  });

  final int id;
  final String token;

  LoginSuccessModel copyWith({
    int? id,
    String? token,
  }) {
    return LoginSuccessModel(
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  factory LoginSuccessModel.fromJson(Map<String, dynamic> json) {
    return LoginSuccessModel(
      id: json["id"] ?? 0,
      token: json["token"] ?? "",
    );
  }
  MockLoginSuccessModel toDomain() =>
      MockLoginSuccessModel(id: id, token: token);
}
