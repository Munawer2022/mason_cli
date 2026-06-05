# Changelog

All notable changes to this brick will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0+21] - 2026-06-05

### Changed
- Renamed the `dio` enum value `noThing` to `none` (and the internal `isNoThing`
  flag to `isNone`) for clarity.
- Clarified the `name` variable description in `brick.yaml`.

### Fixed
- `.env` is now appended after existing `assets:` entries instead of being
  inserted at the top of the list.
- The post-gen hook now reports failure (`progress.fail`) when `flutter pub get`
  fails, instead of always reporting success.
- Corrected the README usage examples (`AppButton`, `AppTextFormField`,
  `NetworkBaseApiService`) and theming tokens (`AppColors`, Material 3
  `AppTextStyles`) to match the generated code.

### Removed
- Dropped 9 unused computed file-name variables from `pre_gen.dart`
  (`widget_file_name`, `mock_repo_file_name`, `repo_file_name`,
  `base_api_service_file_name`, `mock_model_file_name`, `failure_name`,
  `use_cases_name`, `data_sources_name`, `use_cases_failure`).

## [0.1.0+4] - 2025-01-XX

### Added
- Complete Flutter architecture generator with Clean Architecture
- Automatic Flutter/Dart/Java version detection
- Auto-installation of dependencies with `flutter pub add`
- Environment variable setup with `.env` file generation
- Android and iOS permission auto-configuration
- Build runner integration for code generation

### Features

#### Architecture
- **Clean Architecture** with Domain, Data, and Presentation layers
- **State Management** with Flutter Bloc/Cubit
- **Dependency Injection** with GetIt
- **Repository Pattern** implementation

#### Authentication
- Complete login/logout flow
- Token-based authentication with refresh token support
- Secure local storage
- Automatic session validation
- Splash screen with auth state checking

#### UI/UX
- Custom AppButton, AppTextFormField, AppBar widgets
- CachedNetworkImage for optimized loading
- PaginatedListView for efficient lists
- Complete theming system with colors and text styles
- Responsive design with ScreenUtil
- Loading animations with Shimmer

#### Network Layer
- Dio integration with interceptors
- API response handling and error management
- WebSocket support ready
- Automatic retry and logging
- Environment-based configuration

#### Native Services
- Image Picker (camera & gallery)
- Location service with GPS
- Payment service integration ready
- Permission handler setup

#### Developer Experience
- Testing structure setup
- Logging with TalkerDioLogger
- Extension helpers
- Constants and utilities

### Configuration
- **name**: User name (default: Dash)
- **http**: API type - get, post, or noThing

### Dependencies
- Core: flutter_bloc, get_it, dio, fpdart, flutter_screenutil, flutter_secure_storage
- UI: cached_network_image, shimmer
- Dev: device_preview, talker_dio_logger, logger, flutter_dotenv
- Native: image_picker, permission_handler