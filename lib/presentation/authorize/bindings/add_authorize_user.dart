import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/authorize/controllers/add_authorize_user_controller.dart';

class AddAuthorizeUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddAuthorizeUserController(
      remoteRepository: find<RemoteRepository>(),
    ));
  }
}
