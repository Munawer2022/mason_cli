# Changelog

All notable changes to this brick will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0+2] - 2025-10-30

### Added

- Initial release of mason_tdd brick
- Clean architecture structure with domain, data, and presentation layers
- Authentication system with login/logout flow
- Flutter Bloc state management integration
- Custom UI components (AppButton, AppTextFormField, AppBar, etc.)
- Network layer with Dio integration and interceptors
- Theme system with centralized colors and text styles
- Core services (Image Picker, Location, Payment)
- Navigation management with transition support
- Pagination support with PaginatedListView
- Responsive design with flutter_screenutil
- Dependency injection setup with GetIt
- Flutter Release X configuration for CI/CD

### Features

- Comprehensive Flutter TDD brick structure
- Support for GET and POST API endpoints
- Secure local storage implementation
- Socket network support ready
- Error handling and failure types
- Logging with TalkerDioLogger
- Token-based authentication with refresh token support
- Splash screen with user session validation