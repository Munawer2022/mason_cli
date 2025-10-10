import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

/// Essential Flutter extensions for common development tasks
/// Only includes the most frequently used and practical extensions

// ==================== LOGGER SETUP ====================

final Logger _appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: false,
  ),
);

// ==================== BUILDCONTEXT EXTENSIONS ====================

extension BuildContextExtension on BuildContext {
  // Theme & Colors
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // Screen & Layout
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;
  EdgeInsets get safeAreaPadding => MediaQuery.of(this).padding;
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  // Keyboard & Input
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;
  void hideKeyboard() => FocusScope.of(this).unfocus();
}

// ==================== STRING EXTENSIONS ====================

extension StringExtension on String {
  // Validation
  bool get isNotEmpty => isNotEmpty;
  bool get isNullOrEmpty => isEmpty;
  bool get isEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  bool get isPhoneNumber => RegExp(r'^\+?[\d\s-\(\)]{10,}$').hasMatch(this);
  bool get isNumeric => RegExp(r'^\d+$').hasMatch(this);

  // Formatting
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
  String get capitalizeWords =>
      split(' ').map((word) => word.capitalize).join(' ');

  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  // Extraction & Cleaning
  String get extractNumbers => replaceAll(RegExp(r'[^0-9]'), '');
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  // Initials for avatars
  String get initials {
    if (isEmpty) return '';
    final words = split(' ').where((word) => word.isNotEmpty).toList();
    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

  // Safe conversions
  int? get toIntOrNull => int.tryParse(this);
  double? get toDoubleOrNull => double.tryParse(this);
  bool get toBool => toLowerCase() == 'true' || this == '1';
  DateTime? get toDateTimeOrNull {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }
}

// ==================== NUMBER EXTENSIONS ====================

extension NumberExtension on num {
  // Currency formatting
  String get toCurrency =>
      NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(this);
  String get toPounds =>
      NumberFormat.currency(symbol: '£', decimalDigits: 2).format(this);
  String get toFormattedNumber => NumberFormat('#,###').format(this);

  // File size formatting
  String get toFileSize {
    if (this < 1024) return '${toStringAsFixed(0)} B';
    if (this < 1024 * 1024) return '${(this / 1024).toStringAsFixed(1)} KB';
    if (this < 1024 * 1024 * 1024)
      return '${(this / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // Duration helpers
  Duration get seconds => Duration(seconds: toInt());
  Duration get minutes => Duration(minutes: toInt());
  Duration get hours => Duration(hours: toInt());
  Duration get days => Duration(days: toInt());

  // Utilities
  bool get isPositive => this > 0;
  bool get isNegative => this < 0;
  bool get isZero => this == 0;
}

// ==================== DATETIME EXTENSIONS ====================

extension DateTimeExtension on DateTime {
  // Relative time
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

  // Common date formats
  String get toFormattedDate => DateFormat('MMM dd, yyyy').format(this);
  String get toShortDate => DateFormat('dd/MM/yyyy').format(this);
  String get toTime => DateFormat('HH:mm').format(this);
  String get toFormattedDateTime =>
      DateFormat('MMM dd, yyyy HH:mm').format(this);

  // Date checks
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  // Date boundaries
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);
}

// ==================== LIST EXTENSIONS ====================

extension ListExtension<T> on List<T> {
  // Safety checks
  bool get isNullOrEmpty => isEmpty;
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;

  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  // Utility methods
  void addIfNotExists(T element) {
    if (!contains(element)) add(element);
  }

  List<T> get unique => toSet().toList();

  List<List<T>> chunk(int chunkSize) {
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += chunkSize) {
      chunks.add(sublist(i, (i + chunkSize < length) ? i + chunkSize : length));
    }
    return chunks;
  }
}

// ==================== DURATION EXTENSIONS ====================

extension DurationExtension on Duration {
  String get toFormattedString {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  String get toReadableString {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    final parts = <String>[];
    if (hours > 0) parts.add('$hours hour${hours == 1 ? '' : 's'}');
    if (minutes > 0) parts.add('$minutes minute${minutes == 1 ? '' : 's'}');
    if (seconds > 0 && hours == 0)
      parts.add('$seconds second${seconds == 1 ? '' : 's'}');

    return parts.isEmpty ? '0 seconds' : parts.join(' ');
  }

  bool get isZero => inMilliseconds == 0;
  bool get isPositive => inMilliseconds > 0;
}

// ==================== MAP EXTENSIONS ====================

extension MapExtension<K, V> on Map<K, V> {
  bool get isNullOrEmpty => isEmpty;
  V? getOrNull(K key) => this[key];
  V getOrDefault(K key, V defaultValue) => this[key] ?? defaultValue;

  List<K> get keysList => keys.toList();
  List<V> get valuesList => values.toList();
}

// ==================== LOGGING EXTENSIONS ====================

extension LogStringExtension on String {
  /// Print this string as an error message
  /// Example: "Something went wrong".printError();
  void printError() => _appLogger.e(this);

  /// Print this string as a success message
  /// Example: "Task completed".printSuccess();
  void printSuccess() => _appLogger.i('✅ $this');

  /// Print this string as a warning message
  /// Example: "Be careful".printWarning();
  void printWarning() => _appLogger.w(this);

  /// Print this string as an info message
  /// Example: "User logged in".printInfo();
  void printInfo() => _appLogger.i(this);

  /// Print this string as a debug message
  /// Example: "Debug value: $value".printDebug();
  void printDebug() => _appLogger.d(this);

  /// Print this string with custom styling
  /// Example: "Important".printCustom(bold: true);
  void printCustom({
    String? color,
    String? bgColor,
    bool bold = false,
    bool italic = false,
    bool underline = false,
  }) {
    String styledMessage = this;
    if (bold) styledMessage = '**$styledMessage**';
    if (italic) styledMessage = '*$styledMessage*';
    if (underline) styledMessage = '__${styledMessage}__';
    _appLogger.i(styledMessage);
  }
}

extension LogObjectExtension on Object {
  /// Print this object as JSON with pretty formatting
  /// Example: user.printJson();
  void printJson() {
    try {
      _appLogger.i('JSON Data:');
      _appLogger.i(this);
    } catch (e) {
      _appLogger.e('Failed to print JSON: $e');
    }
  }
}
