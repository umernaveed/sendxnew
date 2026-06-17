import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/app/services/device_service.dart';
import 'package:sendx/app/services/push_notifications_service.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/app_meta/app_meta.dart';
import 'package:sendx/data/models/dashboard_data/dashboard_data.dart';
import 'package:sendx/data/models/lasco_mass_pay_invoice_request/lasco_mass_pay_invoice_request.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/onboarding/controllers/on_boarding_controller.dart';
import 'package:sendx/presentation/widgets/dialogs/app_update_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardController extends GetxController
    with StateMixin<DashboardData> {
  final RemoteRepository _remoteRepository;

  DashboardController({required RemoteRepository remoteRepository})
      : _remoteRepository = remoteRepository;

  Future<void> fetchDashboard() async {
    try {
      change(DashboardData.defaultValues(), status: RxStatus.loading());
      final response = await _remoteRepository.fetchDashboard();
      change(response.data, status: RxStatus.success());
      Future.delayed(1.seconds, checkIfTheUpdateIsAvailable);
    } catch (e) {
      change(DashboardData.defaultValues(),
          status: RxStatus.error(e.toString()));
    }
  }

  Future<void> refreshData() => fetchDashboard();

  @override
  void onReady() {
    Future.delayed(500.milliseconds, () => fetchDashboard());
    final badger = find<FlutterAppNotificationBadger>();
    badger.clearBadge();
    super.onReady();
  }

  Future<void> startPayment({
    required String packageIDs,
    required String invoiceIDs,
    required String balance,
  }) async {
    final validBalance = balance.replaceAll('JMD', '').replaceAll(',', '');
    final amount = num.tryParse(validBalance) ?? 0;
    final result = await asyncTaskWithResult<String>(() async {
      final request = LascoMassPayInvoiceRequest(
          invoiceIds: invoiceIDs,
          packageIds: packageIDs,
          invoiceTotal: amount.toString());
      final response = await _remoteRepository.lascoMassPayInvoice(request);
      return response.data;
    });
    if (result?.isNotEmpty ?? false) {
      final response = await Get.toNamed(
        AppPages.paymentWebView,
        arguments: {
          'url': result,
        },
      );
      if (response == -1) {
        FlushSnackbar.showSnackBar('Payment has been canceled', isError: true);
      } else if (response == 1) {
        FlushSnackbar.showSnackBar('Payment has been done', isError: false);
        refreshData();
      }
    }
  }

  Future<void> checkIfTheUpdateIsAvailable() async {
    final onBoarding = find<OnBoardingController>();
    final isUpdateAvailable = isUpdateRequired(onBoarding.meta.value);
    if (!isUpdateAvailable) return;
    await Get.dialog(const AppUpdateDialog());
  }

  bool isUpdateRequired(AppMeta meta) {
    final remoteAppVersion = meta.setting?.appVersion ?? '0.0.0 + 0';
    final deviceInfo = find<DeviceInfoProvider>();
    final localAppVersion = deviceInfo.appVersionWithBuildNumber;
    Version remote = Version.parse(remoteAppVersion);
    Version local = Version.parse(localAppVersion);
    return remote.compareTo(local) > 0;
  }

  void launchStore() {
    try {
      final deviceInfo = find<DeviceInfoProvider>();
      final url = deviceInfo.getStoreLink();
      final uri = Uri.parse(url);
      launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {}
  }
}
