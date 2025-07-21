# 🚀 Flutter TDD Architecture Template

## 📋 Version Information

- **Flutter**: {{flutter_version}}
- **Dart**: {{dart_version}}
- **Java**: {{java_version}}

## 🏗️ Architecture Overview

This template implements **Clean Architecture** with **Test-Driven Development (TDD)** principles, following the **Domain-Driven Design (DDD)** approach. The architecture is designed for scalability, maintainability, and testability.

### 🎯 Key Features

- ✅ **Clean Architecture** with clear separation of concerns
- ✅ **TDD/BDD** ready with comprehensive test structure
- ✅ **State Management** with Flutter Bloc
- ✅ **Dependency Injection** with GetIt
- ✅ **Error Handling** with Either/Failure pattern
- ✅ **Network Layer** with HTTP interceptors
- ✅ **Local Storage** with SharedPreferences
- ✅ **Responsive Design** with ScreenUtil
- ✅ **Image Caching** with CachedNetworkImage
- ✅ **Connectivity** monitoring
- ✅ **Theme Management** with dynamic switching

## 📁 Project Structure

```
lib/
├── 📂 config/                    # Global configuration
│   ├── 📂 navigation/           # Navigation setup and routing
│   │   ├── app_navigator.dart
│   │   ├── transition_type.dart
│   │   └── transitions.dart
│   ├── 📂 response/             # API response handling
│   │   ├── api_response.dart
│   │   └── status.dart
│   └── 📂 theme/                # App theming
│       └── theme_data.dart
├── 📂 core/                     # Core utilities and services
│   ├── 📂 constants/            # Global constants
│   │   ├── global.dart
│   │   ├── shimmer.dart
│   │   ├── status_switcher.dart
│   │   └── system_ui_overlay.dart
│   ├── 📂 services/             # Core services
│   │   └── services.dart
│   ├── 📂 show/                 # Error handling and notifications
│   │   ├── checker_navigator_observer.dart
│   │   └── show/
│   │       ├── show_error.dart
│   │       ├── show_material_banner_error.dart
│   │       └── show_snack_bar_error.dart
│   ├── 📂 utils/                # Utility functions
│   │   ├── app_images.dart
│   │   ├── app_url.dart
│   │   └── extensions.dart
│   └── 📂 widgets/              # Reusable widgets
│       ├── app_bar.dart
│       ├── app_button.dart
│       ├── app_print.dart
│       ├── app_text_form_field.dart
│       └── cached_network_image_widget.dart
├── 📂 data/                     # Data layer (Repository Pattern)
│   ├── 📂 datasources/          # Data sources (Remote/Local)
│   │   ├── 📂 auth/             # Authentication data sources
│   │   ├── 📂 internet_connectivity/
│   │   └── 📂 theme/
│   ├── 📂 models/               # Data models
│   │   ├── 📂 auth/             # Auth models
│   │   ├── 📂 local/            # Local storage models
│   │   ├── 📂 {{folder_name}}/  # Feature models
│   └── 📂 repositories/         # Repository implementations
│       ├── 📂 local/            # Local repositories
│       └── 📂 network/          # Network repositories
├── 📂 domain/                   # Business logic layer
│   ├── 📂 failures/             # Error handling
│   │   ├── 📂 local/            # Local failures
│   │   ├── 📂 network/          # Network failures
│   │   └── 📂 theme/            # Theme failures
│   ├── 📂 repositories/         # Repository interfaces
│   │   ├── 📂 local/            # Local repository contracts
│   │   └── 📂 network/          # Network repository contracts
│   └── 📂 usecases/             # Business use cases
│       ├── 📂 auth/             # Auth use cases
│       ├── 📂 local/            # Local use cases
│       └── 📂 theme/            # Theme use cases
├── 📂 features/                 # Feature modules
│   ├── 📂 auth/                 # Authentication feature
│   ├── 📂 splash/               # Splash screen
│   └── 📂 {{folder_name}}/      # Main feature
│       ├── {{cubit_file_name}}  # State management
│       ├── {{initial_params_file_name}}  # Initial parameters
│       ├── {{navigator_file_name}}       # Feature navigation
│       ├── {{page_file_name}}            # UI page
│       └── {{state_file_name}}           # State definitions
└── injection_container.dart     # Dependency injection setup
```

## 🧪 Testing Strategy

### Test Structure

```
test/
├── 📂 unit/                     # Unit tests
│   ├── 📂 data/                 # Data layer tests
│   ├── 📂 domain/               # Domain layer tests
│   └── 📂 core/                 # Core utilities tests
├── 📂 widget/                   # Widget tests
└── 📂 integration/              # Integration tests
```

### Testing Principles

- **TDD Cycle**: Red → Green → Refactor
- **AAA Pattern**: Arrange → Act → Assert
- **Mocking**: Use Mockito/Mocktail for dependencies
- **Coverage**: Aim for 80%+ code coverage

## 🔧 State Management

### Flutter Bloc Pattern

- **Cubit**: Simple state management for basic features
- **Bloc**: Complex state management with events
- **State**: Immutable state

### Example Usage

```dart
// Cubit
class {{class_name}}Cubit extends Cubit<{{class_name}}State> {
  {{class_name}}Cubit() : super({{class_name}}Initial());

  Future<void> loadData() async {
    emit({{class_name}}Loading());
    // Business logic here
    emit({{class_name}}Loaded(data));
  }
}
```

## 🌐 Network Layer

### HTTP Client Setup

- **Base API Service**: Common HTTP operations
- **Interceptors**: Request/Response logging and error handling
- **Error Handling**: Centralized error management

### API Response Pattern

```dart
class ApiResponse<T> {
  final Status status;
  final T? data;
  final String? message;

  ApiResponse.success(this.data) : status = Status.success;
  ApiResponse.error(this.message) : status = Status.error;
}
```

## 💉 Dependency Injection

### GetIt Setup

- **Singleton Registration**: Global services
- **Factory Registration**: Feature-specific services
- **Lazy Loading**: Services loaded on demand

### Example Registration

```dart
// Core services
getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

// Feature services
getIt.registerFactory<{{class_name}}Cubit>(() => {{class_name}}Cubit(getIt()));
```

## 🎨 UI/UX Features

### Responsive Design

- **ScreenUtil**: Responsive sizing across devices
- **Flexible Layouts**: Adaptive UI components
- **Platform Adaptation**: iOS/Android specific styling

### Theme Management

- **Dynamic Themes**: Light/Dark mode support
- **Custom Themes**: Brand-specific theming
- **Theme Persistence**: User preference storage

## 📱 Navigation

### Feature-based Navigation

- **Feature Navigators**: Isolated navigation per feature
- **Transition Types**: Custom page transitions
- **Deep Linking**: URL-based navigation support

## 🔒 Error Handling

### Failure Pattern

```dart
abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}
```

### Error Display

- **SnackBars**: Quick user feedback
- **Material Banners**: Persistent error messages
- **Error Pages**: Dedicated error screens

## 🚀 Getting Started

1. **Install Dependencies**

   ```bash
   flutter pub get
   ```

2. **Run Tests**

   ```bash
   flutter test
   ```

3. **Start Development**
   ```bash
   flutter run
   ```

## 🌱 Environment Variables with flutter_dotenv

This project uses [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv) for environment configuration.

### Setup Steps

1. **Dependencies and .env file are automatically set up for you!**
2. **To add more environment variables, edit the `.env` file in your project root.**
3. **Access variables in code:**
   ```dart
   import 'package:flutter_dotenv/flutter_dotenv.dart';
   final baseUrl = dotenv.env['BASE_URL'];
   ```
> **Note:** Always load dotenv before using any URLs or environment-dependent values. See `main.dart` for the correct setup.

## 📦 Included Packages

### Core Dependencies

- `flutter_bloc`: State management
- `get_it`: Dependency injection
- `fpdart`: Functional programming utilities
- `http`: HTTP client
- `http_interceptor`: Request/Response interceptors

### UI Dependencies

- `flutter_screenutil`: Responsive design
- `shimmer`: Loading animations
- `cached_network_image`: Image caching
- `connectivity_plus`: Network connectivity

### Storage Dependencies

- `shared_preferences`: Local storage

### Development Dependencies

- `device_preview`: Device preview for testing

## 🎯 Best Practices

### Code Organization

- **Single Responsibility**: Each class has one reason to change
- **Dependency Inversion**: Depend on abstractions, not concretions
- **Interface Segregation**: Small, focused interfaces
- **Open/Closed**: Open for extension, closed for modification

### Performance

- **Lazy Loading**: Load resources on demand
- **Caching**: Cache network responses and images
- **Memory Management**: Dispose resources properly
- **Widget Optimization**: Use const constructors

### Security

- **Input Validation**: Validate all user inputs
- **Secure Storage**: Use secure storage for sensitive data
- **Network Security**: Implement certificate pinning
- **Code Obfuscation**: Protect source code

## 🔄 Continuous Integration

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

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Write tests for new features
4. Ensure all tests pass
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Built with ❤️ using Flutter and Clean Architecture principles**
