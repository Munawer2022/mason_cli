import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '/utils/show/show_error/show_errors.dart';
import '/resource/global.dart';
{{#isFlutterBloc}}
import 'package:flutter_bloc/flutter_bloc.dart';
{{/isFlutterBloc}}
{{#isBloc}}
import 'Internet_connectivity_checker_state.dart';
import 'internet_connectivity_checker_event.dart';

class InternetConnectivityCheckerViewModel extends Bloc<
    InternetConnectivityCheckerEvent, InternetConnectivityCheckerState> {
  final Connectivity _connectivity;
  final ShowError _showError;

  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  InternetConnectivityCheckerViewModel(this._connectivity, this._showError)
      : super(InternetConnectivityCheckerState.initial()) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) =>
        event.first == ConnectivityResult.none
            ? _showError.showNoInternetConnectionMaterialBanner(
                'No Internet Connection')
            : navigatorKey.currentContext != null
                ? ScaffoldMessenger.of(navigatorKey.currentContext!)
                    .hideCurrentMaterialBanner()
                : null);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

{{#isBloc}}
{{#isFlutterBloc}}
class InternetConnectivityCheckerViewModel extends Cubit<bool> {
  final Connectivity _connectivity;
  final ShowError _showError;

  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  InternetConnectivityCheckerViewModel(this._connectivity, this._showError)
      : super(false) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) =>
        event.first == ConnectivityResult.none
            ? _showError.showNoInternetConnectionMaterialBanner(
                'No Internet Connection')
            : navigatorKey.currentContext != null
                ? ScaffoldMessenger.of(navigatorKey.currentContext!)
                    .hideCurrentMaterialBanner()
                : null);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
{{/isFlutterBloc}}

{{#isProvider}}
class InternetConnectivityCheckerViewModel extends ChangeNotifier {
  final Connectivity _connectivity;
  final ShowError _showError;

  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  InternetConnectivityCheckerViewModel(this._connectivity, this._showError) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) =>
        event.first == ConnectivityResult.none
            ? _showError.showNoInternetConnectionMaterialBanner(
                'No Internet Connection')
            : navigatorKey.currentContext != null
                ? ScaffoldMessenger.of(navigatorKey.currentContext!)
                    .hideCurrentMaterialBanner()
                : null);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
{{/isProvider}}
