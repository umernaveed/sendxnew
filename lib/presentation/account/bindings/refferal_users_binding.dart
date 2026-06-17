import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/account/controllers/refferal_users_controller.dart';

class RefferalUsersBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      RefferalUsersController(
        remoteRepository: find<RemoteRepository>(),
      ),
    );
  }
}
