import 'dart:io';

void main() async {
  final Directory directory = Directory('test');
  final List<String> defTestFiles = <String>[];

  await for (FileSystemEntity entity in directory.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart') && !(entity.path.contains('int_'))) {
      defTestFiles.add(entity.path);
    }
  }

  if (defTestFiles.isEmpty) {
    print('No test files starting with "def_" found.');
    return;
  }

  final ProcessResult result = await Process.run('dart', <String>['test', ...defTestFiles]);
  print(result.stdout);
  print(result.stderr);
}
