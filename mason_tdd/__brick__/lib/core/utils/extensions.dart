import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// MARK: - BuildContext Extensions

extension BuildContextExtension on BuildContext {
  /// Get the current theme
  ThemeData get theme => Theme.of(this);

  /// Get the current text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get the current color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Check if the app is in dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Get adaptive color based on theme
  Color get adaptiveColor => isDarkMode ? colorScheme.secondary : Colors.black;

  /// Get the screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get the screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get the screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Get the device pixel ratio
  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Get the status bar height
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// Get the bottom padding (for devices with home indicator)
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// Get the safe area padding
  EdgeInsets get safeAreaPadding => MediaQuery.of(this).padding;

  /// Check if the device is in landscape mode
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Check if the device is in portrait mode
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  /// Get the current locale
  Locale get locale => Localizations.localeOf(this);

  /// Check if the device has a notch
  bool get hasNotch => MediaQuery.of(this).viewPadding.top > 0;

  /// Get the current route name
  String? get currentRoute => ModalRoute.of(this)?.settings.name;

  /// Show a snackbar
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }

  /// Show a snackbar with action
  void showSnackBarWithAction({
    required String message,
    required String actionLabel,
    required VoidCallback onAction,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 4),
        action: SnackBarAction(label: actionLabel, onPressed: onAction),
      ),
    );
  }

  /// Hide keyboard
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// Check if keyboard is visible
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Get the height available for content (excluding keyboard)
  double get availableHeight =>
      screenHeight - MediaQuery.of(this).viewInsets.bottom;
}

// MARK: - DateTime Extensions

extension DateTimeExtension on DateTime {
  /// Get relative time string (e.g., "2 hours ago")
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

  /// Format date as "MMM dd, yyyy"
  String get toFormattedDate {
    return DateFormat('MMM dd, yyyy').format(this);
  }

  /// Format date as "dd/MM/yyyy"
  String get toShortDate {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  /// Format time as "HH:mm"
  String get toTime {
    return DateFormat('HH:mm').format(this);
  }

  /// Format date and time as "MMM dd, yyyy HH:mm"
  String get toFormattedDateTime {
    return DateFormat('MMM dd, yyyy HH:mm').format(this);
  }

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

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Get the start of the day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get the end of the day (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  /// Get the start of the week (Monday)
  DateTime get startOfWeek {
    final daysFromMonday = weekday - 1;
    return subtract(Duration(days: daysFromMonday));
  }

  /// Get the end of the week (Sunday)
  DateTime get endOfWeek {
    final daysUntilSunday = 7 - weekday;
    return add(Duration(days: daysUntilSunday));
  }

  /// Get the start of the month
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Get the end of the month
  DateTime get endOfMonth => DateTime(year, month + 1, 0);

  /// Get age in years
  int get age {
    final now = DateTime.now();
    int age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }

  /// Check if date is in the past
  bool get isPast => isBefore(DateTime.now());

  /// Check if date is in the future
  bool get isFuture => isAfter(DateTime.now());

  /// Get days until this date
  int get daysUntil {
    final now = DateTime.now();
    return difference(now).inDays;
  }

  /// Get days since this date
  int get daysSince {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}

// MARK: - Number Extensions

extension NumberFormatExtension on num {
  /// Formats a number as currency with proper formatting
  String get toCurrency {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    return formatter.format(this);
  }

  /// Formats a number as pound sterling with proper formatting
  String get toPoundCurrency {
    final formatter = NumberFormat.currency(symbol: '£', decimalDigits: 2);
    return formatter.format(this);
  }

  /// Formats a number as currency without decimal places for whole numbers
  String get toCurrencyCompact {
    if (this == toInt()) {
      final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
      return formatter.format(this);
    } else {
      return toCurrency;
    }
  }

  /// Formats a number as pound sterling without decimal places for whole numbers
  String get toPoundCurrencyCompact {
    if (this == toInt()) {
      final formatter = NumberFormat.currency(symbol: '£', decimalDigits: 0);
      return formatter.format(this);
    } else {
      return toPoundCurrency;
    }
  }

  /// Formats a number with comma separators for thousands
  String get toFormattedNumber {
    final formatter = NumberFormat('#,###');
    return formatter.format(this);
  }

  /// Formats a number as percentage
  String get toPercentage {
    final formatter = NumberFormat('#,##0.0%');
    return formatter.format(this / 100);
  }

  /// Convert to duration in milliseconds
  Duration get milliseconds => Duration(milliseconds: toInt());

  /// Convert to duration in seconds
  Duration get seconds => Duration(seconds: toInt());

  /// Convert to duration in minutes
  Duration get minutes => Duration(minutes: toInt());

  /// Convert to duration in hours
  Duration get hours => Duration(hours: toInt());

  /// Convert to duration in days
  Duration get days => Duration(days: toInt());

  /// Check if number is positive
  bool get isPositive => this > 0;

  /// Check if number is negative
  bool get isNegative => this < 0;

  /// Check if number is zero
  bool get isZero => this == 0;

  /// Check if number is even
  bool get isEven => this % 2 == 0;

  /// Check if number is odd
  bool get isOdd => this % 2 != 0;

  /// Clamp number between min and max values
  num clamp(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Convert to double with null safety
  double? get toDoubleOrNull => isFinite ? toDouble() : null;

  /// Convert to int with null safety
  int? get toIntOrNull => isFinite ? toInt() : null;

  /// Format file size (bytes to KB, MB, GB)
  String get toFileSize {
    if (this < 1024) return '${toStringAsFixed(0)} B';
    if (this < 1024 * 1024) return '${(this / 1024).toStringAsFixed(1)} KB';
    if (this < 1024 * 1024 * 1024)
      return '${(this / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Format duration (seconds to HH:mm:ss)
  String get toDuration {
    final hours = (this / 3600).floor();
    final minutes = ((this % 3600) / 60).floor();
    final seconds = (this % 60).floor();

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }
}

// MARK: - String Extensions

extension StringNumberFormatExtension on String {
  /// Converts string to number and formats as currency
  String get toCurrencyFromString {
    final number = double.tryParse(this) ?? 0.0;
    return number.toCurrency;
  }

  /// Converts string to number and formats as pound sterling
  String get toPoundCurrencyFromString {
    final number = double.tryParse(this) ?? 0.0;
    return number.toPoundCurrency;
  }

  /// Converts string to number and formats with comma separators
  String get toFormattedNumberFromString {
    final number = double.tryParse(this) ?? 0.0;
    return number.toFormattedNumber;
  }
}

extension StringExtension on String {
  /// Check if string is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Check if string is not null and not empty
  bool get isNotNullOrEmpty => isNotEmpty;

  /// Check if string is null, empty, or only whitespace
  bool get isNullOrWhitespace => trim().isEmpty;

  /// Check if string is not null, not empty, and not only whitespace
  bool get isNotNullOrWhitespace => trim().isNotEmpty;

  /// Capitalize first letter of string
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize first letter of each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Convert to title case
  String get toTitleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Convert to camel case
  String get toCamelCase {
    if (isEmpty) return this;
    final words = split(RegExp(r'[_\s-]+'));
    if (words.length == 1) return words[0].toLowerCase();
    return words[0].toLowerCase() +
        words.skip(1).map((word) => word.capitalize).join();
  }

  /// Convert to snake case
  String get toSnakeCase {
    if (isEmpty) return this;
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    ).replaceAll(RegExp(r'[_\s-]+'), '_').toLowerCase();
  }

  /// Convert to kebab case
  String get toKebabCase {
    if (isEmpty) return this;
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '-${match.group(0)!.toLowerCase()}',
    ).replaceAll(RegExp(r'[_\s-]+'), '-').toLowerCase();
  }

  /// Check if string is a valid email
  bool get isEmail {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }

  /// Check if string is a valid phone number
  bool get isPhoneNumber {
    final phoneRegex = RegExp(r'^\+?[\d\s-\(\)]{10,}$');
    return phoneRegex.hasMatch(this);
  }

  /// Check if string is a valid URL
  bool get isUrl {
    try {
      Uri.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Check if string is a valid date
  bool get isDate {
    try {
      DateTime.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Check if string contains only digits
  bool get isNumeric {
    return RegExp(r'^\d+$').hasMatch(this);
  }

  /// Check if string contains only letters
  bool get isAlphabetic {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }

  /// Check if string contains only letters and numbers
  bool get isAlphanumeric {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  }

  /// Truncate string to specified length with ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  /// Remove all whitespace from string
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Remove special characters from string
  String get removeSpecialCharacters =>
      replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');

  /// Extract numbers from string
  String get extractNumbers => replaceAll(RegExp(r'[^0-9]'), '');

  /// Extract letters from string
  String get extractLetters => replaceAll(RegExp(r'[^a-zA-Z]'), '');

  /// Reverse string
  String get reversed => split('').reversed.join();

  /// Count words in string
  int get wordCount {
    if (isEmpty) return 0;
    return split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  /// Count characters in string (excluding whitespace)
  int get characterCount => replaceAll(RegExp(r'\s+'), '').length;

  /// Get initials from name (e.g., "John Doe" -> "JD")
  String get initials {
    if (isEmpty) return '';
    final words = split(' ').where((word) => word.isNotEmpty).toList();
    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

  /// Mask string (e.g., "1234567890" -> "******7890")
  String mask({int visibleChars = 4, String maskChar = '*'}) {
    if (length <= visibleChars) return this;
    final visible = substring(length - visibleChars);
    final masked = maskChar * (length - visibleChars);
    return '$masked$visible';
  }

  /// Format phone number (e.g., "1234567890" -> "(123) 456-7890")
  String get formatPhoneNumber {
    final cleaned = extractNumbers;
    if (cleaned.length != 10) return this;
    return '(${cleaned.substring(0, 3)}) ${cleaned.substring(3, 6)}-${cleaned.substring(6)}';
  }

  /// Format credit card number (e.g., "1234567890123456" -> "1234 **** **** 3456")
  String get formatCreditCard {
    final cleaned = extractNumbers;
    if (cleaned.length != 16) return this;
    return '${cleaned.substring(0, 4)} **** **** ${cleaned.substring(12)}';
  }

  /// Convert string to int with null safety
  int? get toIntOrNull => int.tryParse(this);

  /// Convert string to double with null safety
  double? get toDoubleOrNull => double.tryParse(this);

  /// Convert string to bool
  bool get toBool {
    final lower = toLowerCase();
    return lower == 'true' || lower == '1' || lower == 'yes';
  }

  /// Convert string to DateTime with null safety
  DateTime? get toDateTimeOrNull {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }

  /// Convert string to Uri with null safety
  Uri? get toUriOrNull {
    try {
      return Uri.parse(this);
    } catch (e) {
      return null;
    }
  }
}

// MARK: - List Extensions

extension ListExtension<T> on List<T> {
  /// Check if list is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Check if list is not null and not empty
  bool get isNotNullOrEmpty => isNotEmpty;

  /// Get first element or null if list is empty
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null if list is empty
  T? get lastOrNull => isEmpty ? null : last;

  /// Get element at index or null if index is out of bounds
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Add element if it doesn't already exist
  void addIfNotExists(T element) {
    if (!contains(element)) {
      add(element);
    }
  }

  /// Remove element if it exists
  void removeIfExists(T element) {
    if (contains(element)) {
      remove(element);
    }
  }

  /// Get a random element from the list
  T? get randomElement {
    if (isEmpty) return null;
    return this[DateTime.now().millisecondsSinceEpoch % length];
  }

  /// Shuffle the list and return a new list
  List<T> get shuffled => List.from(this)..shuffle();

  /// Get unique elements from the list
  List<T> get unique => toSet().toList();

  /// Get elements that appear more than once
  List<T> get duplicates {
    final seen = <T>{};
    final duplicates = <T>{};
    for (final element in this) {
      if (!seen.add(element)) {
        duplicates.add(element);
      }
    }
    return duplicates.toList();
  }

  /// Split list into chunks of specified size
  List<List<T>> chunk(int chunkSize) {
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += chunkSize) {
      chunks.add(sublist(i, (i + chunkSize < length) ? i + chunkSize : length));
    }
    return chunks;
  }

  /// Get elements that satisfy the condition
  List<T> whereNotNull() {
    return where((element) => element != null).cast<T>().toList();
  }
}

// MARK: - Map Extensions

extension MapExtension<K, V> on Map<K, V> {
  /// Check if map is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Check if map is not null and not empty
  bool get isNotNullOrEmpty => isNotEmpty;

  /// Get value for key or null if key doesn't exist
  V? getOrNull(K key) => this[key];

  /// Get value for key or default value if key doesn't exist
  V getOrDefault(K key, V defaultValue) => this[key] ?? defaultValue;

  /// Add key-value pair if key doesn't exist
  void putIfAbsent(K key, V value) {
    if (!containsKey(key)) {
      this[key] = value;
    }
  }

  /// Remove key-value pair if key exists
  void removeIfExists(K key) {
    if (containsKey(key)) {
      remove(key);
    }
  }

  /// Get all keys as a list
  List<K> get keysList => keys.toList();

  /// Get all values as a list
  List<V> get valuesList => values.toList();

  /// Get entries as a list
  List<MapEntry<K, V>> get entriesList => entries.toList();

  /// Filter map by keys
  Map<K, V> filterKeys(bool Function(K key) predicate) {
    return Map.fromEntries(entries.where((entry) => predicate(entry.key)));
  }

  /// Filter map by values
  Map<K, V> filterValues(bool Function(V value) predicate) {
    return Map.fromEntries(entries.where((entry) => predicate(entry.value)));
  }

  /// Transform map values
  Map<K, R> mapValues<R>(R Function(V value) transform) {
    return Map.fromEntries(
      entries.map((entry) => MapEntry(entry.key, transform(entry.value))),
    );
  }

  /// Transform map keys
  Map<R, V> mapKeys<R>(R Function(K key) transform) {
    return Map.fromEntries(
      entries.map((entry) => MapEntry(transform(entry.key), entry.value)),
    );
  }
}

// MARK: - Duration Extensions

extension DurationExtension on Duration {
  /// Format duration as "HH:mm:ss"
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

  /// Format duration as "2 hours 30 minutes"
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

  /// Check if duration is zero
  bool get isZero => inMilliseconds == 0;

  /// Check if duration is positive
  bool get isPositive => inMilliseconds > 0;

  /// Check if duration is negative
  bool get isNegative => inMilliseconds < 0;

  /// Get duration in days
  int get inDays => inMilliseconds ~/ (24 * 60 * 60 * 1000);

  /// Get duration in weeks
  int get inWeeks => inDays ~/ 7;

  /// Get duration in months (approximate)
  int get inMonths => inDays ~/ 30;
g
  /// Get duration in years (approximate)
  int get inYears => inDays ~/ 365;
}
