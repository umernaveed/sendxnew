import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/news/news_controller.dart';

class NewsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      NewsController(
        remoteRepository: find<RemoteRepository>(),
      ),
    );
  }
}
