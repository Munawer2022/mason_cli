import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extensions.dart';

class SearchWidget extends StatefulWidget {
  final String? hintText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final VoidCallback? onTap;
  final bool enabled;
  final bool readOnly;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final SearchType type;
  final EdgeInsets? margin;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool showClearButton;
  final bool autoFocus;

  const SearchWidget({
    super.key,
    this.hintText,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.controller,
    this.focusNode,
    this.type = SearchType.text,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
    this.showClearButton = true,
    this.autoFocus = false,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    _hasText = widget.initialValue?.isNotEmpty ?? false;

    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _onClear() {
    _controller.clear();
    widget.onClear?.call();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autoFocus,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        keyboardType: _getKeyboardType(),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: widget.hintText ?? _getDefaultHintText(),
          prefixIcon: widget.prefixIcon ?? _getDefaultPrefixIcon(),
          suffixIcon: _buildSuffixIcon(),
          filled: true,
          fillColor:
              widget.backgroundColor ?? context.theme.colorScheme.surface,
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildBorder(),
          disabledBorder: _buildBorder(),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }

  Widget _getDefaultPrefixIcon() {
    return Icon(
      Icons.search,
      color: context.theme.colorScheme.onSurface.withOpacity(0.5),
      size: 20.sp,
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.showClearButton && _hasText) {
      return IconButton(
        icon: Icon(
          Icons.clear,
          color: context.theme.colorScheme.onSurface.withOpacity(0.5),
          size: 20.sp,
        ),
        onPressed: _onClear,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
      );
    }

    return null;
  }

  OutlineInputBorder _buildBorder() {
    final effectiveBorderRadius = widget.borderRadius ?? 12.r;
    final effectiveBorderColor =
        widget.borderColor ??
        context.theme.colorScheme.outline.withOpacity(0.3);

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(effectiveBorderRadius),
      borderSide: BorderSide(color: effectiveBorderColor),
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case SearchType.text:
        return TextInputType.text;
      case SearchType.email:
        return TextInputType.emailAddress;
      case SearchType.phone:
        return TextInputType.phone;
      case SearchType.number:
        return TextInputType.number;
      case SearchType.url:
        return TextInputType.url;
    }
  }

  String _getDefaultHintText() {
    switch (widget.type) {
      case SearchType.text:
        return 'Search...';
      case SearchType.email:
        return 'Search by email...';
      case SearchType.phone:
        return 'Search by phone...';
      case SearchType.number:
        return 'Search by number...';
      case SearchType.url:
        return 'Search by URL...';
    }
  }
}

enum SearchType { text, email, phone, number, url }

// Specialized Search Widgets
class FilterSearchWidget extends StatelessWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final bool hasFilters;
  final EdgeInsets? margin;

  const FilterSearchWidget({
    super.key,
    this.hintText,
    this.onChanged,
    this.onFilterTap,
    this.hasFilters = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchWidget(
            hintText: hintText ?? 'Search...',
            onChanged: onChanged,
            margin: margin,
          ),
        ),
        12.horizontalSpace,
        Container(
          decoration: BoxDecoration(
            color: hasFilters
                ? context.theme.colorScheme.primary
                : context.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: context.theme.colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: IconButton(
            onPressed: onFilterTap,
            icon: Icon(
              Icons.filter_list,
              color: hasFilters
                  ? context.theme.colorScheme.onPrimary
                  : context.theme.colorScheme.onSurface.withOpacity(0.7),
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}

class VoiceSearchWidget extends StatefulWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onVoiceSearch;
  final bool isListening;
  final EdgeInsets? margin;

  const VoiceSearchWidget({
    super.key,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onVoiceSearch,
    this.isListening = false,
    this.margin,
  });

  @override
  State<VoiceSearchWidget> createState() => _VoiceSearchWidgetState();
}

class _VoiceSearchWidgetState extends State<VoiceSearchWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(VoiceSearchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isListening && !oldWidget.isListening) {
      _animationController.repeat(reverse: true);
    } else if (!widget.isListening && oldWidget.isListening) {
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchWidget(
      hintText: widget.hintText ?? 'Search or tap to speak...',
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      margin: widget.margin,
      suffixIcon: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: IconButton(
              onPressed: widget.onVoiceSearch,
              icon: Icon(
                widget.isListening ? Icons.mic : Icons.mic_none,
                color: widget.isListening
                    ? context.theme.colorScheme.error
                    : context.theme.colorScheme.onSurface.withOpacity(0.5),
                size: 20.sp,
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategorySearchWidget extends StatelessWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String>? onCategoryChanged;
  final EdgeInsets? margin;

  const CategorySearchWidget({
    super.key,
    this.hintText,
    this.onChanged,
    required this.categories,
    this.selectedCategory,
    this.onCategoryChanged,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (categories.isNotEmpty) ...[
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;

                return Container(
                  margin: EdgeInsets.only(right: 8.w),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        onCategoryChanged?.call(category);
                      }
                    },
                    backgroundColor: context.theme.colorScheme.surface,
                    selectedColor: context.theme.colorScheme.primary
                        .withOpacity(0.2),
                    checkmarkColor: context.theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? context.theme.colorScheme.primary
                          : context.theme.colorScheme.onSurface,
                    ),
                  ),
                );
              },
            ),
          ),
          12.verticalSpace,
        ],
        SearchWidget(
          hintText: hintText ?? 'Search...',
          onChanged: onChanged,
          margin: margin,
        ),
      ],
    );
  }
}
