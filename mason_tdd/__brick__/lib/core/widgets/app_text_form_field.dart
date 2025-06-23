import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

abstract class AppTextFormField {
  static textFormField({
    required BuildContext context,
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    TextInputType? keyboardType,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    String obscuringCharacter = '•',
    String? Function(String?)? validator,
    bool readOnly = false,
    void Function()? onTap,
    Iterable<String>? autofillHints,
    int? maxLength,
    int? maxLines = 1,
    int? minLines,
    void Function(String)? onChanged,
    void Function(String)? onFieldSubmitted,
    InputBorder? border,
    FocusNode? focusNode,
    String? prefixText,
    TextStyle? hintStyle,
    double? borderRadius,
    TextAlign textAlign = TextAlign.start,
    EdgeInsets? contentPadding,
  }) {
    return TextFormField(
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w400,
      ),
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      autofillHints: autofillHints,
      cursorOpacityAnimates: true,
      textAlign: textAlign,

      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      validator: validator,
      maxLength: maxLength,
      maxLines: maxLines,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      minLines: minLines,
      focusNode: focusNode,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixText: prefixText,
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: context.theme.cardColor, width: 2.w),
          borderRadius: BorderRadius.circular(borderRadius ?? 32.0.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.theme.cardColor, width: 2.w),
          borderRadius: BorderRadius.circular(borderRadius ?? 32.0.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.theme.cardColor, width: 2.w),
          borderRadius: BorderRadius.circular(borderRadius ?? 32.0.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.theme.cardColor, width: 2.w),
          borderRadius: BorderRadius.circular(borderRadius ?? 32.0.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.theme.cardColor, width: 2.w),
          borderRadius: BorderRadius.circular(borderRadius ?? 32.0.r),
        ),
        prefixIcon: prefixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: labelText,
        fillColor: context.theme.canvasColor,
        filled: true,
        hintText: hintText,
        alignLabelWithHint: true,
        labelStyle: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w400,
          color: context.theme.hintColor,
        ),
        hintStyle:
            hintStyle ??
            context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: context.theme.hintColor,
            ),
      ),
      controller: controller,
    );
  }
}
