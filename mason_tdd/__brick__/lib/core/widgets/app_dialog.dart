import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget content;
  final List<Widget>? actions;
  final bool barrierDismissible;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  final double? maxWidth;
  final double? maxHeight;
  final VoidCallback? onClose;

  const AppDialog({
    super.key,
    this.title,
    this.titleWidget,
    required this.content,
    this.actions,
    this.barrierDismissible = true,
    this.backgroundColor,
    this.borderRadius,
    this.contentPadding,
    this.maxWidth,
    this.maxHeight,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor ?? context.theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? 400.w,
          maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null || titleWidget != null) _buildHeader(context),
            Flexible(
              child: Padding(
                padding: contentPadding ?? EdgeInsets.all(16.w),
                child: content,
              ),
            ),
            if (actions != null && actions!.isNotEmpty) _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: Row(
        children: [
          if (titleWidget != null) ...[
            Expanded(child: titleWidget!),
          ] else if (title != null) ...[
            Expanded(
              child: Text(
                title!,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          if (onClose != null) ...[
            IconButton(
              onPressed: onClose,
              icon: Icon(
                Icons.close,
                color: context.theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: actions!),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget content,
    String? title,
    Widget? titleWidget,
    List<Widget>? actions,
    bool barrierDismissible = true,
    Color? backgroundColor,
    double? borderRadius,
    EdgeInsets? contentPadding,
    double? maxWidth,
    double? maxHeight,
    VoidCallback? onClose,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog(
        title: title,
        titleWidget: titleWidget,
        content: content,
        actions: actions,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        contentPadding: contentPadding,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        onClose: onClose,
      ),
    );
  }
}

// Specialized Dialog Widgets
class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: title,
      content: Text(message, style: context.textTheme.bodyMedium),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            onCancel?.call();
          },
          child: Text(cancelText ?? 'Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onConfirm?.call();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isDestructive
                ? context.theme.colorScheme.error
                : context.theme.colorScheme.primary,
          ),
          child: Text(confirmText ?? 'Confirm'),
        ),
      ],
    );
  }

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isDestructive: isDestructive,
      ),
    );
  }
}

class AlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onPressed;
  final AlertType type;

  const AlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onPressed,
    this.type = AlertType.info,
  });

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      titleWidget: Row(
        children: [
          Icon(_getIcon(), color: _getColor(context), size: 24.sp),
          12.horizontalSpace,
          Expanded(
            child: Text(
              title,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      content: Text(message, style: context.textTheme.bodyMedium),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onPressed?.call();
          },
          style: ElevatedButton.styleFrom(backgroundColor: _getColor(context)),
          child: Text(buttonText ?? 'OK'),
        ),
      ],
    );
  }

  IconData _getIcon() {
    switch (type) {
      case AlertType.success:
        return Icons.check_circle;
      case AlertType.error:
        return Icons.error;
      case AlertType.warning:
        return Icons.warning;
      case AlertType.info:
      default:
        return Icons.info;
    }
  }

  Color _getColor(BuildContext context) {
    switch (type) {
      case AlertType.success:
        return Colors.green;
      case AlertType.error:
        return context.theme.colorScheme.error;
      case AlertType.warning:
        return Colors.orange;
      case AlertType.info:
      default:
        return context.theme.colorScheme.primary;
    }
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
    AlertType type = AlertType.info,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: title,
        message: message,
        buttonText: buttonText,
        onPressed: onPressed,
        type: type,
      ),
    );
  }
}

enum AlertType { success, error, warning, info }

class InputDialog extends StatefulWidget {
  final String title;
  final String? hintText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final String? confirmText;
  final String? cancelText;
  final ValueChanged<String>? onConfirm;
  final VoidCallback? onCancel;
  final String? Function(String?)? validator;

  const InputDialog({
    super.key,
    required this.title,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.validator,
  });

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  late TextEditingController _controller;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: widget.title,
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: const OutlineInputBorder(),
          ),
          validator: widget.validator,
          autofocus: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onCancel?.call();
          },
          child: Text(widget.cancelText ?? 'Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? true) {
              Navigator.of(context).pop(_controller.text);
              widget.onConfirm?.call(_controller.text);
            }
          },
          child: Text(widget.confirmText ?? 'Confirm'),
        ),
      ],
    );
  }

  static Future<String?> show({
    required BuildContext context,
    required String title,
    String? hintText,
    String? initialValue,
    TextInputType? keyboardType,
    String? confirmText,
    String? cancelText,
    ValueChanged<String>? onConfirm,
    VoidCallback? onCancel,
    String? Function(String?)? validator,
  }) {
    return showDialog<String>(
      context: context,
      builder: (context) => InputDialog(
        title: title,
        hintText: hintText,
        initialValue: initialValue,
        keyboardType: keyboardType,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        validator: validator,
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  final String? message;
  final bool barrierDismissible;

  const LoadingDialog({
    super.key,
    this.message,
    this.barrierDismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      barrierDismissible: barrierDismissible,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          if (message != null) ...[
            16.verticalSpace,
            Text(
              message!,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    String? message,
    bool barrierDismissible = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => LoadingDialog(
        message: message,
        barrierDismissible: barrierDismissible,
      ),
    );
  }
}
