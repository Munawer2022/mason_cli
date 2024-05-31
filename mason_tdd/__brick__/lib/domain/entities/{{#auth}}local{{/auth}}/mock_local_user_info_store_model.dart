import 'package:equatable/equatable.dart';

class MockLocalUserInfoStoreModel extends Equatable {
  const MockLocalUserInfoStoreModel({
    required this.token,
  });

  final String token;

  MockLocalUserInfoStoreModel copyWith({
    String? token,
  }) {
    return MockLocalUserInfoStoreModel(
      token: token ?? this.token,
    );
  }

  factory MockLocalUserInfoStoreModel.fromJson(Map<String, dynamic> json) =>
      MockLocalUserInfoStoreModel(
        token: json["token"] ?? "",
      );
  factory MockLocalUserInfoStoreModel.empty() =>
      const MockLocalUserInfoStoreModel(token: '');

  Map<String, dynamic> toJson() => {"token": token};

  @override
  List<Object?> get props => [
        token,
      ];
}
