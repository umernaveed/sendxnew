import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/get_di.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/data/models/requests/add_authorize_user/add_authorize_user.dart';
import 'package:sendx/data/models/requests/update_authorize_user/update_authorize_user.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/authorize/controllers/authorize_controller.dart';

class AddAuthorizeUserController extends GetxController {
  final RemoteRepository _remoteRepository;
  AddAuthorizeUserController({
    required RemoteRepository remoteRepository,
  }) : _remoteRepository = remoteRepository;

  final formKey = GlobalKey<FormBuilderState>();

  Future<({bool isDone, String message})> _addAuthorizeUser(
      AddAuthorizeUser request) async {
    bool result = false;
    String message = '';
    await asyncTask(() async {
      final res = await _remoteRepository.addAuthorizeUser(request);
      message = res.message;
      formKey.currentState?.reset();
      result = true;
      refreshAuthorizeUser();
    });
    return (isDone: result, message: message);
  }

  Future<({bool isDone, String message})> onSubmit(
      {bool isEditing = false, int? idForUpdate}) async {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) return (isDone: false, message: '');
    final formData = formKey.currentState?.value ?? {};
    final name = formData['name'];
    final phone = formData['phone'];
    final proof = formData['proof'];
    if (isEditing) {
      final id = idForUpdate!;
      final request =
          UpdateAuthorizeUser(id: id, name: name, phone: phone, proof: proof);
      final result = await _updateAuthorizeUser(request);
      return result;
    } else {
      final request = AddAuthorizeUser(name: name, phone: phone, proof: proof);
      final result = await _addAuthorizeUser(request);
      return result;
    }
  }

  Future<({bool isDone, String message})> _updateAuthorizeUser(
      UpdateAuthorizeUser request) async {
    bool result = false;
    String message = '';
    await asyncTask(() async {
      final res = await _remoteRepository.updateAuthorizeUser(request);
      message = res.message;
      formKey.currentState?.reset();
      result = true;
      refreshAuthorizeUser();
    });
    return (isDone: result, message: message);
  }

  void refreshAuthorizeUser() {
    final c = find<AuthorizeController>();
    c.refreshAuthorizeUsers();
  }
}
