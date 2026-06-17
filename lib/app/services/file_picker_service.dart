import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerService {
  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ['pdf', 'doc'],
        type: FileType.custom);
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      throw FileNotFoundException();
    }
  }
}

class FileNotFoundException implements Exception {
  FileNotFoundException();

  @override
  String toString() {
    return 'File Not Found ';
  }
}
