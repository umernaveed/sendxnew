import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/data/network/api_client.dart';
import 'package:sendx/presentation/support/controllers/support_controller.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SupportController(
        apiClient: find<IApiClient>(),
      ),
    );
  }
}
