import 'package:get/get.dart';
import 'package:sendx/data/models/dashboard_address_data/dashboard_address_data.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';

class DashboardAddressController extends GetxController
    with StateMixin<DashboardAddressData> {
  final RemoteRepository _remoteRepository;

  DashboardAddressController({required RemoteRepository remoteRepository})
      : _remoteRepository = remoteRepository;

  Future<void> fetchDashboardAddressData() async {
    try {
      change(DashboardAddressData.defaultValues(), status: RxStatus.loading());
      final response = await _remoteRepository.getDashboardAddressData();
      change(response.data, status: RxStatus.success());
    } catch (e) {
      change(DashboardAddressData.defaultValues(),
          status: RxStatus.error(e.toString()));
    }
  }

  Future<void> refreshData() {
    return fetchDashboardAddressData();
  }

  @override
  void onReady() {
    Future.delayed(1.seconds, () => fetchDashboardAddressData());
    super.onReady();
  }
}
