import 'dart:io';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing packages');

  // Run `flutter packages get` after generation.
  await Process.runSync('flutter', ['pub', 'add', 'provider'],
      runInShell: true);
  await Process.runSync('flutter', ['pub', 'add', 'device_preview'],
      runInShell: true);
  await Process.runSync('flutter', ['pub', 'add', 'flutter_screenutil'],
      runInShell: true);
  await Process.runSync('flutter', ['pub', 'add', 'http'], runInShell: true);
  await Process.runSync('flutter', ['pub', 'add', 'shared_preferences'],
      runInShell: true);
  await Process.runSync('flutter', ['pub', 'get'], runInShell: true);
  //
  // final generate = await MasonGenerator.fromBundle(MasonBundle(
  //     name: 'mason_mvvm',
  //     description: 'A new brick created with the Mason CLI',
  //     version: '0.1.0+1'));
  // await generate.generate(DirectoryGeneratorTarget(Directory(path.join(
  //     Directory.current.path,
  //     'lib',
  //     (context.vars['name'] as String).snakeCase))));

  progress.complete();
}
