import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

/// Configuration class for AppTextFormField styling and behavior
class AppTextFieldConfig {
  // Styling
  final double borderRadius;
  final double borderWidth;
  final EdgeInsets contentPadding;
  final bool isDense;
  final bool filled;

  // Colors
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? cursorColor;

  // Typography
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;

  // Behavior
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextInputAction defaultTextInputAction;
  final String obscuringCharacter;
  final bool enableInteractiveSelection;
  final bool cursorOpacityAnimates;

  const AppTextFieldConfig({
    // Styling defaults
    this.borderRadius = 32.0,
    this.borderWidth = 2.0,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 13,
      horizontal: 16,
    ),
    this.isDense = true,
    this.filled = true,

    // Colors (null means use theme defaults)
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.labelColor,
    this.hintColor,
    this.textColor,
    this.cursorColor,

    // Typography
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,

    // Behavior defaults
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.defaultTextInputAction = TextInputAction.next,
    this.obscuringCharacter = '•',
    this.enableInteractiveSelection = true,
    this.cursorOpacityAnimates = true,
  });

  AppTextFieldConfig copyWith({
    double? borderRadius,
    double? borderWidth,
    EdgeInsets? contentPadding,
    bool? isDense,
    bool? filled,
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? labelColor,
    Color? hintColor,
    Color? textColor,
    Color? cursorColor,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    TextStyle? errorStyle,
    FloatingLabelBehavior? floatingLabelBehavior,
    TextInputAction? defaultTextInputAction,
    String? obscuringCharacter,
    bool? enableInteractiveSelection,
    bool? cursorOpacityAnimates,
  }) {
    return AppTextFieldConfig(
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      contentPadding: contentPadding ?? this.contentPadding,
      isDense: isDense ?? this.isDense,
      filled: filled ?? this.filled,
      fillColor: fillColor ?? this.fillColor,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      labelColor: labelColor ?? this.labelColor,
      hintColor: hintColor ?? this.hintColor,
      textColor: textColor ?? this.textColor,
      cursorColor: cursorColor ?? this.cursorColor,
      textStyle: textStyle ?? this.textStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      floatingLabelBehavior:
          floatingLabelBehavior ?? this.floatingLabelBehavior,
      defaultTextInputAction:
          defaultTextInputAction ?? this.defaultTextInputAction,
      obscuringCharacter: obscuringCharacter ?? this.obscuringCharacter,
      enableInteractiveSelection:
          enableInteractiveSelection ?? this.enableInteractiveSelection,
      cursorOpacityAnimates:
          cursorOpacityAnimates ?? this.cursorOpacityAnimates,
    );
  }
}

/// Enum for different text field variants
enum AppTextFieldType {
  standard,
  email,
  password,
  phone,
  number,
  multiline,
  search,
  url,
}

/// Main AppTextFormField widget with improved architecture
class AppTextFormField extends StatefulWidget {
  // Core properties
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final AppTextFieldType type;
  final AppTextFieldConfig? config;

  // Validation
  final String? Function(String?)? validator;
  final bool required;
  final String? requiredMessage;

  // Icons and actions
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;

  // Behavior
  final bool readOnly;
  final bool enabled;
  final bool obscureText;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;

  // Input constraints
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;

  // Styling overrides
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;

  const AppTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.type = AppTextFieldType.standard,
    this.config,
    this.validator,
    this.required = false,
    this.requiredMessage,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.inputFormatters,
    this.autofillHints,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late bool _obscureText;
  late AppTextFieldConfig _config;

  @override
  void initState() {
    super.initState();
    _obscureText =
        widget.obscureText || widget.type == AppTextFieldType.password;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _config = widget.config ?? _getDefaultConfig(context);
  }

  AppTextFieldConfig _getDefaultConfig(BuildContext context) {
    return AppTextFieldConfig(
      fillColor: context.theme.canvasColor,
      borderColor: context.theme.cardColor,
      focusedBorderColor: context.theme.primaryColor,
      errorBorderColor: context.theme.colorScheme.error,
      labelColor: context.theme.hintColor,
      hintColor: context.theme.hintColor,
      textColor: context.theme.textTheme.bodyLarge?.color,
      textStyle: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w400,
      ),
      labelStyle: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w400,
      ),
      hintStyle: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w400,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: _obscureText,
      obscuringCharacter: _config.obscuringCharacter,
      textAlign: widget.textAlign,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction ?? _getTextInputAction(),
      keyboardType: _getKeyboardType(),
      inputFormatters: widget.inputFormatters ?? _getInputFormatters(),
      autofillHints: widget.autofillHints ?? _getAutofillHints(),
      validator: _buildValidator(),
      maxLength: widget.maxLength,
      maxLines: _getMaxLines(),
      minLines: widget.minLines,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      onEditingComplete: widget.onEditingComplete,
      cursorOpacityAnimates: _config.cursorOpacityAnimates,
      enableInteractiveSelection: _config.enableInteractiveSelection,
      style: _config.textStyle?.copyWith(color: _config.textColor),
      cursorColor: _config.cursorColor,
      decoration: _buildInputDecoration(context),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      labelText: widget.labelText,
      hintText: widget.hintText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: _buildSuffixIcon(),
      prefixText: widget.prefixText,
      suffixText: widget.suffixText,
      isDense: _config.isDense,
      filled: _config.filled,
      fillColor: _config.fillColor,
      contentPadding: _config.contentPadding,
      floatingLabelBehavior: _config.floatingLabelBehavior,
      alignLabelWithHint: true,
      labelStyle: _config.labelStyle?.copyWith(color: _config.labelColor),
      hintStyle: _config.hintStyle?.copyWith(color: _config.hintColor),
      errorStyle: _config.errorStyle,
      border: _buildBorder(_config.borderColor ?? context.theme.cardColor),
      enabledBorder: _buildBorder(
        _config.borderColor ?? context.theme.cardColor,
      ),
      focusedBorder: _buildBorder(
        _config.focusedBorderColor ?? context.theme.primaryColor,
      ),
      errorBorder: _buildBorder(
        _config.errorBorderColor ?? context.theme.colorScheme.error,
      ),
      focusedErrorBorder: _buildBorder(
        _config.errorBorderColor ?? context.theme.colorScheme.error,
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: _config.borderWidth.w),
      borderRadius: BorderRadius.circular(_config.borderRadius.r),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.type == AppTextFieldType.password) {
      return IconButton(
        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      );
    }
    return widget.suffixIcon;
  }

  String? Function(String?)? _buildValidator() {
    if (widget.validator != null) return widget.validator;
    if (!widget.required) return null;

    return (value) {
      if (value == null || value.trim().isEmpty) {
        return widget.requiredMessage ?? 'This field is required';
      }

      // Type-specific validation
      switch (widget.type) {
        case AppTextFieldType.email:
          if (!_isValidEmail(value)) {
            return 'Please enter a valid email address';
          }
          break;
        case AppTextFieldType.phone:
          if (!_isValidPhone(value)) {
            return 'Please enter a valid phone number';
          }
          break;
        case AppTextFieldType.url:
          if (!_isValidUrl(value)) {
            return 'Please enter a valid URL';
          }
          break;
        default:
          break;
      }
      return null;
    };
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case AppTextFieldType.email:
        return TextInputType.emailAddress;
      case AppTextFieldType.phone:
        return TextInputType.phone;
      case AppTextFieldType.number:
        return TextInputType.number;
      case AppTextFieldType.multiline:
        return TextInputType.multiline;
      case AppTextFieldType.url:
        return TextInputType.url;
      default:
        return TextInputType.text;
    }
  }

  TextInputAction _getTextInputAction() {
    if (widget.type == AppTextFieldType.multiline) {
      return TextInputAction.newline;
    }
    return _config.defaultTextInputAction;
  }

  int? _getMaxLines() {
    if (widget.maxLines != null) return widget.maxLines;
    if (widget.type == AppTextFieldType.multiline) return null;
    return 1;
  }

  List<TextInputFormatter>? _getInputFormatters() {
    switch (widget.type) {
      case AppTextFieldType.phone:
        return [FilteringTextInputFormatter.digitsOnly];
      case AppTextFieldType.number:
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))];
      default:
        return null;
    }
  }

  Iterable<String>? _getAutofillHints() {
    switch (widget.type) {
      case AppTextFieldType.email:
        return [AutofillHints.email];
      case AppTextFieldType.password:
        return [AutofillHints.password];
      case AppTextFieldType.phone:
        return [AutofillHints.telephoneNumber];
      case AppTextFieldType.url:
        return [AutofillHints.url];
      default:
        return null;
    }
  }

  // Validation helpers
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(phone) && phone.length >= 10;
  }

  bool _isValidUrl(String url) {
    return RegExp(
      r'^https?:\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$',
    ).hasMatch(url);
  }
}

/// Specialized text field widgets for common use cases
class AppEmailField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool required;
  final AppTextFieldConfig? config;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const AppEmailField({
    super.key,
    this.controller,
    this.labelText = 'Email',
    this.hintText = 'Enter your email',
    this.required = false,
    this.config,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      type: AppTextFieldType.email,
      required: required,
      config: config,
      onChanged: onChanged,
      validator: validator,
      prefixIcon: const Icon(Icons.email_outlined),
    );
  }
}

class AppPasswordField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool required;
  final AppTextFieldConfig? config;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const AppPasswordField({
    super.key,
    this.controller,
    this.labelText = 'Password',
    this.hintText = 'Enter your password',
    this.required = false,
    this.config,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      type: AppTextFieldType.password,
      required: required,
      config: config,
      onChanged: onChanged,
      validator: validator,
      prefixIcon: const Icon(Icons.lock_outlined),
    );
  }
}

class AppSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final AppTextFieldConfig? config;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onClear;

  const AppSearchField({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.config,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      hintText: hintText,
      type: AppTextFieldType.search,
      config: config?.copyWith(
        borderRadius: 16.0,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: controller?.text.isNotEmpty == true
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller?.clear();
                onClear?.call();
              },
            )
          : null,
      textInputAction: TextInputAction.search,
    );
  }
}

/// Extension for easier usage
extension AppTextFormFieldExtensions on BuildContext {
  AppTextFieldConfig get defaultTextFieldConfig => AppTextFieldConfig(
    fillColor: theme.canvasColor,
    borderColor: theme.cardColor,
    focusedBorderColor: theme.primaryColor,
    errorBorderColor: theme.colorScheme.error,
    textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
  );
}
