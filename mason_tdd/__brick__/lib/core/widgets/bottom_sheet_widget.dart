import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool showDragHandle;
  final bool isDismissible;
  final bool enableDrag;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final bool isScrollControlled;
  final double? maxHeight;
  final VoidCallback? onClose;

  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.titleWidget,
    this.actions,
    this.showDragHandle = true,
    this.isDismissible = true,
    this.enableDrag = true,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.isScrollControlled = false,
    this.maxHeight,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: maxHeight != null
          ? BoxConstraints(maxHeight: maxHeight!)
          : null,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius ?? 16.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDragHandle) _buildDragHandle(context),
          if (title != null || titleWidget != null) _buildHeader(context),
          Flexible(
            child: Padding(
              padding: padding ?? EdgeInsets.all(16.w),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragHandle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.onSurface.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
          if (actions != null) ...[...actions!],
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

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    Widget? titleWidget,
    List<Widget>? actions,
    bool showDragHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? borderRadius,
    EdgeInsets? padding,
    bool isScrollControlled = false,
    double? maxHeight,
    VoidCallback? onClose,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (context) => AppBottomSheet(
        title: title,
        titleWidget: titleWidget,
        actions: actions,
        showDragHandle: showDragHandle,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        padding: padding,
        maxHeight: maxHeight,
        onClose: onClose,
        child: child,
      ),
    );
  }
}

// Specialized Bottom Sheet Widgets
class ActionBottomSheet extends StatelessWidget {
  final String title;
  final List<BottomSheetAction> actions;
  final String? cancelText;
  final VoidCallback? onCancel;

  const ActionBottomSheet({
    super.key,
    required this.title,
    required this.actions,
    this.cancelText,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...actions.map((action) => _buildActionTile(context, action)),
          if (cancelText != null) ...[
            Divider(color: context.theme.colorScheme.outline.withOpacity(0.2)),
            ListTile(
              title: Text(
                cancelText!,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.theme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.of(context).pop();
                onCancel?.call();
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, BottomSheetAction action) {
    return ListTile(
      leading: action.icon != null
          ? Icon(
              action.icon,
              color: action.iconColor ?? context.theme.colorScheme.primary,
            )
          : null,
      title: Text(
        action.title,
        style: context.textTheme.bodyLarge?.copyWith(
          color: action.textColor ?? context.theme.colorScheme.onSurface,
        ),
      ),
      subtitle: action.subtitle != null
          ? Text(
              action.subtitle!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            )
          : null,
      trailing: action.trailing,
      onTap: () {
        Navigator.of(context).pop();
        action.onTap?.call();
      },
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required List<BottomSheetAction> actions,
    String? cancelText,
    VoidCallback? onCancel,
  }) {
    return AppBottomSheet.show(
      context: context,
      child: ActionBottomSheet(
        title: title,
        actions: actions,
        cancelText: cancelText,
        onCancel: onCancel,
      ),
    );
  }
}

class BottomSheetAction {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  const BottomSheetAction({
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.textColor,
    this.trailing,
    this.onTap,
  });
}

class FilterBottomSheet extends StatefulWidget {
  final List<FilterOption> filters;
  final Map<String, dynamic> selectedFilters;
  final ValueChanged<Map<String, dynamic>>? onFiltersChanged;
  final VoidCallback? onApply;
  final VoidCallback? onReset;

  const FilterBottomSheet({
    super.key,
    required this.filters,
    required this.selectedFilters,
    this.onFiltersChanged,
    this.onApply,
    this.onReset,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Map<String, dynamic> _selectedFilters;

  @override
  void initState() {
    super.initState();
    _selectedFilters = Map.from(widget.selectedFilters);
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: 'Filters',
      isScrollControlled: true,
      maxHeight: MediaQuery.of(context).size.height * 0.8,
      actions: [
        if (widget.onReset != null)
          TextButton(
            onPressed: _resetFilters,
            child: Text(
              'Reset',
              style: TextStyle(color: context.theme.colorScheme.error),
            ),
          ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.filters.length,
              itemBuilder: (context, index) {
                final filter = widget.filters[index];
                return _buildFilterOption(context, filter);
              },
            ),
          ),
          if (widget.onApply != null) ...[
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterOption(BuildContext context, FilterOption filter) {
    switch (filter.type) {
      case FilterType.checkbox:
        return CheckboxListTile(
          title: Text(filter.title),
          subtitle: filter.subtitle != null ? Text(filter.subtitle!) : null,
          value: _selectedFilters[filter.key] ?? false,
          onChanged: (value) {
            setState(() {
              _selectedFilters[filter.key] = value ?? false;
            });
            widget.onFiltersChanged?.call(_selectedFilters);
          },
        );
      case FilterType.radio:
        return RadioListTile<String>(
          title: Text(filter.title),
          subtitle: filter.subtitle != null ? Text(filter.subtitle!) : null,
          value: filter.key,
          groupValue: _selectedFilters[filter.groupKey ?? filter.key],
          onChanged: (value) {
            setState(() {
              _selectedFilters[filter.groupKey ?? filter.key] = value;
            });
            widget.onFiltersChanged?.call(_selectedFilters);
          },
        );
      case FilterType.range:
        return RangeSlider(
          values: _selectedFilters[filter.key] ?? const RangeValues(0, 100),
          min: filter.min ?? 0,
          max: filter.max ?? 100,
          divisions: filter.divisions,
          labels: RangeLabels(
            _selectedFilters[filter.key]?.start.round().toString() ?? '0',
            _selectedFilters[filter.key]?.end.round().toString() ?? '100',
          ),
          onChanged: (values) {
            setState(() {
              _selectedFilters[filter.key] = values;
            });
            widget.onFiltersChanged?.call(_selectedFilters);
          },
        );
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedFilters.clear();
    });
    widget.onReset?.call();
  }

  void _applyFilters() {
    widget.onApply?.call();
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required List<FilterOption> filters,
    required Map<String, dynamic> selectedFilters,
    ValueChanged<Map<String, dynamic>>? onFiltersChanged,
    VoidCallback? onApply,
    VoidCallback? onReset,
  }) {
    return AppBottomSheet.show(
      context: context,
      child: FilterBottomSheet(
        filters: filters,
        selectedFilters: selectedFilters,
        onFiltersChanged: onFiltersChanged,
        onApply: onApply,
        onReset: onReset,
      ),
    );
  }
}

class FilterOption {
  final String key;
  final String title;
  final String? subtitle;
  final FilterType type;
  final String? groupKey;
  final double? min;
  final double? max;
  final int? divisions;

  const FilterOption({
    required this.key,
    required this.title,
    this.subtitle,
    required this.type,
    this.groupKey,
    this.min,
    this.max,
    this.divisions,
  });
}

enum FilterType { checkbox, radio, range }

class ShareBottomSheet extends StatelessWidget {
  final String title;
  final String? content;
  final String? url;
  final List<ShareOption> shareOptions;

  const ShareBottomSheet({
    super.key,
    required this.title,
    this.content,
    this.url,
    required this.shareOptions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
            ),
            itemCount: shareOptions.length,
            itemBuilder: (context, index) {
              final option = shareOptions[index];
              return _buildShareOption(context, option);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShareOption(BuildContext context, ShareOption option) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        option.onTap?.call();
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: option.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(option.icon, color: option.color, size: 24.sp),
          ),
          8.verticalSpace,
          Text(
            option.title,
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? content,
    String? url,
    required List<ShareOption> shareOptions,
  }) {
    return AppBottomSheet.show(
      context: context,
      child: ShareBottomSheet(
        title: title,
        content: content,
        url: url,
        shareOptions: shareOptions,
      ),
    );
  }
}

class ShareOption {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const ShareOption({
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });
}
