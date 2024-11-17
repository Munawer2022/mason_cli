import '/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/response/api_response.dart';
import '/config/response/status.dart';

class StatusSwitcher<T> extends StatelessWidget {
  final ApiResponse<T> response;
  final Widget Function(BuildContext context) onLoading;
  final Widget Function(BuildContext context, String message)? onError;
  final Widget Function(BuildContext context, T data) onCompleted;

  const StatusSwitcher(
      {super.key,
      required this.response,
      required this.onLoading,
      this.onError,
      required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    switch (response.status) {
      case Status.LOADING:
        return onLoading(context);
      case Status.ERROR:
        return onError != null
            ? onError!(context, response.message)
            : Center(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Text(response.message,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyLarge)));

      // case Status.COMPLETED:
      //   return onCompleted(context, response.data);
      case Status.COMPLETED:
        if (response.data == null ||
            (response.data is Iterable &&
                (response.data as Iterable).isEmpty)) {
          return Text('No data',
              style: context.textTheme.bodyLarge, textAlign: TextAlign.center);
        }
        return onCompleted(context, response.data);
      default:
        return Container();
    }
  }
}
