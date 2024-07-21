import '/domain/entities/local/mock_local_user_info_store_model.dart';

class LoginDataSourcesState {
  final MockLocalUserInfoStoreModel mockLoginSuccessModel;

  LoginDataSourcesState({required this.mockLoginSuccessModel});

  factory LoginDataSourcesState.initial() => LoginDataSourcesState(
      mockLoginSuccessModel: MockLocalUserInfoStoreModel.empty().copyWith());

  LoginDataSourcesState copyWith(
          {MockLocalUserInfoStoreModel? mockLoginSuccessModel}) =>
      LoginDataSourcesState(
          mockLoginSuccessModel:
              mockLoginSuccessModel ?? this.mockLoginSuccessModel);
}
