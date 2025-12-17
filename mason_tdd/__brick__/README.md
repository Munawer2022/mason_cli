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

## 📦 Packages

**Core**: `flutter_bloc`, `get_it`, `fpdart`, `dio`, `flutter_screenutil`, `shimmer`, `cached_network_image`, `flutter_secure_storage`, `flutter_dotenv`, `logger`, `image_picker`, `permission_handler`

## 🤝 Contributing

1. Fork the repository (`https://github.com/munawerdev/mason_cli`)
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request