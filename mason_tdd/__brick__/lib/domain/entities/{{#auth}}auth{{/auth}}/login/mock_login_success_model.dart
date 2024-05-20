import 'package:equatable/equatable.dart';

class MockLoginSuccessModel extends Equatable {
  const MockLoginSuccessModel({
    required this.id,
    required this.token,
  });

  final int id;
  final String token;

  MockLoginSuccessModel copyWith({
    int? id,
    String? token,
  }) {
    return MockLoginSuccessModel(
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  factory MockLoginSuccessModel.empty() =>
      const MockLoginSuccessModel(id: 0, token: '');

  @override
  List<Object?> get props => [
        id,
        token,
      ];
}
