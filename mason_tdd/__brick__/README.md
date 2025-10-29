# 🚀 Flutter Architecture

A **Mason CLI brick** for generating Flutter projects with **Clean Architecture**. Built for scalability and production-ready applications.

## 📋 Version Information

- **Flutter**: {{flutter_version}}
- **Dart**: {{dart_version}}
- **Java**: {{java_version}}

## 🎯 Key Features

- ✅ **Clean Architecture** with Domain-Driven Design
- ✅ **State Management** with Flutter Cubit
- ✅ **Dependency Injection** with GetIt
- ✅ **Network Layer** with Dio interceptors
- ✅ **Local Storage** with SharedPreferences
- ✅ **Responsive Design** with ScreenUtil
- ✅ **UI Components** library
- ✅ **Navigation** with custom transitions

## 📁 Structure

```
lib/
├── 📂 config/                    # Global configuration
│   ├── 📂 navigation/           # Navigation setup and routing
│   ├── 📂 response/             # API response handling
│   └── 📂 theme/                # App theming
├── 📂 core/                     # Core utilities and services
│   ├── 📂 constants/            # Global constants
│   ├── 📂 services/             # Core services
│   ├── 📂 show/                 # Error handling and notifications
│   ├── 📂 utils/                # Utility functions
│   └── 📂 widgets/              # Reusable widgets library
├── 📂 data/                     # Data layer (Repository Pattern)
│   ├── 📂 datasources/          # Data sources (Remote/Local)
│   ├── 📂 models/               # Data models
│   └── 📂 repositories/         # Repository implementations
├── 📂 domain/                   # Business logic layer
│   ├── 📂 failures/             # Error handling
│   ├── 📂 repositories/         # Repository interfaces
│   └── 📂 usecases/             # Business use cases
├── 📂 features/                 # Feature modules
│   ├── 📂 auth/                 # Authentication feature
│   └── 📂 {{folder_name}}/      # Main feature
├── injection_container.dart     # Dependency injection setup
└── {{main}}                     # Main application entry point
```

**Features**: Dio clients, WebSocket support, automatic retry, response caching

## 🌱 Environment Variables

**Automatic setup** with `flutter_dotenv`:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['BASE_URL'];
final apiKey = dotenv.env['API_KEY'];
```

**Auto-generated**: `.env` file, `pubspec.yaml` assets, `main.dart` loading

## 📦 Packages

**Core**: `flutter_bloc`, `get_it`, `fpdart`, `dio`, `flutter_screenutil`, `shimmer`, `cached_network_image`, `shared_preferences`, `flutter_dotenv`, `logger`, `image_picker`, `permission_handler`

## 🔄 CI/CD

**Flutter Release X** integration:

```bash
frx build -t android,ios
frx upload
```

## 📈 Monitoring

**Logging**:
```dart
AppPrint.success('Operation completed successfully');
AppPrint.error('An error occurred: $error');
AppPrint.json(jsonData);
```

## 🤝 Contributing

1. Fork the repository (`https://github.com/munawerdev/mason_cli`)
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request