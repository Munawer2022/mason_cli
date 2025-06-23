import '/model/local/local_user_info_store_model.dart';

class LocalUserInfoStoreState {
  final LocalUserInfoStoreModel userInfo;

  LocalUserInfoStoreState({required this.userInfo});

  factory LocalUserInfoStoreState.initial() => LocalUserInfoStoreState(
      userInfo: LocalUserInfoStoreModel.empty().copyWith());

  LocalUserInfoStoreState copyWith({LocalUserInfoStoreModel? userInfo}) =>
      LocalUserInfoStoreState(userInfo: userInfo ?? this.userInfo);
}
