import 'dart:io';

import 'package:sendx/data/models/add_authorize_user_response/add_authorize_user_response.dart';
import 'package:sendx/data/models/add_pre_alert_response/add_pre_alert_response.dart';
import 'package:sendx/data/models/all_authorize_users_response/all_authorize_users_response.dart';
import 'package:sendx/data/models/app_meta/app_meta.dart';
import 'package:sendx/data/models/change_password/change_password.dart';
import 'package:sendx/data/models/create_delivery_request/create_delivery_request.dart';
import 'package:sendx/data/models/create_delivery_request/create_delivery_response.dart';
import 'package:sendx/data/models/dashboard_address_data/dashboard_address_data.dart';
import 'package:sendx/data/models/dashboard_data/dashboard_data.dart';
import 'package:sendx/data/models/delete_account_response.dart';
import 'package:sendx/data/models/delete_authorize_response/delete_authorize_response.dart';
import 'package:sendx/data/models/edit_authorize_user_response/edit_authorize_user_response.dart';
import 'package:sendx/data/models/forget_password/forget_password.dart';
import 'package:sendx/data/models/get_all_packages/get_all_packages.dart';
import 'package:sendx/data/models/get_packages_ready_for_pickup_response/get_packages_ready_for_pickup_response.dart';
import 'package:sendx/data/models/invoice/invoice.dart';
import 'package:sendx/data/models/invoice_detail/invoice_detail.dart';
import 'package:sendx/data/models/lasco_mass_pay_invoice_request/lasco_mass_pay_invoice_request.dart';
import 'package:sendx/data/models/logout/logout_response.dart';
import 'package:sendx/data/models/manage_pick_up_request_meta/manage_pick_up_request_meta.dart';
import 'package:sendx/data/models/manager/manager.dart';
import 'package:sendx/data/models/news/news.dart';
import 'package:sendx/data/models/outlet/outlet.dart';
import 'package:sendx/data/models/purchase/purchase.dart';
import 'package:sendx/data/models/refferal_user/get_all_refferal_users.dart';
import 'package:sendx/data/models/requests/add_authorize_user/add_authorize_user.dart';
import 'package:sendx/data/models/requests/add_pre_alert_request/add_pre_alert_request.dart';
import 'package:sendx/data/models/requests/add_purchas_request/add_purchas_request.dart';
import 'package:sendx/data/models/requests/change_password_request/change_password_request.dart';
import 'package:sendx/data/models/requests/delete_authorize_user/delete_authorize_user.dart';
import 'package:sendx/data/models/requests/edit_authorize_user/edit_authorize_user.dart';
import 'package:sendx/data/models/requests/forget_password_request/forget_password_request.dart';
import 'package:sendx/data/models/requests/invoice_detail_request/invoice_detail_request.dart';
import 'package:sendx/data/models/requests/log_out_request/log_out_request.dart';
import 'package:sendx/data/models/requests/login_request/login_request.dart';
import 'package:sendx/data/models/requests/offset_request/offset_request.dart';
import 'package:sendx/data/models/requests/register_user_request/register_user_request.dart';
import 'package:sendx/data/models/requests/update_authorize_user/update_authorize_user.dart';
import 'package:sendx/data/models/requests/update_purchase_request/update_purchase_request.dart';
import 'package:sendx/data/models/requests/update_user_request/update_user_request.dart';
import 'package:sendx/data/models/requests/upload_invoice_request/upload_invoice_request.dart';
import 'package:sendx/data/models/single_lasco_pay_request/single_lasco_pay_request.dart';
import 'package:sendx/data/models/unpaid_invoice/get_all_unpaid_invoices.dart';
import 'package:sendx/data/models/update_authorize_user_response/update_authorize_user_response.dart';
import 'package:sendx/data/models/upload_invoice_response/upload_invoice_response.dart';
import 'package:sendx/data/models/user/user.dart';
import 'package:sendx/data/network/base_response.dart';
import 'package:sendx/domain/datasource/remote_data_source.dart';
import 'package:sendx/domain/repositories/remote_repository.dart';

class RemoteRepositoryImp implements RemoteRepository {
  final RemoteDataSource _remoteDataSource;

  RemoteRepositoryImp({required RemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<BaseResponse<User>> login(LoginRequest request) async {
    return _remoteDataSource.login(request);
  }

  @override
  Future<BaseResponse<User>> regiterUser(RegisterUserRequest request) {
    return _remoteDataSource.regiterUser(request);
  }

  @override
  Future<BaseResponse<ForgetPassword>> forgetPassword(
      ForgetPasswordRequest request) {
    return _remoteDataSource.forgetPassword(request);
  }

  @override
  Future<BaseResponse<ChangePassword>> changePassword(
      ChangePasswordRequest request) {
    return _remoteDataSource.changePassword(request);
  }

  @override
  Future<BaseResponse<LogOutResponse>> logOut(LogOutRequest request) {
    return _remoteDataSource.logOut(request);
  }

  @override
  Future<BaseResponse<OutLet>> getOutLets() {
    return _remoteDataSource.getOutLets();
  }

  @override
  Future<BaseResponse<DashboardData>> fetchDashboard() {
    return _remoteDataSource.fetchDashboard();
  }

  @override
  Future<BaseResponse<DashboardAddressData>> getDashboardAddressData() {
    return _remoteDataSource.getDashboardAddressData();
  }

  @override
  Future<BaseResponse<AddAuthorizeUserResponse>> addAuthorizeUser(
      AddAuthorizeUser user) {
    return _remoteDataSource.addAuthorizeUser(user);
  }

  @override
  Future<BaseResponse<DeleteAuthorizeResponse>> deleteAuthorizeUser(
      DeleteAuthorizeUser user) {
    return _remoteDataSource.deleteAuthorizeUser(user);
  }

  @override
  Future<BaseResponse<EditAuthorizeUserResponse>> editAuthorizeUser(
      EditAuthorizeUser user) {
    return _remoteDataSource.editAuthorizeUser(user);
  }

  @override
  Future<BaseResponse<AllAuthorizeUsersResponse>> getAllAuthorizeUsers(
      OffsetRequest request) {
    return _remoteDataSource.getAllAuthorizeUsers(request);
  }

  @override
  Future<BaseResponse<UpdateAuthorizeUserResponse>> updateAuthorizeUser(
      UpdateAuthorizeUser user) {
    return _remoteDataSource.updateAuthorizeUser(user);
  }

  @override
  Future<BaseResponse<GetAllPackagesResponse>> getAllPackages(
      OffsetRequest offsetRequest) {
    return _remoteDataSource.getAllPackages(offsetRequest);
  }

  @override
  Future<BaseResponse<AllPackagesReadyToPick>> getAllPackagesReadyToPickup(
      OffsetRequest offsetRequest) {
    return _remoteDataSource.getAllPackagesReadyToPickup(offsetRequest);
  }

  @override
  Future<BaseResponse<AllInvoiceResponse>> getAllInvoices(
      OffsetRequest offsetRequest) {
    return _remoteDataSource.getAllInvoices(offsetRequest);
  }

  @override
  Future<BaseResponse<InvoiceDetailResponse>> getInvoiceDetails(
      InvoiceDetailRequest request) {
    return _remoteDataSource.getInvoiceDetails(request);
  }

  @override
  Future<BaseResponse<Purchase>> addPurchase(AddPurchasRequest request) {
    return _remoteDataSource.addPurchase(request);
  }

  @override
  Future<BaseResponse<AllPurchases>> getAllPurchase(
      OffsetRequest offsetRequest) {
    return _remoteDataSource.getAllPurchase(offsetRequest);
  }

  @override
  Future<BaseResponse<Purchase>> updatePurchase(UpdatePurchaseRequest request) {
    return _remoteDataSource.updatePurchase(request);
  }

  @override
  Future<BaseResponse<AddPreAlertResponse>> addPreAlert(
      AddPreAlertRequest request) {
    return _remoteDataSource.addPreAlert(request);
  }

  @override
  Future<BaseResponse<GetAllPackagesResponse>> getAllDeliveryPackage() {
    return _remoteDataSource.getAllDeliveryPackage();
  }

  @override
  Future<BaseResponse<User>> updateUser(UpdateUserRequest request,
      {File? file}) {
    return _remoteDataSource.updateUser(
      request,
      file: file,
    );
  }

  @override
  Future<BaseResponse<UploadInvoiceResponse>> uploadInvoice(
      {required UploadInvoiceRequest request,
      required File file,
      Function(double p1)? uploadProgress}) {
    return _remoteDataSource.uploadInvoice(
      request: request,
      file: file,
      uploadProgress: uploadProgress,
    );
  }

  @override
  Future<BaseResponse<File>> downloadFile(
    String url, {
    required String fileName,
    required String pathToSave,
  }) {
    return _remoteDataSource.downloadFile(
      url,
      pathToSave: pathToSave,
    );
  }

  @override
  Future<BaseResponse<AppMeta>> getAppMeta() {
    return _remoteDataSource.getAppMeta();
  }

  @override
  Future<BaseResponse<DeleteAccountResponse>> deleteAccount() {
    return _remoteDataSource.deleteAccount();
  }

  @override
  Future<BaseResponse<GetAllUsersResponse>> getRefferalUsers(
      OffsetRequest offsetRequest) {
    return _remoteDataSource.getRefferalUsers(offsetRequest);
  }

  @override
  Future<BaseResponse<ManagePickUpRequestMeta>> getManagePickUpRequestMeta() {
    return _remoteDataSource.getManagePickUpRequestMeta();
  }

  @override
  Future<BaseResponse<NewsList>> getNews(OffsetRequest request) {
    return _remoteDataSource.getNews(request);
  }

  @override
  Future<BaseResponse<CreateDeliveryResponse>> createDeliveryRequest(
      CreateDeliveryRequest request) {
    return _remoteDataSource.createDeliveryRequest(request);
  }

  @override
  Future<BaseResponse<Managers>> getManagers() {
    return _remoteDataSource.getManagers();
  }

  @override
  Future<BaseResponse<GetAllUnpaidInvoices>> getAllUnpaidInvoices() {
    return _remoteDataSource.getAllUnpaidInvoices();
  }

  @override
  Future<BaseResponse<String>> lascoMassPayInvoice(
      LascoMassPayInvoiceRequest request) {
    return _remoteDataSource.lascoMassPayInvoice(request);
  }

  @override
  Future<BaseResponse<String>> lascoSinglePayInvoice(
      SingleLascoPayRequest request) {
    return _remoteDataSource.lascoSinglePayInvoice(request);
  }
}
