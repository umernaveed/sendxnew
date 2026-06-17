import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/auth/controllers/signup_controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      SignUpController(
        localRepository: find<LocalRepository>(),
        remoteRepository: find<RemoteRepository>(),
      ),
    );
  }
}
