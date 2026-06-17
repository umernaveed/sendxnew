import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/services/image_service.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/account/controllers/update_profile_controller.dart';

class UpdateProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      UpdateProfileController(
        remoteRepository: find<RemoteRepository>(),
        localRepository: find<LocalRepository>(),
        imagePicker: find<IImagePicker>(),
      ),
    );
  }
}
