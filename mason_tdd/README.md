# mason_tdd 🧱

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)](https://dart.dev)

A comprehensive Flutter TDD (Test-Driven Development) brick for generating complete Flutter projects with **Clean Architecture**, **Bloc/Cubit state management**, and **production-ready** features.

## ✨ Features

### 🏗️ **Clean Architecture**
- **Domain Layer**: Entities, use cases, and repository interfaces
- **Data Layer**: Data sources, models, and repository implementations
- **Presentation Layer**: Pages, cubits, and navigation
- **Dependency Injection**: GetIt-based service locator pattern

### 🔐 **Authentication System**
- Complete login/logout flow
- Token-based authentication with refresh token support
- Secure local storage for user data
- Automatic token refresh with Dio interceptors
- Splash screen with user session validation

### 🎨 **UI/UX Components**
- **Custom AppButton**: Enhanced button widget with loading states, icons, and accessibility
- **AppTextFormField**: Styled form fields with validation
- **AppBar**: Customizable app bar component
- **CachedNetworkImage**: Optimized image loading with caching
- **PaginatedListView**: Efficient list rendering with pagination
- **Theme System**: Centralized color scheme and text styles

### 🌐 **Network Layer**
- **Dio Integration**: HTTP client with interceptors
- **API Response Handling**: Standardized response models
- **Error Management**: Comprehensive error handling and failure types
- **Logging**: Request/response logging with TalkerDioLogger
- **Socket Support**: WebSocket implementation ready

### 📱 **State Management**
- **Flutter Bloc**: Cubit-based state management
- **Pagination Cubit**: Built-in pagination handling
- **Navigation Management**: Custom navigator with transition support

### 🛠️ **Core Services**
- **Image Picker Service**: Camera and gallery integration
- **Location Service**: GPS and location handling
- **Payment Service**: Payment gateway integration ready
- **Local Storage**: Secure data persistence
- **Theme Management**: Dynamic theme switching

### 🎯 **Developer Experience**
- **Screen Responsiveness**: flutter_screenutil integration
- **Extensions**: Helpful Dart extensions
- **Constants**: Global app constants and configurations
- **Utilities**: Image assets, URL management, and more

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Mason CLI

### Installation

1. **Install Mason CLI**:
```bash
dart pub global activate mason_cli
```

2. **Add from BrickHub**:
```bash
mason add --global mason_tdd
```

3. **Generate Project**:
```bash
mason make mason_tdd
```

### Configuration

| Variable | Type | Description | Values / Default |
|----------|------|-------------|------------------|
| `name` | string | Feature name used to generate the page, cubit, model, etc. | `Dash` |
| `dio` | enum | API method to generate for the page | `get`, `post`, `none` |

## 📁 Project Structure

```
lib/
├── config/                 # App configuration
│   ├── navigation/         # Navigation setup and transitions
│   ├── response/           # API response models
│   └── theme/              # Theme configuration
├── core/                   # Core utilities and services
│   ├── constants/          # Global constants
│   ├── services/           # Core services (image, location, payment)
│   ├── show/               # UI feedback utilities
│   ├── utils/              # Helper utilities and extensions
│   └── widgets/            # Reusable UI components
├── data/                   # Data layer
│   ├── datasources/        # Data sources (API, local)
│   ├── models/             # Data models
│   └── repositories/       # Repository implementations
├── domain/                 # Domain layer
│   ├── failures/           # Error handling
│   ├── repositories/        # Repository interfaces
│   └── usecases/           # Business logic
├── features/               # Feature modules
│   ├── auth/               # Authentication features
│   ├── splash/             # Splash screen
│   └── [feature_name]/     # Custom features
└── injection_container.dart # Dependency injection setup
```

## 🔧 Usage Examples

### Creating a New Feature

```bash
mason make mason_tdd_folder
```

This will generate a complete feature module with:
- Cubit for state management
- Page for UI
- Navigator for routing
- Initial parameters
- State definitions

### Using Core Widgets

```dart
// Custom Button (elevated by default; also AppButton.outlined / AppButton.text)
AppButton(
  text: 'Login',
  onPressed: () => _handleLogin(),
  loading: isLoading,
  backgroundColor: AppColors.primary,
)

// Custom Text Field
AppTextFormField(
  controller: _emailController,
  hintText: 'Enter your email',
  required: true,
  validator: (value) =>
      (value != null && value.contains('@')) ? null : 'Invalid email',
)
```

### Network Requests

`NetworkBaseApiService` methods take named parameters and return an
`Either<NetworkFailure, T>` (from `fpdart`):

```dart
// GET Request
final result = await networkRepository.get<Map<String, dynamic>>(
  url: AppUrl.users,
);
result.fold(
  (failure) => handleError(failure),
  (data) => handleSuccess(data),
);

// POST Request
final result = await networkRepository.post<Map<String, dynamic>>(
  url: AppUrl.login,
  body: {'email': email, 'password': password},
);
```

## 🎨 Theming

The brick includes a comprehensive theming system:

```dart
// App Colors — `primary` is provided; additional tokens
// (secondary, error, surface, …) are scaffolded as commented
// placeholders in app_colors.dart for you to enable.
AppColors.primary          // Primary brand color

// Text Styles — Material 3 type scale
AppTextStyles.displayLarge   // Largest display text
AppTextStyles.headlineLarge  // Large headings
AppTextStyles.titleMedium    // Titles
AppTextStyles.bodyLarge      // Body text
```

## 🔐 Authentication Flow

1. **Splash Screen**: Checks for existing user session
2. **Login Screen**: User authentication with email/password
3. **Token Management**: Automatic token refresh
4. **Secure Storage**: Local storage for user data
5. **Navigation**: Automatic routing based on auth state

## 📱 Responsive Design

Built with `flutter_screenutil` for responsive design:

```dart
// Responsive sizing
Container(
  width: 100.w,    // Responsive width
  height: 50.h,    // Responsive height
  margin: EdgeInsets.all(16.r), // Responsive margin
)
```

## 📦 Dependencies

### Core Packages
- `flutter_bloc` - State management
- `get_it` - Dependency injection
- `dio` - HTTP client
- `fpdart` - Functional programming
- `flutter_screenutil` - Responsive design
- `flutter_secure_storage` - Local storage
- `cached_network_image` - Image caching

### Developer Tools
- `talker_dio_logger` - Network logging
- `logger` - Advanced logging
- `shimmer` - Loading animations
- `flutter_dotenv` - Environment variables
- `device_preview` - UI testing (dev)

### Native Services
- `image_picker` - Camera & gallery
- `permission_handler` - Runtime permissions

## 📋 Version Information

Auto-detected when generating:
- **Flutter**: Current version
- **Dart**: Current version
- **Java**: Current version

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

**Powered by [Mason](https://github.com/felangel/mason) 🧱**
