import 'package:get/get.dart';
import 'package:sendx/presentation/delivery/controllers/address_search_controller.dart';

class AddressSearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddressSearchController());
  }
}
