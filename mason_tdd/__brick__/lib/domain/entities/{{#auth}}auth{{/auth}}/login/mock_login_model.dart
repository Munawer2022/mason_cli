import 'package:equatable/equatable.dart';

class MockLoginModel extends Equatable {
  final String email;
  final String password;

  const MockLoginModel({
    required this.email,
    required this.password,
  });

  factory MockLoginModel.empty() =>
      const MockLoginModel(email: '', password: '');

  MockLoginModel copyWith({String? email, String? password}) => MockLoginModel(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object?> get props => [email, password];
}
