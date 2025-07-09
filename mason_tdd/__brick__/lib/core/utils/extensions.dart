import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension BuildContextExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  Color get adaptiveColor =>
      isDarkMode ? Theme.of(this).colorScheme.secondary : Colors.black;
}

extension ColorExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension DateTimeExtension on DateTime {
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
}

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
}

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
