import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Storage {
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/character.txt');
  }

  Future<String> readFile() async {
    try {
      final file = await localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return e.toString();
    }
  }

  Future<File> writeFile(String json) async {
    final file = await localFile;

    // Write the file
    return file.writeAsString('$json');
  }

  Future<File> clearFile() async {
    final file = await localFile;
    return file.delete();
  }
}