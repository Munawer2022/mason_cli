import 'package:flutter/foundation.dart';

import '/model/local/local_user_info_store_model.dart';

class LocalUserInfoStoreViewModel extends ChangeNotifier {
  LocalUserInfoStoreModel _userInfo = LocalUserInfoStoreModel.empty();
  LocalUserInfoStoreModel get userInfo => _userInfo;

  Future<void> setUserInfoDataSources(
      {required LocalUserInfoStoreModel userInfo}) async {
    _userInfo = userInfo;
    notifyListeners();
  }
}
