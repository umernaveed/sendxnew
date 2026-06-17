import 'package:get/get.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/data/models/app_meta/app_meta.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';

class OnBoardingController extends GetxController {
  final LocalRepository _localRepository;
  final RemoteRepository _remoteRepository;

  OnBoardingController({
    required LocalRepository localRepository,
    required RemoteRepository remoteRepository,
  })  : _localRepository = localRepository,
        _remoteRepository = remoteRepository;

  final RxBool isLoading = false.obs;
  final meta = const AppMeta().obs;

  @override
  void onReady() {
    Future.delayed(1.seconds, () {
      fetchMeta();
    });
  }

  Future<bool> _isLoggedIn() async {
    try {
      final result = await _localRepository.isLoggedIn();
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<void> fetchMeta() async {
    try {
      isLoading.value = true;
      final result = await _remoteRepository.getAppMeta();
      final data = result.data;
      isLoading.value = false;
      meta.value = data;

      // await takeStepOnBaseOfSession();
    } catch (e) {
      isLoading.value = false;
      // await takeStepOnBaseOfSession();
    }
  }

  Future<void> proceedFurther() async {
    try {
      final isLoggedIN = await _isLoggedIn();
      if (isLoggedIN) {
        Get.offAllNamed(AppPages.bottomNav);
      } else {
        Get.offAllNamed(AppPages.login);
      }
    } catch (_) {}
  }
}
