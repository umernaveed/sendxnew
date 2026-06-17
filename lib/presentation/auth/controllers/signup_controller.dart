import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/app/services/device_service.dart';
import 'package:sendx/app/services/firebae_service.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/manager/manager.dart';
import 'package:sendx/data/models/outlet/outlet.dart';
import 'package:sendx/data/models/requests/register_user_request/register_user_request.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/auth/widgets/drop_down.dart';

class SignUpController extends GetxController {
  final RemoteRepository _remoteRepository;
  final LocalRepository _localRepository;
  final FirebaseService _firebaseService;

  SignUpController({
    required RemoteRepository remoteRepository,
    required LocalRepository localRepository,
  })  : _remoteRepository = remoteRepository,
        _localRepository = localRepository,
        _firebaseService = FirebaseServiceImpl();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  final passwordVisibility = ValueNotifier<bool>(true);
  final confirmPasswordVisibility = ValueNotifier<bool>(true);
  final formKey = GlobalKey<FormBuilderState>();
  OutLet outLet = OutLet(outLets: []);
  Managers managers = Managers(managers: []);
  bool isTypeBusinnes = false;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    passwordVisibility.dispose();
    confirmPasswordVisibility.dispose();
    super.onClose();
  }

  void onPasswordToggle() {
    final lastV = passwordVisibility.value;
    passwordVisibility.value = !lastV;
  }

  void onConfirmPasswordToggle() {
    final lastV = confirmPasswordVisibility.value;
    confirmPasswordVisibility.value = !lastV;
  }

  Future<({bool isDone, String message})> _signUp(
      RegisterUserRequest request) async {
    bool result = false;
    var message = '';
    await asyncTask(() async {
      final res = await _remoteRepository.regiterUser(request);
      message = res.message;
      result = res.status;
      if (res.status) {
        _localRepository.saveUser(res.data);
        _localRepository.loggedIN(isLoggedIn: res.status);
      }
    });
    return (isDone: result, message: message);
  }

  Future<void> fetchOutLets() async {
    if (outLet.outLets.isNotEmpty) return;
    await asyncTask(() async {
      final res = await _remoteRepository.getOutLets();
      outLet = res.data;
      update(['outLet']);
    });
  }

  Future<void> fetchManagers() async {
    if (managers.managers.isNotEmpty) return;
    await asyncTask(() async {
      final res = await _remoteRepository.getManagers();
      managers = res.data;
      update(['managers']);
    });
  }

  Future<void> onSignUpPress() async {
    formKey.currentState?.save();
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    final formData = formKey.currentState?.value ?? {};
    final token = await _firebaseService.getFirebaseToken();
    final deviceInfo = find<DeviceInfoProvider>();
    final userType = (formData['userType'] as NormalString).key.toLowerCase();
    final manager = formData['managerId'] == null
        ? ''
        : (formData['managerId'] as OutLetPair).key;

    final request = RegisterUserRequest(
      outletId: (formData['outletId'] as OutLetPair).key,
      managerId: manager,
      userType: userType,
      firstName: formData['firstName'],
      lastName: formData['lastName'],
      email: formData['email'],
      confirmEmail: formData['email'],
      password: formData['password'],
      refferalCode: formData['referral_code'] ?? '',
      phone: formData['phone'] ?? '',
      address1: formData['address1'] ?? '',
      appVersion: deviceInfo.appVersion,
      deviceToken: token,
      deviceType: deviceInfo.deviceType,
      timeZone: deviceInfo.timeZone,
    );

    final value = await _signUp(request);
    final isDone = value.isDone;
    final message = value.message;
    if (!isDone) return;
    Get.offAllNamed(AppPages.login);
    Future.delayed(500.milliseconds, () {
      FlushSnackbar.showSnackBar(message);
    });
  }

  void onUserTypeSelect(String key) {
    if (key.toLowerCase() == 'business') {
      isTypeBusinnes = true;
    } else {
      isTypeBusinnes = false;
    }
    update(['onUserTypeSelect']);
  }

  @override
  void onReady() {
    fetchOutLets();
    fetchManagers();
    super.onReady();
  }
}
