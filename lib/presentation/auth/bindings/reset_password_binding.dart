import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/auth/controllers/reset_password_controller.dart';

class ResetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      ResetPasswordController(remoteRepository: find<RemoteRepository>()),
    );
  }
}
