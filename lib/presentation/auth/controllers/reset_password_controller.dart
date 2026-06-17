// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/data/models/requests/change_password_request/change_password_request.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';

class ResetPasswordController extends GetxController {
  final RemoteRepository _remoteRepository;
  ResetPasswordController({
    required RemoteRepository remoteRepository,
  }) : _remoteRepository = remoteRepository;

  final formKey = GlobalKey<FormBuilderState>();

  Future<({bool isDone, String message})> _changePassword(
      ChangePasswordRequest request) async {
    bool result = false;
    String message = '';
    await asyncTask(() async {
      final res = await _remoteRepository.changePassword(request);
      message = res.message;
      formKey.currentState?.reset();
      result = res.status;
    });

    return (isDone: result, message: message);
  }

  Future<({bool isDone, String message})> onSubmit() async {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) return (isDone: false, message: '');
    final formData = formKey.currentState?.value ?? {};
    final request = ChangePasswordRequest(
      oldPass: formData['old_pass'],
      newPass: formData['new_pass'],
    );
    final result = await _changePassword(request);
    return result;
  }
}
