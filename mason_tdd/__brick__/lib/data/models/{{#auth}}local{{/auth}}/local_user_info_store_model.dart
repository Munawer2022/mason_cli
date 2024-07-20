import '/domain/entities/local/mock_local_user_info_store_model.dart';

class LocalUserInfoStoreModel {
  LocalUserInfoStoreModel({required this.token});

  final String token;

  LocalUserInfoStoreModel copyWith({String? token}) =>
      LocalUserInfoStoreModel(token: token ?? this.token);

  factory LocalUserInfoStoreModel.fromJson(Map<String, dynamic> json) =>
      LocalUserInfoStoreModel(token: json["token"] ?? "");

  Map<String, dynamic> toJson() => {"token": token};

  MockLocalUserInfoStoreModel toDomain() =>
      MockLocalUserInfoStoreModel(token: token);
}
