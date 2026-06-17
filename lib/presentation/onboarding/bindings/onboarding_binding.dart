import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/onboarding/controllers/on_boarding_controller.dart';

class OnBoardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      OnBoardingController(
        localRepository: find<LocalRepository>(),
        remoteRepository: find<RemoteRepository>(),
      ),
      permanent: true,
    );
  }
}
