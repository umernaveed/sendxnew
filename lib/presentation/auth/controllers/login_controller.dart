import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/app/services/device_service.dart';
import 'package:sendx/app/services/firebae_service.dart';
import 'package:sendx/data/models/requests/login_request/login_request.dart';
import 'package:sendx/domain/repositories/local_repository.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';

class LoginController extends GetxController {
  final RemoteRepository _remoteRepository;
  final LocalRepository _localRepository;
  final FirebaseService _firebaseService;
  LoginController({
    required RemoteRepository remoteRepository,
    required LocalRepository localRepository,
  })  : _remoteRepository = remoteRepository,
        _localRepository = localRepository,
        _firebaseService = find<FirebaseService>();

  final formKey = GlobalKey<FormBuilderState>();
  final passwordVisibility = ValueNotifier<bool>(true);

  Future<({bool isDone, String message})> login(LoginRequest request) async {
    bool result = false;
    String message = '';
    await asyncTask(() async {
      final res = await _remoteRepository.login(request);
      _localRepository.saveUser(res.data);
      _localRepository.loggedIN(isLoggedIn: res.status);
      result = res.status;
      message = res.message;
    });
    return (isDone: result, message: message);
  }

  Future<({bool isDone, String message})> onLoginPress() async {
    formKey.currentState?.save();
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return (isDone: false, message: '');
    final formData = formKey.currentState?.value ?? {};
    final deviceInfo = find<DeviceInfoProvider>();
    final token = await _firebaseService.getFirebaseToken();
    final request = LoginRequest(
      email: formData['email'],
      password: formData['password'],
      appVersion: deviceInfo.appVersion,
      deviceToken: token,
      deviceType: deviceInfo.deviceType,
      timeZone: deviceInfo.timeZone,
    );
    return await login(request);
  }

  @override
  void onClose() {
    // passwordVisibility.dispose();
    super.onClose();
  }

  void onPasswordToggle() {
    final lastV = passwordVisibility.value;
    passwordVisibility.value = !lastV;
  }
}
