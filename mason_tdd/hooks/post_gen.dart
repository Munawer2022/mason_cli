import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('🚀 Setting up Flutter TDD project');

  // Display detected versions
  final flutterVersion = context.vars['flutter_version'] ?? 'Unknown';
  final dartVersion = context.vars['dart_version'] ?? 'Unknown';
  final javaVersion = context.vars['java_version'] ?? 'Unknown';

  context.logger.info(
      '📋 Flutter: $flutterVersion | Dart: $dartVersion | Java: $javaVersion');

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
      final result = await Process.runSync('flutter',
          isDev ? ['pub', 'add', package, '--dev'] : ['pub', 'add', package],
          runInShell: true);

      if (result.exitCode != 0) {
        context.logger.warn('⚠️  Failed to add $package: ${result.stderr}');
      }
    }
  }

  // Install dependencies
  context.logger.info('🔧 Installing dependencies...');
  final dependencies = [
    'flutter_bloc',
    'get_it',
    'flutter_screenutil',
    'dio',
    'talker_dio_logger',
    'shared_preferences',
    'fpdart',
    'shimmer',
    'cached_network_image',
    'flutter_dotenv',
    'logger',
    'image_picker',
    'permission_handler',
  ];

  final devDependencies = [
    'device_preview',
  ];

  for (var package in dependencies) {
    await addPackage(package);
  }

  for (var package in devDependencies) {
    await addPackage(package, isDev: true);
  }

  // Run flutter pub get
  final getResult =
      await Process.runSync('flutter', ['pub', 'get'], runInShell: true);

  if (getResult.exitCode != 0) {
    context.logger.err('❌ Failed to install dependencies: ${getResult.stderr}');
  }

  // Generate build runner files if needed
  await Process.runSync(
      'flutter', ['packages', 'pub', 'run', 'build_runner', 'build'],
      runInShell: true);

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
  }

  // Set up Android permissions for storage and internet
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
          }

          if (!hasWritePermission) {
            newLines.add(
                '    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />');
          }

          if (!hasInternetPermission) {
            newLines.add(
                '    <uses-permission android:name="android.permission.INTERNET" />');
          }
        }
      }

      androidManifest.writeAsStringSync(newLines.join('\n'));
    }
  }

  // Set up iOS permissions for photo library access
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
            }
          }
        }
      }

      iosInfoPlist.writeAsStringSync(newLines.join('\n'));
    }
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
  }

  // Set up Flutter Release X
  final frxCheckResult =
      await Process.runSync('frx', ['--version'], runInShell: true);

  if (frxCheckResult.exitCode != 0) {
    final frxResult = await Process.runSync(
        'dart', ['pub', 'global', 'activate', 'flutter_release_x'],
        runInShell: true);

    if (frxResult.exitCode != 0) {
      context.logger
          .warn('⚠️  Failed to install Flutter Release X: ${frxResult.stderr}');
    }
  }

  // Create build directories
  final buildDir = Directory('build');
  final qrCodesDir = Directory('build/qr_codes');
  final releasesDir = Directory('build/releases');

  if (!buildDir.existsSync()) buildDir.createSync();
  if (!qrCodesDir.existsSync()) qrCodesDir.createSync();
  if (!releasesDir.existsSync()) releasesDir.createSync();

  // Make scripts executable (Unix/Linux/macOS)
  if (Platform.isLinux || Platform.isMacOS) {
    final scriptsDir = Directory('scripts');
    if (scriptsDir.existsSync()) {
      await Process.runSync('chmod', ['+x', 'scripts/frx_setup.sh']);
      await Process.runSync('chmod', ['+x', 'scripts/frx_build.sh']);
    }
  }

  // Display completion
  context.logger.info('🎉 Project setup complete!');
  // context.logger.info('🚀 Run: flutter run');

  progress.complete();
}
