class LocalUserInfoStoreModel {
  LocalUserInfoStoreModel({required this.token});

  final String token;

  LocalUserInfoStoreModel copyWith({String? token}) =>
      LocalUserInfoStoreModel(token: token ?? this.token);

  factory LocalUserInfoStoreModel.fromJson(Map<String, dynamic> json) =>
      LocalUserInfoStoreModel(token: json["token"] ?? "");
  factory LocalUserInfoStoreModel.empty() => LocalUserInfoStoreModel(token: "");

  Map<String, dynamic> toJson() => {"token": token};
}
