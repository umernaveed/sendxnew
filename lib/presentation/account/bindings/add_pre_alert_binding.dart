import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/services/file_picker_service.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/account/controllers/add_alert_controller.dart';

class AddPreControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      AddPreAlertController(
          remoteRepository: find<RemoteRepository>(),
          filePickerService: find<FilePickerService>()),
    );
  }
}
