import 'dart:math';

import 'package:get/get.dart';
import 'package:sendx/app/extensions/controller_ext.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/data/models/all_authorize_users_response/all_authorize_users_response.dart';
import 'package:sendx/data/models/requests/delete_authorize_user/delete_authorize_user.dart';
import 'package:sendx/data/models/requests/offset_request/offset_request.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';
import 'package:sendx/presentation/mixin/pagination_service.dart';

class AuthorizeController extends GetxController
    with PaginationService<AuthorizeUsersResponse> {
  final RemoteRepository _remoteRepository;

  AuthorizeController({required RemoteRepository remoteRepository})
      : _remoteRepository = remoteRepository;

  final authorizeNestedID = Random().nextInt(999);

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

  void refreshAuthorizeUsers() => pagingController.refresh();

  Future<void> deleteAuthorizeUser({required String id}) async {
    var message = '';
    await asyncTask(() async {
      final res = await _remoteRepository
          .deleteAuthorizeUser(DeleteAuthorizeUser(id: id));
      message = res.message;
      if (res.status) refreshAuthorizeUsers();
    }).then((value) {
      if (message.isNotEmpty) FlushSnackbar.showSnackBar(message);
    });
  }

  @override
  Future<List<AuthorizeUsersResponse>> listener(int pageKey,
      {String keyToSearch = ''}) async {
    final res = await _remoteRepository.getAllAuthorizeUsers(OffsetRequest(
      offset: pageKey.toString(),
      keyword: keyToSearch,
    ));
    return res.data.authorizeUsers;
  }
}
