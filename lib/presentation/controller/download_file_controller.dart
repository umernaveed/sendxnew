import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/app/services/app_permission_service.dart';
import 'package:sendx/app/services/storage_service.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';

class FileDownloadController extends GetxController {
  final StorageService _service;
  final RemoteRepository _remoteRepository;
  final PermissionService _permissionService;

  FileDownloadController(
      {required StorageService service,
      required RemoteRepository remoteRepository})
      : _service = service,
        _remoteRepository = remoteRepository,
        _permissionService = find<PermissionService>();

  final isDonwloadingDone = false.obs;

  void clear() {
    isDonwloadingDone.value = false;
  }

  Future<void> downloadFile(String url) async {
    try {
      if (url.isEmpty) return;
      final lastName = url.extractFileNameWithoutExtension();
      final finalName = 'invoice_$lastName';
      final isAllowed = await _permissionService.getStoragePermission();
      if (!isAllowed) {
        FlushSnackbar.showSnackBar(
            'Storage Permission is Not Allowed, Please Allow Permission and try again!');
        return;
      }
      final pathToSaveFile = await _service.getAppDirectoryPath(
        fileName: finalName,
        fileEXT: 'pdf',
      );
      if (pathToSaveFile?.isEmpty ?? true) {
        FlushSnackbar.showSnackBar('Unable to download file');
        return;
      }

      await _remoteRepository.downloadFile(
        url,
        fileName: finalName,
        pathToSave: pathToSaveFile!,
      );
      isDonwloadingDone.value = true;
      if (Get.isDialogOpen ?? false) Get.back();
      FlushSnackbar.showSnackBar(
        'Inovice has been Downloaded Successfuly',
      );
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      FlushSnackbar.showSnackBar(
        'Unable to download file',
        isError: true,
      );
    }
  }
}
