import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/account/controllers/account_controller.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      AccountController(
          remoteRepository: find<RemoteRepository>(),
          localRepository: find<LocalRepository>()),
    );
  }
}
