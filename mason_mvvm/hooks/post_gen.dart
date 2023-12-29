import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing packages');

  // Run `flutter packages get` after generation.
  // await Process.runSync('flutter', ['pub', 'add', 'provider'],
  //     runInShell: true);
  // await Process.runSync('flutter', ['pub', 'add', 'device_preview'],
  //     runInShell: true);
  // await Process.runSync('flutter', ['pub', 'add', 'flutter_screenutil'],
  //     runInShell: true);
  // await Process.runSync('flutter', ['pub', 'add', 'http'], runInShell: true);
  // await Process.runSync('flutter', ['pub', 'add', 'shared_preferences'],
  //     runInShell: true);
  // await Process.runSync('flutter', ['pub', 'get'], runInShell: true);

  progress.complete();
}
