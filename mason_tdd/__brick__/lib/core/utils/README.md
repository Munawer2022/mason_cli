# Extensions Documentation

This file contains useful Dart extensions for Flutter development.

## BuildContext Extensions

### TextThemeExtension

Access text theme from BuildContext:

```dart
context.textTheme.headlineLarge
```

### BuildContextExtension

Theme and screen utilities:

```dart
context.isDarkMode          // Check if dark mode
context.adaptiveColor       // Get adaptive color
context.screenSize          // Get screen size
context.screenWidth         // Get screen width
context.screenHeight        // Get screen height
context.statusBarHeight     // Get status bar height
context.bottomPadding       // Get bottom padding
```

### ColorExtension

Access theme data:

```dart
context.theme.colorScheme.primary
```

## DateTime Extensions

### DateTimeExtension

Human-readable time formatting:

```dart
DateTime.now().timeAgo      // "2 hours ago"
dateTime.toDateString       // "2024-01-15"
dateTime.toTimeString       // "14:30"
dateTime.isToday           // true/false
dateTime.isYesterday       // true/false
```

## String Extensions

### StringExtension

String utilities:

```dart
"test@email.com".isEmail   // true
"+1234567890".isPhone      // true
"hello world".capitalize   // "Hello world"
"hello world".titleCase    // "Hello World"
"hello   world".trimExtra  // "hello world"
"12345".isNumeric          // true
"https://example.com".isUrl // true
"John Doe".initials        // "JD"
```

## List Extensions

### ListExtension

List utilities:

```dart
list.removeDuplicates      // Remove duplicates
list.firstOrNull          // Get first or null
list.lastOrNull           // Get last or null
list.addIfNotNull(item)   // Add if not null
list.elementAtOrNull(5)   // Get element safely
```

## Map Extensions

### MapExtension

Map utilities:

```dart
map.removeNullValues       // Remove null values
map.getOrDefault(key, default) // Get with default
map.containsKeyAndValue(key)   // Check key and value
```

## Number Extensions

### NumExtension

Number utilities:

```dart
number.isPositive         // true/false
number.isNegative         // true/false
number.isZero             // true/false
number.absolute           // Absolute value
number.clampBetween(0, 100) // Clamp between values
number.isBetween(0, 100)  // Check if between
```

## Widget Extensions

### WidgetExtension

Widget utilities:

```dart
widget.padding(EdgeInsets.all(16))
widget.margin(EdgeInsets.all(16))
widget.center
widget.expanded
widget.flexible(2)
widget.onTap(() => print('tapped'))
widget.visible(true)
```

## Usage

Import the extensions in your Dart files:

```dart
import '/core/utils/extensions.dart';
```

These extensions provide convenient utilities for common Flutter development tasks and help reduce boilerplate code.
