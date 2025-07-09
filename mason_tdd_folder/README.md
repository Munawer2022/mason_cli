# 🧱 Mason TDD Folder Brick

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A powerful Mason brick for generating **feature folders** with **Test-Driven Development (TDD)** architecture in Flutter applications. This brick creates complete feature modules following Clean Architecture principles.

## 📋 Version Information

- **Flutter**: {{flutter_version}}
- **Dart**: {{dart_version}}
- **Java**: {{java_version}}

## 🎯 What This Brick Does

This brick generates a complete **feature folder** with all necessary components for a Flutter feature following TDD principles:

### 🏗️ Generated Structure

```
{{folder_name}}/
├── 📂 {{folder_name}}_view_model/     # State management layer
│   ├── {{folder_name}}_view_model.dart
│   └── {{state_file_name}}
├── 📂 {{folder_name}}_model/          # Data models
│   └── {{model_file_name}}
├── 📂 {{folder_name}}_repo/           # Repository layer
│   ├── {{folder_name}}_base_api_service.dart
│   └── {{folder_name}}_repository.dart
└── 📂 {{folder_name}}/                # UI layer
    └── {{folder_name}}_view.dart
```

## 🚀 Quick Start

### Installation

```bash
# Add the brick to your mason.yaml
mason add mason_tdd_folder --git-url https://github.com/your-repo/mason_tdd_folder.git --git-path .

# Or use locally
mason add mason_tdd_folder --source path --path ./mason_tdd_folder
```

### Usage

```bash
# Generate a new feature
mason make mason_tdd_folder

# With custom name
mason make mason_tdd_folder --name "user_profile"
```

## 📝 Configuration Options

### Variables

| Variable          | Type   | Description                                    | Default        |
| ----------------- | ------ | ---------------------------------------------- | -------------- |
| `name`            | string | Feature name (will be converted to PascalCase) | "Dash"         |
| `stateManagement` | enum   | State management approach                      | `flutter_bloc` |
| `http`            | enum   | API type for the feature                       | `get`          |

### State Management Options

- **flutter_bloc**: Uses Flutter Bloc for state management
- **Bloc**: Standard Bloc pattern (Coming Soon)

### HTTP Options

- **get**: GET API endpoints
- **post**: POST API endpoints
- **noThing**: No API integration

## 🏗️ Architecture Details

### 1. View Model Layer (`{{folder_name}}_view_model/`)

```dart
// {{folder_name}}_view_model.dart
class {{class_name}}ViewModel extends Cubit<{{class_name}}State> {
  {{class_name}}ViewModel() : super({{class_name}}Initial());

  Future<void> loadData() async {
    emit({{class_name}}Loading());
    // Business logic here
    emit({{class_name}}Loaded(data));
  }
}
```

### 2. Model Layer (`{{folder_name}}_model/`)

```dart
// {{model_file_name}}
class {{class_name}}Model {
  final String id;
  final String name;

  {{class_name}}Model({
    required this.id,
    required this.name,
  });

  factory {{class_name}}Model.fromJson(Map<String, dynamic> json) {
    return {{class_name}}Model(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
```

### 3. Repository Layer (`{{folder_name}}_repo/`)

```dart
// {{folder_name}}_repository.dart
abstract class {{class_name}}Repository {
  Future<Either<Failure, {{class_name}}Model>> getData();
}

// {{folder_name}}_base_api_service.dart
class {{class_name}}BaseApiService {
  Future<ApiResponse<{{class_name}}Model>> fetchData() async {
    // API implementation
  }
}
```

### 4. View Layer (`{{folder_name}}/`)

```dart
// {{folder_name}}_view.dart
class {{class_name}}View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{class_name}}ViewModel(),
      child: BlocBuilder<{{class_name}}ViewModel, {{class_name}}State>(
        builder: (context, state) {
          return Scaffold(
            // UI implementation
          );
        },
      ),
    );
  }
}
```

## 🧪 Testing Strategy

### Test Structure

```
test/
├── 📂 unit/
│   ├── 📂 {{folder_name}}_view_model_test.dart
│   ├── 📂 {{folder_name}}_repository_test.dart
│   └── 📂 {{folder_name}}_model_test.dart
├── 📂 widget/
│   └── 📂 {{folder_name}}_view_test.dart
└── 📂 integration/
    └── 📂 {{folder_name}}_integration_test.dart
```

### Testing Principles

- **TDD Cycle**: Red → Green → Refactor
- **AAA Pattern**: Arrange → Act → Assert
- **Mocking**: Use Mockito/Mocktail for dependencies
- **Coverage**: Aim for 80%+ code coverage

## 🔧 Integration with Main Project

### 1. Add to Dependency Injection

```dart
// injection_container.dart
void init{{class_name}}() {
  // Repository
  getIt.registerLazySingleton<{{class_name}}Repository>(
    () => {{class_name}}RepositoryImpl(getIt()),
  );

  // View Model
  getIt.registerFactory<{{class_name}}ViewModel>(
    () => {{class_name}}ViewModel(getIt()),
  );
}
```

### 2. Add to Navigation

```dart
// app_navigator.dart
class {{class_name}}Navigator {
  static Future<void> navigateTo{{class_name}}(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => {{class_name}}View(),
      ),
    );
  }
}
```

### 3. Add to Routes

```dart
// routes.dart
class {{class_name}}Route extends AppRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return {{class_name}}View();
  }
}
```

## 🎨 Customization

### Custom Templates

You can customize the generated templates by modifying the files in the `__brick__` directory:

- **Template Variables**: Use `{{variable_name}}` syntax
- **Conditional Logic**: Use `{{#condition}}...{{/condition}}` syntax
- **File Generation**: Use conditional file generation based on variables

### Example Customization

```yaml
# brick.yaml
vars:
  includeTests:
    type: boolean
    description: Include test files
    default: true
```

## 📦 Dependencies

This brick assumes the following dependencies are available in your project:

### Required Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.0
  get_it: ^7.6.0
  fpdart: ^1.1.0
  equatable: ^2.0.5
  http: ^1.1.0
```

### Development Dependencies

```yaml
dev_dependencies:
  bloc_test: ^9.1.0
  mockito: ^5.4.0
  mocktail: ^1.0.0
```

## 🚀 Best Practices

### 1. Naming Conventions

- **Feature Name**: Use PascalCase (e.g., "UserProfile")
- **File Names**: Use snake_case (e.g., "user_profile_view.dart")
- **Class Names**: Use PascalCase (e.g., "UserProfileView")

### 2. State Management

- **Single Responsibility**: Each state represents one UI state
- **Immutable States**: Use Equatable for state comparison
- **Error Handling**: Include error states in your state classes

### 3. Repository Pattern

- **Interface Segregation**: Keep repository interfaces focused
- **Dependency Injection**: Use GetIt for service registration
- **Error Handling**: Use Either type for error handling

### 4. Testing

- **Test First**: Write tests before implementation
- **Mock Dependencies**: Mock external dependencies
- **Test Coverage**: Aim for comprehensive test coverage

## 🔄 Workflow Integration

### 1. Feature Development Workflow

```bash
# 1. Generate feature structure
mason make mason_tdd_folder --name "user_profile"

# 2. Write tests first (TDD)
# Edit test files

# 3. Implement feature
# Edit generated files

# 4. Run tests
flutter test

# 5. Refactor if needed
```

### 2. CI/CD Integration

```yaml
# .github/workflows/test.yml
- name: Run Tests
  run: flutter test --coverage

- name: Upload Coverage
  uses: codecov/codecov-action@v3
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Built with [Mason](https://github.com/felangel/mason) by Felix Angelov
- Inspired by Clean Architecture principles
- Following TDD best practices

---

**Built with ❤️ for the Flutter community**
