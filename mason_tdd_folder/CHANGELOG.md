# Changelog

All notable changes to this brick will be documented in this file.

## [0.1.0+1] - 2025-01-XX

### Added
- Initial release of mason_tdd_folder brick
- Feature folder generation with TDD architecture
- Complete feature structure: ViewModel, Model, Repository, View
- Flutter Bloc/Cubit state management integration
- GET and POST API endpoint support
- Conditional file generation based on configuration

### Features

#### Generated Structure
- **ViewModel Layer**: Cubit-based state management with states
- **Model Layer**: Data models with JSON serialization
- **Repository Layer**: Repository interfaces and API service implementations
- **View Layer**: UI components with Bloc integration

#### Configuration
- **name**: Feature name (default: Dash)
- **stateManagement**: flutter_bloc (Bloc coming soon)
- **dio**: API type - get, post, or none

#### Architecture
- Follows Clean Architecture principles
- Repository Pattern implementation
- Separation of concerns (UI, Business Logic, Data)
- Ready for TDD workflow

### Usage
```bash
# Generate a new feature
mason make mason_tdd_folder --name "user_profile"
```

### Integration
- Compatible with mason_tdd main architecture
- Dependency injection ready
- Navigation support included
