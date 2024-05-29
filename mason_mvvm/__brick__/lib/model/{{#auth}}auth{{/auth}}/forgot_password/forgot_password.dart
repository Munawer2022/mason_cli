class ForgotPasswordModel {
  final String email;
  final String password;

  ForgotPasswordModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
