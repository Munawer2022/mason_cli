import 'package:flutter/material.dart';
import '/data/response/api_response.dart';
import '/data/response/status.dart';

class StatusSwitcher<T> extends StatelessWidget {
  final ApiResponse<T> response;
  final Widget Function(BuildContext context) onLoading;
  final Widget Function(BuildContext context, String message) onError;
  final Widget Function(BuildContext context, T data) onCompleted;

  const StatusSwitcher({
    super.key,
    required this.response,
    required this.onLoading,
    required this.onError,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    switch (response.status) {
      case Status.LOADING:
        return onLoading(context);
      case Status.ERROR:
        return onError(context, response.message);
      case Status.COMPLETED:
        return onCompleted(context, response.data);
      default:
        return Container();
    }
  }
}
