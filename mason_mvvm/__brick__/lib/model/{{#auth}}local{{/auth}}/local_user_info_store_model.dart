class LocalUserInfoStoreModel {
  const LocalUserInfoStoreModel({
    required this.token,
  });

  final String token;

  LocalUserInfoStoreModel copyWith({
    String? token,
  }) {
    return LocalUserInfoStoreModel(
      token: token ?? this.token,
    );
  }

  factory LocalUserInfoStoreModel.fromJson(Map<String, dynamic> json) =>
      LocalUserInfoStoreModel(
        token: json["token"] ?? "",
      );
  Map<String, dynamic> toJson() => {
        "token": token,
      };
  factory LocalUserInfoStoreModel.empty() =>
      const LocalUserInfoStoreModel(token: '');
}
