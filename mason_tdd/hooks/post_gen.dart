import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('🚀 Setting up Flutter TDD project');

  // Display detected versions
  final flutterVersion = context.vars['flutter_version'] ?? 'Unknown';
  final dartVersion = context.vars['dart_version'] ?? 'Unknown';
  final javaVersion = context.vars['java_version'] ?? 'Unknown';

  context.logger.info('📋 Detected Versions:');
  context.logger.info('   Flutter: $flutterVersion');
  context.logger.info('   Dart: $dartVersion');
  context.logger.info('   Java: $javaVersion');

  // Check if pubspec.yaml exists
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    context.logger.err(
        '❌ pubspec.yaml not found. Please run this brick in a Flutter project directory.');
    return;
  }

  final lines = pubspec.readAsLinesSync();

  // Function to check if a package is already in pubspec.yaml
  bool isPackageInPubspec(String package) {
    return lines.any((line) => line.contains(package));
  }

  // Function to add package with feedback
  Future<void> addPackage(String package, {bool isDev = false}) async {
    if (!isPackageInPubspec(package)) {
      context.logger.info('📦 Adding $package...');
      final result = await Process.runSync('flutter',
          isDev ? ['pub', 'add', package, '--dev'] : ['pub', 'add', package],
          runInShell: true);

      if (result.exitCode == 0) {
        context.logger.success('✅ Added $package');
      } else {
        context.logger.warn('⚠️  Failed to add $package: ${result.stderr}');
      }
    } else {
      context.logger.info('ℹ️  $package already exists');
    }
  }

  // Core dependencies
  context.logger.info('🔧 Installing core dependencies...');
  final dependencies = [
    'flutter_bloc',
    'get_it',
    'flutter_screenutil',
    'http',
    'http_interceptor',
    'shared_preferences',
    // 'equatable',
    'fpdart',
    'shimmer',
    // 'connectivity_plus',
    'cached_network_image',
    'flutter_dotenv',
    'logger',
    'image_picker',
    'permission_handler',
  ];

  for (var package in dependencies) {
    await addPackage(package);
  }

  // Development dependencies
  context.logger.info('🔧 Installing development dependencies...');
  final devDependencies = [
    'device_preview',
    // 'bloc_test',
    // 'mockito',
    // 'mocktail',
    // 'build_runner',
  ];

  for (var package in devDependencies) {
    await addPackage(package, isDev: true);
  }

  // Run flutter pub get
  context.logger.info('🔄 Running flutter pub get...');
  final getResult =
      await Process.runSync('flutter', ['pub', 'get'], runInShell: true);

  if (getResult.exitCode == 0) {
    context.logger.success('✅ Dependencies installed successfully');
  } else {
    context.logger.err('❌ Failed to install dependencies: ${getResult.stderr}');
  }

  // Generate build runner files if needed
  context.logger.info('🔨 Generating build runner files...');
  final buildResult = await Process.runSync(
      'flutter', ['packages', 'pub', 'run', 'build_runner', 'build'],
      runInShell: true);

  if (buildResult.exitCode == 0) {
    context.logger.success('✅ Build runner completed');
  } else {
    context.logger.warn(
        '⚠️  Build runner failed (this is normal if no generated files are needed)');
  }

  // Create a default .env file if it doesn't exist
  final envFile = File('.env');
  if (!envFile.existsSync()) {
    final envContent =
        '''# Flutter Release X Environment Variables (Android & iOS Only)
# Copy this file to .env and fill in your actual values

# Base URL for your API
BASE_URL=https://example.com

# GitHub Configuration
GITHUB_TOKEN=your_github_personal_access_token_here
GITHUB_REPOSITORY=your_username/your_repository_name

# Google Drive Configuration
GOOGLE_DRIVE_CLIENT_ID=your_google_drive_client_id_here
GOOGLE_DRIVE_CLIENT_SECRET=your_google_drive_client_secret_here
GOOGLE_DRIVE_FOLDER_ID=your_google_drive_folder_id_here

# Slack Configuration
SLACK_BOT_TOKEN=xoxb-your_slack_bot_token_here
SLACK_CHANNEL_ID=your_slack_channel_id_here
SLACK_MEMBER_IDS=U1234567890,U0987654321  # Comma-separated user IDs to mention

# Build Configuration (Android & iOS Only)
FLUTTER_CHANNEL=stable
BUILD_TARGET=android,ios
BUILD_FLAVOR=release
''';
    envFile.writeAsStringSync(envContent);
    context.logger.success('✅ Created .env file with FRX configuration');
  } else {
    context.logger.info('ℹ️  .env file already exists');
  }

  // Set up Android permissions for storage and internet
  context.logger.info('🔧 Setting up Android permissions...');
  final androidManifestPath = 'android/app/src/main/AndroidManifest.xml';
  final androidManifest = File(androidManifestPath);

  if (androidManifest.existsSync()) {
    final manifestContent = androidManifest.readAsStringSync();

    // Check if permissions already exist
    final hasStoragePermission =
        manifestContent.contains('android.permission.READ_EXTERNAL_STORAGE');
    final hasWritePermission =
        manifestContent.contains('android.permission.WRITE_EXTERNAL_STORAGE');
    final hasInternetPermission =
        manifestContent.contains('android.permission.INTERNET');

    if (!hasStoragePermission ||
        !hasWritePermission ||
        !hasInternetPermission) {
      // Find the manifest tag and add permissions before it
      final lines = manifestContent.split('\n');
      final newLines = <String>[];
      bool manifestFound = false;

      for (final line in lines) {
        newLines.add(line);

        // Add permissions after the manifest tag
        if (line.trim().startsWith('<manifest') && !manifestFound) {
          manifestFound = true;

          if (!hasStoragePermission) {
            newLines.add(
                '    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />');
            context.logger.info('📱 Added read storage permission');
          }

          if (!hasWritePermission) {
            newLines.add(
                '    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />');
            context.logger.info('📱 Added write storage permission');
          }

          if (!hasInternetPermission) {
            newLines.add(
                '    <uses-permission android:name="android.permission.INTERNET" />');
            context.logger.info('📱 Added internet permission');
          }
        }
      }

      androidManifest.writeAsStringSync(newLines.join('\n'));
      context.logger.success('✅ Android permissions configured');
    } else {
      context.logger.info('ℹ️  Android permissions already configured');
    }
  } else {
    context.logger
        .warn('⚠️  AndroidManifest.xml not found at $androidManifestPath');
  }

  // Set up iOS permissions for photo library access
  context.logger.info('🔧 Setting up iOS permissions...');
  final iosInfoPlistPath = 'ios/Runner/Info.plist';
  final iosInfoPlist = File(iosInfoPlistPath);

  if (iosInfoPlist.existsSync()) {
    final plistContent = iosInfoPlist.readAsStringSync();

    // Check if permissions already exist
    final hasPhotoLibraryUsageDescription =
        plistContent.contains('NSPhotoLibraryUsageDescription');

    if (!hasPhotoLibraryUsageDescription) {
      // Find the dict tag and add permissions before the closing dict
      final lines = plistContent.split('\n');
      final newLines = <String>[];
      bool dictFound = false;
      int dictLevel = 0;

      for (final line in lines) {
        newLines.add(line);

        // Track dict level
        if (line.trim().startsWith('<dict>')) {
          dictLevel++;
          if (dictLevel == 1) dictFound = true;
        } else if (line.trim().startsWith('</dict>')) {
          dictLevel--;

          // Add permissions before the main dict closes
          if (dictLevel == 0 && dictFound) {
            if (!hasPhotoLibraryUsageDescription) {
              newLines.add('	<key>NSPhotoLibraryUsageDescription</key>');
              newLines.add(
                  '	<string>This app needs photo library access to select images</string>');
              context.logger.info('📱 Added photo library usage description');
            }
          }
        }
      }

      iosInfoPlist.writeAsStringSync(newLines.join('\n'));
      context.logger.success('✅ iOS permissions configured');
    } else {
      context.logger.info('ℹ️  iOS permissions already configured');
    }
  } else {
    context.logger.warn('⚠️  Info.plist not found at $iosInfoPlistPath');
  }

  // Ensure .env is included in pubspec.yaml assets
  final pubspecLines = pubspec.readAsLinesSync();
  bool hasFlutterSection = false;
  bool hasAssetsSection = false;
  bool hasEnvAsset = false;
  int flutterIndex = -1;
  int assetsIndex = -1;
  int insertIndex = -1;

  for (int i = 0; i < pubspecLines.length; i++) {
    final line = pubspecLines[i];
    if (line.trim().startsWith('flutter:')) {
      hasFlutterSection = true;
      flutterIndex = i;
    }
    if (line.trim().startsWith('assets:')) {
      hasAssetsSection = true;
      assetsIndex = i;
    }
    if (line.trim() == '- .env') {
      hasEnvAsset = true;
    }
  }

  if (!hasEnvAsset) {
    List<String> newLines = List.from(pubspecLines);
    if (hasFlutterSection) {
      // Find where to insert assets
      if (hasAssetsSection) {
        // Insert under assets if not present
        // Find the last asset entry
        insertIndex = assetsIndex + 1;
        while (insertIndex < newLines.length &&
            (newLines[insertIndex].trim().startsWith('- ') ||
                newLines[insertIndex].trim().isEmpty)) {
          insertIndex++;
        }
        newLines.insert(assetsIndex + 1, '    - .env');
      } else {
        // Insert assets section under flutter
        newLines.insert(flutterIndex + 1, '  assets:\n    - .env');
      }
    } else {
      // No flutter section, add at end
      newLines.add('flutter:');
      newLines.add('  assets:');
      newLines.add('    - .env');
    }
    pubspec.writeAsStringSync(newLines.join('\n'));
    context.logger.success('✅ Added .env to assets in pubspec.yaml');
  } else {
    context.logger.info('ℹ️  .env already included in assets');
  }

  // Set up Flutter Release X
  context.logger.info('🚀 Setting up Flutter Release X...');

  // Check if Flutter Release X is already installed globally
  context.logger.info('🔍 Checking Flutter Release X installation...');
  final frxCheckResult =
      await Process.runSync('frx', ['--version'], runInShell: true);

  if (frxCheckResult.exitCode == 0) {
    final version = frxCheckResult.stdout.toString().trim();
    context.logger.success('✅ Flutter Release X already installed: $version');
  } else {
    // Install Flutter Release X globally if not found
    context.logger.info('📦 Installing Flutter Release X...');
    final frxResult = await Process.runSync(
        'dart', ['pub', 'global', 'activate', 'flutter_release_x'],
        runInShell: true);

    if (frxResult.exitCode == 0) {
      context.logger.success('✅ Flutter Release X installed successfully');
    } else {
      context.logger
          .warn('⚠️  Failed to install Flutter Release X: ${frxResult.stderr}');
      context.logger.info(
          '💡 You can install it manually with: dart pub global activate flutter_release_x');
    }
  }

  // Create build directories
  context.logger.info('📁 Creating build directories...');
  final buildDir = Directory('build');
  final qrCodesDir = Directory('build/qr_codes');
  final releasesDir = Directory('build/releases');

  if (!buildDir.existsSync()) buildDir.createSync();
  if (!qrCodesDir.existsSync()) qrCodesDir.createSync();
  if (!releasesDir.existsSync()) releasesDir.createSync();

  context.logger.success('✅ Build directories created');

  // Make scripts executable (Unix/Linux/macOS)
  if (Platform.isLinux || Platform.isMacOS) {
    context.logger.info('🔧 Making scripts executable...');
    final scriptsDir = Directory('scripts');
    if (scriptsDir.existsSync()) {
      await Process.runSync('chmod', ['+x', 'scripts/frx_setup.sh']);
      await Process.runSync('chmod', ['+x', 'scripts/frx_build.sh']);
      context.logger.success('✅ Scripts made executable');
    }
  }

  // Display next steps
  context.logger.info('');
  context.logger.info('🎉 Project setup complete!');
  context.logger.info('');
  context.logger.info('📋 Next steps:');
  context.logger.info('   1. Review the generated architecture');
  context.logger.info('   2. Configure your API endpoints in config/');
  context.logger.info(
      '   3. Set up your dependency injection in injection_container.dart');
  context.logger.info('   4. Start building your features!');
  context.logger.info('');
  context.logger.info('📸 Image Picker Setup:');
  context.logger
      .info('   ✅ Dependencies installed: image_picker, permission_handler');
  context.logger
      .info('   ✅ Android permissions configured (storage & internet)');
  context.logger.info('   ✅ iOS permissions configured (photo library)');
  context.logger.info('   📱 Use ImagePickerService for gallery access');
  context.logger.info('   🎨 Use ImagePickerWidget for UI components');
  context.logger.info('');
  context.logger.info('🧪 To run tests:');
  context.logger.info('   flutter test');
  context.logger.info('');
  context.logger.info('🚀 To run the app:');
  context.logger.info('   flutter run');
  context.logger.info('');
  context.logger.info('📦 Flutter Release X Setup:');
  context.logger
      .info('   1. Edit env.example and copy to .env with your API keys');
  context.logger
      .info('   2. Configure GitHub, Google Drive, and/or Slack tokens');
  context.logger.info('   3. Run: ./scripts/frx_setup.sh (Unix/Linux/macOS)');
  context.logger.info('      or: scripts\\frx_setup.bat (Windows)');
  context.logger.info('');
  context.logger.info('🚀 To build and release:');
  context.logger
      .info('   frx build                    # Build for Android & iOS');
  context.logger
      .info('   frx build -t android,ios     # Build for both platforms');
  context.logger
      .info('   ./scripts/frx_build.sh both  # Using convenience script');
  context.logger.info('');

  progress.complete();
}
