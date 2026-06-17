import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class StorageService {
  Future<String?> getAppDirectoryPath({
    required String fileName,
    required String fileEXT,
  });
}

class StorageServiceImpl extends StorageService {
  @override
  Future<String> getAppDirectoryPath({
    required String fileName,
    required String fileEXT,
  }) async {
    final path = await getExternalDocumentPath();
    return '$path/$fileName.$fileEXT';
  }

  Future<String> getExternalDocumentPath() async {
    Directory directory = Directory("");
    if (Platform.isAndroid) {
      directory = Directory("/storage/emulated/0/Download");
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    final exPath = directory.path;
    await Directory(exPath).create(recursive: true);
    return exPath;
  }
}
