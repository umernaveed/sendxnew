import 'package:get/get.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/outlet/outlet.dart';
import 'package:sendx/data/models/requests/log_out_request/log_out_request.dart';
import 'package:sendx/data/models/user/user.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';

class AccountController extends GetxController {
  final RemoteRepository _remoteRepository;
  final LocalRepository _localRepository;

  AccountController({
    required LocalRepository localRepository,
    required RemoteRepository remoteRepository,
  })  : _remoteRepository = remoteRepository,
        _localRepository = localRepository;

  final user = User.empty().obs;
  OutLet outLet = OutLet(outLets: []);

  Future<({bool isDone, String message})> onLogOut() async {
    bool result = false;
    String message = '';
    await asyncTask(() async {
      final token = await _localRepository.getLoginToken();
      final res =
          await _remoteRepository.logOut(LogOutRequest(loginToken: token));

      result = res.status;
      if (result) {
        await _localRepository.deleteUser();
        await _localRepository.loggedIN(isLoggedIn: false);
      }
      message = res.message;
    });
    return (isDone: result, message: message);
  }

  Future<void> _fetchLocalUser() async {
    final r = await _localRepository.getUser();
    user.value = r;
  }

  Future<void> updateLocalUser(User newUser) async {
    user.value = User.empty();
    user.value = newUser;
    await _fetchLocalUser();
  }

  Future<void> deleteAccount() async {
    bool isDone = false;
    String message = 'Your account has been deleted';
    await asyncTask(() async {
      final result = await _remoteRepository.deleteAccount();
      isDone = result.status;
      message = result.message;
    }).then((value) {
      Get.offAllNamed(AppPages.login);
      Future.delayed(1.seconds, () {
        if (isDone) {
          FlushSnackbar.showSnackBar(message);
          _localRepository.loggedIN(isLoggedIn: false);
          _localRepository.deleteUser();
        }
      });
    });
  }

  Future<void> fetchOutLets() async {
    if (outLet.outLets.isNotEmpty) return;
    await asyncTask(() async {
      final res = await _remoteRepository.getOutLets();
      outLet = res.data;
    });
  }

  @override
  void onReady() {
    _fetchLocalUser();
    fetchOutLets();
    super.onReady();
  }
}
