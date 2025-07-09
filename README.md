# 🧱 Flutter Mason Bricks Collection

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A comprehensive collection of **Mason bricks** for Flutter development, featuring multiple architecture patterns and development approaches. This collection provides ready-to-use templates for building scalable Flutter applications.

## 📋 Version Information

- **Flutter**: Latest stable
- **Dart**: Latest stable
- **Java**: OpenJDK 17+ (LTS)

## 🎯 Available Bricks

### 1. 🏗️ **mason_tdd** - Test-Driven Development Template

**Complete Flutter project template with Clean Architecture and TDD principles**

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

**Usage:**

```bash
mason make mason_tdd
```

### 2. 🧱 **mason_tdd_folder** - Feature Folder Generator

**Generate complete feature modules with TDD architecture**

- ✅ **Feature-based** architecture
- ✅ **Complete CRUD** operations support
- ✅ **State management** integration
- ✅ **Repository pattern** implementation
- ✅ **Test files** generation
- ✅ **Dependency injection** setup
- ✅ **Navigation** integration

**Usage:**

```bash
mason make mason_tdd_folder --name "user_profile"
```

### 3. 🏗️ **mason_mvvm** - MVVM Architecture Template

**Complete Flutter project template with MVVM architecture**

- ✅ **MVVM** architecture pattern
- ✅ **Provider** state management
- ✅ **Repository pattern**
- ✅ **Network layer** with HTTP
- ✅ **Local storage** integration
- ✅ **Theme management**
- ✅ **Navigation** system
- ✅ **Error handling**

**Usage:**

```bash
mason make mason_mvvm
```

### 4. 🧱 **mason_mvvm_folder** - MVVM Feature Generator

**Generate feature modules with MVVM architecture**

- ✅ **MVVM** pattern implementation
- ✅ **Provider** integration
- ✅ **Repository** layer
- ✅ **Model** generation
- ✅ **View** templates
- ✅ **ViewModel** setup

**Usage:**

```bash
mason make mason_mvvm_folder --name "product_list"
```

### 5. 📄 **pdf** - PDF Handling Template

**PDF generation and handling utilities**

- ✅ **PDF generation** from data
- ✅ **PDF viewing** capabilities
- ✅ **PDF downloading** functionality
- ✅ **File management** utilities

**Usage:**

```bash
mason make pdf --pdf_file_name "invoice"
```

### 6. 📸 **screenshot** - Screenshot Utilities

**Screenshot capture and management**

- ✅ **Screenshot capture** functionality
- ✅ **Image processing** utilities
- ✅ **File management** for screenshots
- ✅ **UI components** for screenshot features

**Usage:**

```bash
mason make screenshot --screenshot_file_name "capture"
```

### 7. 🗄️ **sqlite** - SQLite Database Template

**SQLite database integration and management**

- ✅ **Database setup** and configuration
- ✅ **CRUD operations** templates
- ✅ **Model generation** for entities
- ✅ **Data insertion** screens
- ✅ **Data reading** screens
- ✅ **Database utilities**

**Usage:**

```bash
mason make sqlite --folder_name "user_database"
```

## 🚀 Quick Start

### Installation

1. **Clone the repository:**

```bash
git clone https://github.com/your-username/mason_cli-removeMock.git
cd mason_cli-removeMock
```

2. **Add bricks to your Mason configuration:**

```bash
# Add all bricks locally
mason add mason_tdd --source path --path ./mason_tdd
mason add mason_tdd_folder --source path --path ./mason_tdd_folder
mason add mason_mvvm --source path --path ./mason_mvvm
mason add mason_mvvm_folder --source path --path ./mason_mvvm_folder
mason add pdf --source path --path ./pdf
mason add screenshot --source path --path ./screenshot
mason add sqlite --source path --path ./sqlite
```

3. **Or add from Git (if published):**

```bash
mason add mason_tdd --git-url https://github.com/your-username/mason_cli-removeMock.git --git-path mason_tdd
```

### Usage Examples

#### Create a new TDD project:

```bash
mason make mason_tdd
```

#### Add a feature to existing project:

```bash
mason make mason_tdd_folder --name "user_profile" --http "get"
```

#### Create MVVM project:

```bash
mason make mason_mvvm
```

#### Add PDF functionality:

```bash
mason make pdf --pdf_file_name "invoice"
```

## 🏗️ Architecture Comparison

| Feature                  | TDD Template       | MVVM Template     | Folder Generators |
| ------------------------ | ------------------ | ----------------- | ----------------- |
| **Architecture**         | Clean Architecture | MVVM              | Feature-based     |
| **State Management**     | Flutter Bloc       | Provider          | Configurable      |
| **Testing**              | TDD/BDD Ready      | Unit Tests        | Test Generation   |
| **Dependency Injection** | GetIt              | Provider          | GetIt/Provider    |
| **Network Layer**        | HTTP Interceptors  | HTTP Client       | Configurable      |
| **Error Handling**       | Either/Failure     | Try-Catch         | Pattern-based     |
| **Local Storage**        | SharedPreferences  | SharedPreferences | Configurable      |
| **Theme Management**     | Dynamic Themes     | Static Themes     | Inherited         |
| **Navigation**           | Feature-based      | Centralized       | Feature-based     |

## 📁 Project Structure

### TDD Template Structure

```
lib/
├── 📂 config/                    # Global configuration
├── 📂 core/                     # Core utilities and services
├── 📂 data/                     # Data layer (Repository Pattern)
├── 📂 domain/                   # Business logic layer
├── 📂 features/                 # Feature modules
└── injection_container.dart     # Dependency injection setup
```

### MVVM Template Structure

```
lib/
├── 📂 data/                     # Data layer
├── 📂 model/                    # Models
├── 📂 repository/               # Repository layer
├── 📂 resource/                 # Resources and utilities
├── 📂 utils/                    # Utilities
├── 📂 view/                     # UI layer
├── 📂 view_model/               # ViewModels
└── injection_container.dart     # Dependency injection
```

## 🧪 Testing Strategy

### TDD Approach

- **Red → Green → Refactor** cycle
- **Test-first** development
- **Comprehensive** test coverage
- **Mocking** strategies

### Test Structure

```
test/
├── 📂 unit/                     # Unit tests
├── 📂 widget/                   # Widget tests
└── 📂 integration/              # Integration tests
```

## 🔧 Configuration Options

### Common Variables

- **name**: Feature/project name
- **auth**: Include authentication
- **stateManagement**: State management approach
- **http**: API type (get/post/nothing)

### Template-specific Variables

- **pdf_file_name**: PDF file name
- **screenshot_file_name**: Screenshot file name
- **folder_name**: Database folder name

## 📦 Dependencies

### Core Dependencies (TDD)

```yaml
dependencies:
  flutter_bloc: ^8.1.0
  get_it: ^7.6.0
  fpdart: ^1.1.0
  equatable: ^2.0.5
  http: ^1.1.0
  http_interceptor: ^1.0.0
  shared_preferences: ^2.2.0
  flutter_screenutil: ^5.8.0
  shimmer: ^3.0.0
  connectivity_plus: ^4.0.0
  cached_network_image: ^3.3.0
```

### Core Dependencies (MVVM)

```yaml
dependencies:
  provider: ^6.0.5
  http: ^1.1.0
  shared_preferences: ^2.2.0
  flutter_screenutil: ^5.8.0
  shimmer: ^3.0.0
```

## 🚀 Best Practices

### 1. **Architecture Principles**

- **Single Responsibility**: Each class has one reason to change
- **Dependency Inversion**: Depend on abstractions, not concretions
- **Interface Segregation**: Small, focused interfaces
- **Open/Closed**: Open for extension, closed for modification

### 2. **Code Organization**

- **Feature-based** organization
- **Clear separation** of concerns
- **Consistent naming** conventions
- **Proper file** structure

### 3. **Testing**

- **Test-first** development
- **Comprehensive** coverage
- **Mocking** strategies
- **Integration** testing

### 4. **Performance**

- **Lazy loading** of resources
- **Caching** strategies
- **Memory management**
- **Widget optimization**

## 🔄 Workflow Integration

### 1. **New Project Workflow**

```bash
# 1. Create new project
mason make mason_tdd

# 2. Navigate to project
cd your_project_name

# 3. Add features
mason make mason_tdd_folder --name "feature_name"

# 4. Run tests
flutter test

# 5. Start development
flutter run
```

### 2. **Feature Development Workflow**

```bash
# 1. Generate feature
mason make mason_tdd_folder --name "user_profile"

# 2. Write tests first (TDD)
# Edit test files

# 3. Implement feature
# Edit generated files

# 4. Run tests
flutter test

# 5. Refactor if needed
```

## 🤝 Contributing

1. **Fork** the repository
2. **Create** a feature branch
3. **Make** your changes
4. **Add tests** for new functionality
5. **Ensure** all tests pass
6. **Submit** a pull request

### Contribution Guidelines

- Follow **existing** code style
- Add **comprehensive** tests
- Update **documentation**
- Follow **conventional commits**

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [Mason](https://github.com/felangel/mason) by Felix Angelov
- Inspired by Clean Architecture principles
- Following TDD and MVVM best practices
- Community-driven development

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/your-username/mason_cli-removeMock/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-username/mason_cli-removeMock/discussions)
- **Documentation**: [Wiki](https://github.com/your-username/mason_cli-removeMock/wiki)

---

**Built with ❤️ for the Flutter community**

_Empowering developers to build better Flutter applications with proven architecture patterns and best practices._
