import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/global.dart';
import '/core/show/show_error/show_errors.dart';

class InternetConnectivityCheckerViewModel extends Cubit<bool> {
  final Connectivity _connectivity;
  final ShowError _showError;

  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  InternetConnectivityCheckerViewModel(this._connectivity, this._showError)
      : super(false) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) => event
                .first ==
            ConnectivityResult.none
        ? _showError
            .showNoInternetConnectionMaterialBanner('No Internet Connection')
        : GlobalConstants.navigatorKey.currentContext != null
            ? ScaffoldMessenger.of(GlobalConstants.navigatorKey.currentContext!)
                .hideCurrentMaterialBanner()
            : null);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
