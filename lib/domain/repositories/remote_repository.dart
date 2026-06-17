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

abstract class RemoteRepository {
  Future<BaseResponse<User>> login(LoginRequest request);
  Future<BaseResponse<User>> regiterUser(RegisterUserRequest request);
  Future<BaseResponse<ForgetPassword>> forgetPassword(
      ForgetPasswordRequest request);

  Future<BaseResponse<ChangePassword>> changePassword(
      ChangePasswordRequest request);

  Future<BaseResponse<LogOutResponse>> logOut(LogOutRequest request);
  Future<BaseResponse<OutLet>> getOutLets();
  Future<BaseResponse<DashboardData>> fetchDashboard();
  Future<BaseResponse<DashboardAddressData>> getDashboardAddressData();

  Future<BaseResponse<EditAuthorizeUserResponse>> editAuthorizeUser(
      EditAuthorizeUser user);
  Future<BaseResponse<UpdateAuthorizeUserResponse>> updateAuthorizeUser(
      UpdateAuthorizeUser user);
  Future<BaseResponse<AddAuthorizeUserResponse>> addAuthorizeUser(
      AddAuthorizeUser user);
  Future<BaseResponse<AllAuthorizeUsersResponse>> getAllAuthorizeUsers(
      OffsetRequest request);
  Future<BaseResponse<DeleteAuthorizeResponse>> deleteAuthorizeUser(
      DeleteAuthorizeUser user);

  Future<BaseResponse<AllPackagesReadyToPick>> getAllPackagesReadyToPickup(
      OffsetRequest offsetRequest);
  Future<BaseResponse<GetAllPackagesResponse>> getAllPackages(
      OffsetRequest offsetRequest);

  Future<BaseResponse<AllInvoiceResponse>> getAllInvoices(
      OffsetRequest offsetRequest);
  Future<BaseResponse<InvoiceDetailResponse>> getInvoiceDetails(
      InvoiceDetailRequest request);

  Future<BaseResponse<AllPurchases>> getAllPurchase(
      OffsetRequest offsetRequest);
  Future<BaseResponse<Purchase>> addPurchase(AddPurchasRequest request);
  Future<BaseResponse<Purchase>> updatePurchase(UpdatePurchaseRequest request);
  Future<BaseResponse<AddPreAlertResponse>> addPreAlert(
      AddPreAlertRequest request);
  Future<BaseResponse<GetAllPackagesResponse>> getAllDeliveryPackage();
  Future<BaseResponse<User>> updateUser(
    UpdateUserRequest request, {
    File? file,
  });
  Future<BaseResponse<UploadInvoiceResponse>> uploadInvoice({
    required UploadInvoiceRequest request,
    required File file,
    dynamic Function(double)? uploadProgress,
  });

  Future<BaseResponse<File>> downloadFile(
    String url, {
    required String fileName,
    required String pathToSave,
  });

  Future<BaseResponse<AppMeta>> getAppMeta();
  Future<BaseResponse<DeleteAccountResponse>> deleteAccount();
  Future<BaseResponse<GetAllUsersResponse>> getRefferalUsers(
    OffsetRequest offsetRequest,
  );
  Future<BaseResponse<ManagePickUpRequestMeta>> getManagePickUpRequestMeta();
  Future<BaseResponse<NewsList>> getNews(OffsetRequest request);
  Future<BaseResponse<CreateDeliveryResponse>> createDeliveryRequest(
      CreateDeliveryRequest request);

  Future<BaseResponse<Managers>> getManagers();

  Future<BaseResponse<GetAllUnpaidInvoices>> getAllUnpaidInvoices();
  Future<BaseResponse<String>> lascoSinglePayInvoice(
    SingleLascoPayRequest request,
  );

  Future<BaseResponse<String>> lascoMassPayInvoice(
    LascoMassPayInvoiceRequest request,
  );
}
