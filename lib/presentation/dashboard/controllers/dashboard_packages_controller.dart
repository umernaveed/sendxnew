import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sendx/data/models/get_packages_ready_for_pickup_response/get_packages_ready_for_pickup_response.dart';
import 'package:sendx/data/models/requests/offset_request/offset_request.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/mixin/pagination_service.dart';

class DashboardPackagesController extends GetxController
    with PaginationService<Package> {
  final RemoteRepository _remoteRepository;

  DashboardPackagesController({required RemoteRepository remoteRepository})
      : _remoteRepository = remoteRepository;

  @override
  void onInit() {
    initlizieController();
    super.onInit();
  }

  @override
  void onClose() {
    disposeController();
    super.onClose();
  }

  void onUploadingInvoiceDone(int packageID) {
    pagingController.refresh();
  }

  @override
  Future<List<Package>> listener(int pageKey, {String keyToSearch = ''}) async {
    final res =
        await _remoteRepository.getAllPackagesReadyToPickup(OffsetRequest(
      offset: pageKey.toString(),
      keyword: keyToSearch,
    ));
    return res.data.packages;
  }
}
