# 🚀 Flutter TDD Architecture Template

A comprehensive Flutter project template implementing **Clean Architecture** with **Test-Driven Development (TDD)** principles, featuring modern state management, dependency injection, and production-ready utilities.

## 📋 Version Information

- **Flutter**: {{flutter_version}}
- **Dart**: {{dart_version}}
- **Java**: {{java_version}}

## 🏗️ Architecture Overview

This template implements **Clean Architecture** with **Test-Driven Development (TDD)** principles, following **Domain-Driven Design (DDD)** approach. The architecture is designed for scalability, maintainability, and testability with clear separation of concerns.

### 🎯 Key Features

- ✅ **Clean Architecture** with clear separation of concerns
- ✅ **TDD/BDD** ready with comprehensive test structure
- ✅ **State Management** with Flutter Bloc/Cubit
- ✅ **Dependency Injection** with GetIt
- ✅ **Error Handling** with Either/Failure pattern
- ✅ **Network Layer** with HTTP interceptors and Dio support
- ✅ **Local Storage** with SharedPreferences
- ✅ **Responsive Design** with ScreenUtil
- ✅ **Image Caching** with CachedNetworkImage
- ✅ **Connectivity** monitoring with real-time updates
- ✅ **Theme Management** with dynamic switching
- ✅ **Image Picker** with camera and gallery support
- ✅ **Permission Handling** for device features
- ✅ **Flutter Release X** integration for automated builds
- ✅ **Comprehensive UI Components** library
- ✅ **Advanced Navigation** with custom transitions
- ✅ **Error Display** with multiple notification types

## 📁 Project Structure

```
lib/
├── 📂 config/                    # Global configuration
│   ├── 📂 navigation/           # Navigation setup and routing
│   │   ├── app_navigator.dart   # Centralized navigation service
│   │   ├── transition_type.dart # Transition type definitions
│   │   ├── transitions.dart     # Custom page transitions
│   │   └── transition_type_checker.dart # Transition logic
│   ├── 📂 response/             # API response handling
│   │   ├── api_response.dart    # Generic API response wrapper
│   │   └── status.dart          # Response status enum
│   └── 📂 theme/                # App theming
│       └── theme_data.dart      # Light/Dark theme configuration
├── 📂 core/                     # Core utilities and services
│   ├── 📂 constants/            # Global constants
│   │   ├── global.dart          # Global keys and constants
│   │   ├── shimmer.dart         # Shimmer loading utilities
│   │   ├── status_switcher.dart # Status-based UI switching
│   │   └── system_ui_overlay.dart # System UI configuration
│   ├── 📂 services/             # Core services
│   │   ├── image_picker_service.dart # Image selection service
│   │   ├── payment_service.dart # Payment processing (commented)
│   │   └── services.dart        # Service exports
│   ├── 📂 show/                 # Error handling and notifications
│   │   ├── checker_navigator_observer.dart # Navigation observer
│   │   └── show/                # Notification mixins
│   │       ├── show.dart        # Main show class
│   │       ├── show_material_banner.dart # Material banner notifications
│   │       └── show_snack_bar.dart # Snackbar notifications
│   ├── 📂 utils/                # Utility functions
│   │   ├── app_images.dart      # Image asset management
│   │   ├── app_url.dart         # URL configuration with env vars
│   │   └── extensions.dart      # Dart extensions (751 lines!)
│   └── 📂 widgets/              # Reusable widgets library
│       ├── app_bar.dart         # Custom app bar
│       ├── app_button.dart      # Button components
│       ├── app_card.dart        # Card components (388 lines)
│       ├── app_dialog.dart      # Dialog components (465 lines)
│       ├── app_print.dart       # Logging utility
│       ├── app_text_form_field.dart # Form field components
│       ├── bottom_sheet_widget.dart # Bottom sheet components (539 lines)
│       ├── cached_network_image_widget.dart # Image caching
│       ├── empty_state_widget.dart # Empty state components (289 lines)
│       ├── image_picker_widget.dart # Image picker UI (534 lines)
│       ├── loading_widget.dart  # Loading components (297 lines)
│       └── search_widget.dart   # Search components (412 lines)
├── 📂 data/                     # Data layer (Repository Pattern)
│   ├── 📂 datasources/          # Data sources (Remote/Local)
│   │   ├── 📂 auth/             # Authentication data sources
│   │   │   ├── login_data_sources.dart # Login state management
│   │   ├── 📂 internet_connectivity/ # Connectivity monitoring
│   │   │   ├── internet_connectivity_checker_data_sources.dart
│   │   └── 📂 theme/            # Theme data sources
│   │       └── theme_data_source.dart
│   ├── 📂 models/               # Data models
│   │   ├── 📂 auth/             # Auth models
│   │   │   └── login/           # Login models
│   │   ├── 📂 local/            # Local storage models
│   │   │   └── local_user_info_store_model.dart
│   │   ├── 📂 {{folder_name}}/  # Feature models
│   │   │   └── {{model_file_name}}
│   │   └── pagination_model.dart # Pagination support
│   └── 📂 repositories/         # Repository implementations
│       ├── 📂 local/            # Local repositories
│       │   └── insecure_local_storage_repository.dart
│       └── 📂 network/          # Network repositories
│           ├── 📂 dio/          # Dio HTTP client
│           │   ├── dio_config.dart # Dio configuration (369 lines)
│           │   ├── dio_network_repository.dart
│           │   └── dio_usage_examples.dart
│           ├── 📂 https/        # HTTP client
│           │   ├── https_network_repository.dart
│           │   └── interceptor.dart
│           └── 📂 socket/       # WebSocket support
│               └── socket_network_repository.dart
├── 📂 domain/                   # Business logic layer
│   ├── 📂 failures/             # Error handling
│   │   ├── 📂 local/            # Local failures
│   │   │   ├── existing_user_failure.dart
│   │   │   ├── get_local_storage_failure.dart
│   │   │   ├── remove_local_storage_failure.dart
│   │   │   └── set_local_storage_failure.dart
│   │   ├── 📂 network/          # Network failures
│   │   │   └── network_failure.dart
│   │   └── 📂 theme/            # Theme failures
│   │       ├── get_theme_failure.dart
│   │       └── update_theme_failure.dart
│   ├── 📂 repositories/         # Repository interfaces
│   │   ├── 📂 local/            # Local repository contracts
│   │   │   └── local_storage_base_api_service.dart
│   │   └── 📂 network/          # Network repository contracts
│   │       ├── network_base_api_service.dart
│   │       └── socket_network_base_api_service.dart
│   └── 📂 usecases/             # Business use cases
│       ├── 📂 auth/             # Auth use cases
│       │   └── login/           # Login use cases
│       ├── 📂 local/            # Local use cases
│       │   └── check_for_existing_user_use_case.dart
│       └── 📂 theme/            # Theme use cases
│           ├── get_theme_use_case.dart
│           └── update_theme_use_case.dart
├── 📂 features/                 # Feature modules
│   ├── 📂 auth/                 # Authentication feature
│   │   ├── 📂 login/            # Login feature
│   │   │   ├── login_cubit.dart # Login state management
│   │   │   ├── login_initial_params.dart
│   │   │   ├── login_navigator.dart
│   │   │   ├── login_page.dart  # Login UI
│   │   │   └── login_state.dart # Login states
│   │   └── 📂 splash/           # Splash screen
│   │       ├── splash_cubit.dart
│   │       ├── splash_initial_params.dart
│   │       ├── splash_navigator.dart
│   │       ├── splash_page.dart
│   │       └── splash_state.dart
│   └── 📂 {{folder_name}}/      # Main feature
│       ├── {{cubit_file_name}}  # State management
│       ├── {{initial_params_file_name}}  # Initial parameters
│       ├── {{navigator_file_name}}       # Feature navigation
│       ├── {{page_file_name}}            # UI page
│       └── {{state_file_name}}           # State definitions
├── injection_container.dart     # Dependency injection setup
└── {{main}}                     # Main application entry point
```

## 🧪 Testing Strategy

### Test Structure

```
test/
├── 📂 unit/                     # Unit tests
│   ├── 📂 data/                 # Data layer tests
│   │   ├── 📂 datasources/      # Data source tests
│   │   ├── 📂 models/           # Model tests
│   │   └── 📂 repositories/     # Repository tests
│   ├── 📂 domain/               # Domain layer tests
│   │   ├── 📂 failures/         # Failure tests
│   │   ├── 📂 repositories/     # Repository interface tests
│   │   └── 📂 usecases/         # Use case tests
│   └── 📂 core/                 # Core utilities tests
│       ├── 📂 services/         # Service tests
│       ├── 📂 utils/            # Utility tests
│       └── 📂 widgets/          # Widget tests
├── 📂 widget/                   # Widget tests
│   ├── 📂 features/             # Feature widget tests
│   └── 📂 core/                 # Core widget tests
└── 📂 integration/              # Integration tests
    ├── 📂 auth/                 # Authentication flow tests
    └── 📂 features/             # Feature integration tests
```

### Testing Principles

- **TDD Cycle**: Red → Green → Refactor
- **AAA Pattern**: Arrange → Act → Assert
- **Mocking**: Use Mockito/Mocktail for dependencies
- **Coverage**: Aim for 80%+ code coverage
- **Test Isolation**: Each test is independent
- **Meaningful Assertions**: Test behavior, not implementation

## 🔧 State Management

### Flutter Bloc Pattern

The template supports both **Cubit** and **Bloc** patterns:

- **Cubit**: Simple state management for basic features
- **Bloc**: Complex state management with events
- **State**: Immutable state objects

### Example Usage

```dart
// Cubit Implementation
class {{class_name}}Cubit extends Cubit<{{class_name}}State> {
  final {{class_name}}Repository _repository;

  {{class_name}}Cubit(this._repository) : super({{class_name}}Initial());

  Future<void> loadData() async {
    emit({{class_name}}Loading());

    final result = await _repository.getData();

    result.fold(
      (failure) => emit({{class_name}}Error(failure.message)),
      (data) => emit({{class_name}}Loaded(data)),
    );
  }
}

// State Definition
abstract class {{class_name}}State {
  const {{class_name}}State();
}

class {{class_name}}Initial extends {{class_name}}State {}
class {{class_name}}Loading extends {{class_name}}State {}
class {{class_name}}Loaded extends {{class_name}}State {
  final List<{{class_name}}Model> data;
  const {{class_name}}Loaded(this.data);
}
class {{class_name}}Error extends {{class_name}}State {
  final String message;
  const {{class_name}}Error(this.message);
}
```

## 🌐 Network Layer

### Multiple HTTP Client Support

The template provides multiple network layer implementations:

1. **HTTP Client** with interceptors
2. **Dio Client** with advanced features
3. **WebSocket** support for real-time communication

### HTTP Client Setup

```dart
// Base API Service
abstract class NetworkBaseApiService {
  Future<Either<NetworkFailure, T>> get<T>(String endpoint);
  Future<Either<NetworkFailure, T>> post<T>(String endpoint, dynamic data);
  Future<Either<NetworkFailure, T>> put<T>(String endpoint, dynamic data);
  Future<Either<NetworkFailure, T>> delete<T>(String endpoint);
}

// API Response Pattern
class ApiResponse<T> {
  final Status status;
  final T? data;
  final String? message;

  ApiResponse.initial() : status = Status.INITIAL;
  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;
}
```

### Dio Configuration (Advanced)

The template includes a comprehensive Dio setup with:

- **Logging Interceptor**: Request/Response logging
- **Auth Interceptor**: Automatic token management
- **Error Interceptor**: Global error handling
- **Retry Interceptor**: Automatic retry logic
- **Cache Interceptor**: Response caching
- **Form Data Helper**: File upload support

## 💉 Dependency Injection

### GetIt Setup

The template uses GetIt for dependency injection with automatic setup:

```dart
// Core services registration
getIt.registerLazySingleton<Connectivity>(() => Connectivity());
getIt.registerLazySingleton<ImagePickerService>(() => ImagePickerService());
getIt.registerLazySingleton<LocalStorageRepository>(
  () => InsecureLocalStorageRepository(),
);

// Feature services registration
getIt.registerFactory<{{class_name}}Cubit>(
  () => {{class_name}}Cubit(getIt<{{class_name}}Repository>()),
);

// Repository registration
getIt.registerLazySingleton<{{class_name}}Repository>(
  () => {{class_name}}RepositoryImpl(
    networkInfo: getIt<NetworkInfo>(),
    remoteDataSource: getIt<{{class_name}}RemoteDataSource>(),
    localDataSource: getIt<{{class_name}}LocalDataSource>(),
  ),
);
```

## 🎨 UI/UX Features

### Comprehensive Widget Library

The template includes a rich collection of reusable widgets:

#### Core Widgets

- **AppButton**: Multiple button styles with loading states
- **AppCard**: Various card types (Info, Action, Stats, Profile)
- **AppDialog**: Multiple dialog types (Confirm, Alert, Input, Loading)
- **AppBottomSheet**: Advanced bottom sheet with actions and filters
- **AppTextFormField**: Customizable form fields

#### Specialized Widgets

- **ImagePickerWidget**: Camera and gallery image selection
- **SearchWidget**: Advanced search with filters and voice support
- **LoadingWidget**: Multiple loading animations (Circular, Linear, Dots, Pulse)
- **EmptyStateWidget**: Contextual empty states
- **CachedNetworkImage**: Optimized image loading with caching

### Responsive Design

- **ScreenUtil**: Responsive sizing across all devices
- **Flexible Layouts**: Adaptive UI components
- **Platform Adaptation**: iOS/Android specific styling
- **Orientation Support**: Landscape and portrait layouts

### Theme Management

```dart
// Dynamic theme switching
class ThemeViewModel extends Cubit<bool> {
  ThemeViewModel() : super(false);

  void toggleTheme() => emit(!state);

  ThemeData get currentTheme => state ? darkTheme : lightTheme;
}
```

## 📱 Navigation

### Feature-based Navigation

```dart
// Feature Navigator
class {{class_name}}Navigator {
  static const String routeName = '/{{folder_name}}';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const {{class_name}}Page(),
    );
  }
}

// Custom Transitions
enum TransitionType {
  slideFromRight,
  slideFromLeft,
  slideFromBottom,
  slideFromTop,
}
```

### Navigation Features

- **Feature Navigators**: Isolated navigation per feature
- **Custom Transitions**: Smooth page transitions
- **Deep Linking**: URL-based navigation support
- **Navigation Observer**: Automatic message clearing

## 🔒 Error Handling

### Failure Pattern

```dart
// Base Failure
abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// Specific Failures
class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure(String message) : super(message);
}
```

### Error Display System

The template provides multiple error display options:

- **SnackBars**: Quick user feedback with animations
- **Material Banners**: Persistent error messages
- **Error Pages**: Dedicated error screens
- **Status Switcher**: Automatic UI state switching

## 🚀 Getting Started

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Environment Setup

The template automatically creates a `.env` file with:

```env
# API Configuration
BASE_URL=https://your-api-url.com

# GitHub Configuration (for Flutter Release X)
GITHUB_TOKEN=your_github_token
GITHUB_REPOSITORY=username/repository

# Google Drive Configuration
GOOGLE_DRIVE_CLIENT_ID=your_client_id
GOOGLE_DRIVE_CLIENT_SECRET=your_client_secret
GOOGLE_DRIVE_FOLDER_ID=your_folder_id

# Slack Configuration
SLACK_BOT_TOKEN=your_bot_token
SLACK_CHANNEL_ID=your_channel_id
SLACK_MEMBER_IDS=user1,user2
```

### 3. Run Tests

```bash
flutter test
```

### 4. Start Development

```bash
flutter run
```

## 🌱 Environment Variables

This project uses `flutter_dotenv` for environment configuration with automatic setup.

### Usage in Code

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Access environment variables
final baseUrl = dotenv.env['BASE_URL'];
final apiKey = dotenv.env['API_KEY'];
```

### Automatic Setup

The template automatically:

- ✅ Installs `flutter_dotenv` dependency
- ✅ Creates `.env` file with sample configuration
- ✅ Adds `.env` to `pubspec.yaml` assets
- ✅ Loads environment variables in `main.dart`

## 📦 Included Packages

### Core Dependencies

| Package                | Version | Purpose                       |
| ---------------------- | ------- | ----------------------------- |
| `flutter_bloc`         | Latest  | State management              |
| `get_it`               | Latest  | Dependency injection          |
| `fpdart`               | Latest  | Functional programming        |
| `http`                 | Latest  | HTTP client                   |
| `http_interceptor`     | Latest  | Request/Response interceptors |
| `flutter_screenutil`   | Latest  | Responsive design             |
| `shimmer`              | Latest  | Loading animations            |
| `cached_network_image` | Latest  | Image caching                 |
| `connectivity_plus`    | Latest  | Network connectivity          |
| `shared_preferences`   | Latest  | Local storage                 |
| `flutter_dotenv`       | Latest  | Environment variables         |
| `logger`               | Latest  | Advanced logging              |
| `image_picker`         | Latest  | Image selection               |
| `permission_handler`   | Latest  | Device permissions            |

### Development Dependencies

| Package          | Version | Purpose                    |
| ---------------- | ------- | -------------------------- |
| `device_preview` | Latest  | Device preview for testing |

## 🎯 Best Practices

### Code Organization

- **Single Responsibility**: Each class has one reason to change
- **Dependency Inversion**: Depend on abstractions, not concretions
- **Interface Segregation**: Small, focused interfaces
- **Open/Closed**: Open for extension, closed for modification
- **Clean Architecture**: Clear layer separation

### Performance Optimization

- **Lazy Loading**: Load resources on demand
- **Caching**: Cache network responses and images
- **Memory Management**: Dispose resources properly
- **Widget Optimization**: Use const constructors
- **Image Optimization**: Automatic image compression and caching

### Security

- **Input Validation**: Validate all user inputs
- **Secure Storage**: Use secure storage for sensitive data
- **Network Security**: Implement certificate pinning
- **Code Obfuscation**: Protect source code
- **Permission Handling**: Proper device permission management

## 🔄 Continuous Integration

### Flutter Release X Integration

The template includes Flutter Release X for automated builds and releases:

```bash
# Build for both platforms
frx build -t android,ios

# Build with specific flavor
frx build -f release

# Upload to stores
frx upload
```

### CI/CD Pipeline

- **Code Quality**: Linting and formatting checks
- **Testing**: Automated test execution
- **Build Verification**: Multi-platform builds
- **Deployment**: Automated app store deployment

## 📈 Monitoring & Analytics

### Performance Monitoring

- **Crash Reporting**: Automatic crash detection
- **Performance Metrics**: App performance tracking
- **User Analytics**: User behavior insights
- **Error Tracking**: Real-time error monitoring

### Logging System

```dart
// Advanced logging with AppPrint
AppPrint.success('Operation completed successfully');
AppPrint.error('An error occurred: $error');
AppPrint.warning('Warning: $warning');
AppPrint.info('Info: $info');
AppPrint.debug('Debug: $debug');
AppPrint.json(jsonData); // Pretty JSON printing
```

## 🛠️ Advanced Features

### Image Picker Service

```dart
// Camera capture
final image = await ImagePickerService().pickImageFromCamera();

// Gallery selection
final image = await ImagePickerService().pickImageFromGallery();

// Multiple images
final images = await ImagePickerService().pickMultipleImagesFromGallery();

// Custom dialog
final image = await ImagePickerService().showImagePickerDialog(context);
```

### Connectivity Monitoring

```dart
// Real-time connectivity monitoring
class InternetConnectivityCheckerDataSources extends Cubit<bool> {
  // Automatically monitors network changes
  // Shows/hides connection banners
  // Provides real-time connectivity status
}
```

### Advanced UI Components

The template includes sophisticated UI components:

- **StatusSwitcher**: Automatic UI state management
- **FilterBottomSheet**: Advanced filtering interface
- **ShareBottomSheet**: Social sharing functionality
- **VoiceSearchWidget**: Voice-enabled search
- **CategorySearchWidget**: Category-based search

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Write tests for new features
4. Ensure all tests pass (`flutter test`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Development Guidelines

- Follow the existing code style
- Write comprehensive tests
- Update documentation
- Ensure backward compatibility
- Add meaningful commit messages

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Bloc Library** for state management
- **Very Good Ventures** for architecture inspiration
- **Flutter Community** for excellent packages

---

**Built with ❤️ using Flutter and Clean Architecture principles**

_This template is designed to help you build production-ready Flutter applications with best practices, comprehensive testing, and modern development tools._
