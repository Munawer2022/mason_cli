import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '/core/show/show/show.dart';
import '/core/global.dart';
{{#isFlutterBloc}}
import 'package:flutter_bloc/flutter_bloc.dart';
{{/isFlutterBloc}}
{{#isBloc}}
import 'Internet_connectivity_checker_state.dart';
import 'internet_connectivity_checker_event.dart';

class InternetConnectivityCheckerDataSources extends Bloc<
    InternetConnectivityCheckerEvent, InternetConnectivityCheckerState> {
  final Connectivity _connectivity;
  final Show _show;

  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  InternetConnectivityCheckerDataSources(this._connectivity, this._show)
      : super(InternetConnectivityCheckerState.initial()) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) =>
        event.first == ConnectivityResult.none
            ? _show.showNoInternetConnectionMaterialBanner(
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

{{/isBloc}}
{{#isFlutterBloc}}
class InternetConnectivityCheckerDataSources extends Cubit<bool> {
  final Connectivity _connectivity;
  final Show _show;

  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  InternetConnectivityCheckerDataSources(this._connectivity, this._show)
      : super(false) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) => event
                .first ==
            ConnectivityResult.none
        ? _show
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
{{/isFlutterBloc}}
