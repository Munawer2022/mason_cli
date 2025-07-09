import 'dart:convert';

class AppPrint {
  static const String _resetColor = '\x1B[0m';

  // Text colors
  static const String _redColor = '\x1B[31m';
  static const String _greenColor = '\x1B[32m';
  static const String _yellowColor = '\x1B[33m';
  static const String _blueColor = '\x1B[34m';
  static const String _magentaColor = '\x1B[35m';
  static const String _cyanColor = '\x1B[36m';
  static const String _whiteColor = '\x1B[37m';

  // Background colors
  static const String _redBgColor = '\x1B[41m';
  static const String _greenBgColor = '\x1B[42m';
  static const String _yellowBgColor = '\x1B[43m';
  static const String _blueBgColor = '\x1B[44m';
  static const String _magentaBgColor = '\x1B[45m';
  static const String _cyanBgColor = '\x1B[46m';
  static const String _whiteBgColor = '\x1B[47m';

  // Text styles
  static const String _boldText = '\x1B[1m';
  static const String _italicText = '\x1B[3m';
  static const String _underlineText = '\x1B[4m';

  /// Print error message in red
  static void error(String message) {
    print('$_redColor$_boldText[ERROR] $message$_resetColor');
  }

  /// Print success message in green
  static void success(String message) {
    print('$_greenColor$_boldText[SUCCESS] $message$_resetColor');
  }

  /// Print warning message in yellow
  static void warning(String message) {
    print('$_yellowColor$_boldText[WARNING] $message$_resetColor');
  }

  /// Print info message in blue
  static void info(String message) {
    print('$_blueColor$_boldText[INFO] $message$_resetColor');
  }

  /// Print debug message in cyan
  static void debug(String message) {
    print('$_cyanColor$_boldText[DEBUG] $message$_resetColor');
  }

  /// Print custom message with specified color
  static void custom(
    String message, {
    String color = _whiteColor,
    String? bgColor,
    bool bold = false,
    bool italic = false,
    bool underline = false,
  }) {
    String style = '';
    if (bold) style += _boldText;
    if (italic) style += _italicText;
    if (underline) style += _underlineText;

    print('$color${bgColor ?? ''}$style$message$_resetColor');
  }

  /// Print JSON with pretty formatting
  static void json(dynamic jsonData) {
    try {
      final prettyJson = const JsonEncoder.withIndent('  ').convert(jsonData);
      print('$_cyanColor$_boldText[JSON] $prettyJson$_resetColor');
    } catch (e) {
      error('Failed to print JSON: $e');
    }
  }
}
