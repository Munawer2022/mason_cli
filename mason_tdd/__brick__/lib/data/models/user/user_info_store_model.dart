class UserInfoStoreModel {
  UserInfoStoreModel({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  UserInfoStoreModel copyWith({String? accessToken, String? refreshToken}) =>
      UserInfoStoreModel(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  factory UserInfoStoreModel.fromJson(Map<String, dynamic> json) =>
      UserInfoStoreModel(
        accessToken: json["accessToken"] ?? "",
        refreshToken: json["refreshToken"] ?? "",
      );
  factory UserInfoStoreModel.empty() =>
      UserInfoStoreModel(accessToken: "", refreshToken: "");

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
