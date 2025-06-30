// ignore_for_file: avoid_web_libraries_in_flutter, unused_import
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

/// ========================================
/// BuildContext Extensions
/// ========================================

/// Extension for accessing TextTheme from BuildContext
extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

/// Extension for BuildContext theme and styling utilities
extension BuildContextExtension on BuildContext {
  /// Check if current theme is dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Get adaptive color based on theme
  Color get adaptiveColor =>
      isDarkMode ? Theme.of(this).colorScheme.secondary : Colors.black;

  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Get status bar height
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// Get bottom padding (for devices with home indicator)
  double get bottomPadding => MediaQuery.of(this).padding.bottom;
}

/// Extension for accessing ThemeData from BuildContext
extension ColorExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

/// ========================================
/// DateTime Extensions
/// ========================================

/// DateTime extension for human-readable time formatting
extension DateTimeExtension on DateTime {
  /// Get human-readable time ago string
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else if (difference.inDays > 7) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? '1 day ago'
          : '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? '1 hour ago'
          : '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? '1 minute ago'
          : '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  /// Format date as yyyy-MM-dd
  String get toDateString =>
      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  /// Format time as HH:mm
  String get toTimeString =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }
}

/// ========================================
/// String Extensions
/// ========================================

/// String utility extensions
extension StringExtension on String {
  /// Check if string is a valid email format
  bool get isEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Check if string is a valid phone number format
  bool get isPhone {
    return RegExp(r'^\+?[\d\s-\(\)]+$').hasMatch(this);
  }

  /// Capitalize first letter of string
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Convert string to title case
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Check if string is not empty
  bool get isNotEmpty => this.isNotEmpty;

  /// Get string length safely
  int get safeLength => length;

  /// Remove extra whitespace
  String get trimExtra => replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Check if string contains only digits
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  /// Check if string is a valid URL
  bool get isUrl {
    try {
      Uri.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get initials from name (e.g., "John Doe" -> "JD")
  String get initials {
    if (isEmpty) return '';
    final words = trimExtra.split(' ');
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }
}

/// ========================================
/// List Extensions
/// ========================================

/// List utility extensions
extension ListExtension<T> on List<T> {
  /// Remove duplicate elements from list
  List<T> get removeDuplicates => toSet().toList();

  /// Check if list is not empty
  bool get isNotEmpty => length > 0;

  /// Get first element or null if empty
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null if empty
  T? get lastOrNull => isEmpty ? null : last;

  /// Add element if not null
  void addIfNotNull(T? element) {
    if (element != null) add(element);
  }

  /// Add all elements that are not null
  void addAllNotNull(Iterable<T?> elements) {
    addAll(elements.whereType<T>());
  }

  /// Get element at index safely
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
}

/// ========================================
/// Map Extensions
/// ========================================

/// Map utility extensions
extension MapExtension<K, V> on Map<K, V> {
  /// Remove null values from map
  Map<K, V> get removeNullValues {
    return Map.fromEntries(entries.where((entry) => entry.value != null));
  }

  /// Get value or default if key doesn't exist
  V getOrDefault(K key, V defaultValue) {
    return this[key] ?? defaultValue;
  }

  /// Check if map contains key and value is not null
  bool containsKeyAndValue(K key) {
    return containsKey(key) && this[key] != null;
  }
}

/// ========================================
/// Number Extensions
/// ========================================

/// Number utility extensions
extension NumExtension on num {
  /// Check if number is positive
  bool get isPositive => this > 0;

  /// Check if number is negative
  bool get isNegative => this < 0;

  /// Check if number is zero
  bool get isZero => this == 0;

  /// Get absolute value
  num get absolute => abs();

  /// Clamp number between min and max values
  num clampBetween(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Check if number is between min and max (inclusive)
  bool isBetween(num min, num max) {
    return this >= min && this <= max;
  }
}

/// ========================================
/// Widget Extensions
/// ========================================

/// Widget utility extensions
extension WidgetExtension on Widget {
  /// Add padding to widget
  Widget padding(EdgeInsetsGeometry padding) {
    return Padding(padding: padding, child: this);
  }

  /// Add margin to widget
  Widget margin(EdgeInsetsGeometry margin) {
    return Container(margin: margin, child: this);
  }

  /// Center widget
  Widget get center => Center(child: this);

  /// Make widget expandable
  Widget get expanded => Expanded(child: this);

  /// Make widget flexible
  Widget flexible([int flex = 1]) => Flexible(flex: flex, child: this);

  /// Add tap gesture to widget
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }

  /// Add visibility control
  Widget visible(bool visible) {
    return visible ? this : const SizedBox.shrink();
  }
}
