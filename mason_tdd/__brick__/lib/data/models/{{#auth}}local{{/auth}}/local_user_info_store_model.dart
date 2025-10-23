class LocalUserInfoStoreModel {
  LocalUserInfoStoreModel({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  LocalUserInfoStoreModel copyWith({
    String? accessToken,
    String? refreshToken,
  }) => LocalUserInfoStoreModel(
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
  );

  factory LocalUserInfoStoreModel.fromJson(Map<String, dynamic> json) =>
      LocalUserInfoStoreModel(
        accessToken: json["accessToken"] ?? "",
        refreshToken: json["refreshToken"] ?? "",
      );
  factory LocalUserInfoStoreModel.empty() =>
      LocalUserInfoStoreModel(accessToken: "", refreshToken: "");

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
