import 'dart:io';

import 'package:get/get.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/app/services/image_service.dart';
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
import 'package:sendx/data/network/api_client.dart';
import 'package:sendx/data/network/base_response.dart';
import 'package:sendx/data/network/end_points.dart';
import 'package:sendx/domain/datasource/remote_data_source.dart';

class RemoteDataSourceImp implements RemoteDataSource {
  final IApiClient _apiClient;

  RemoteDataSourceImp({required IApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<BaseResponse<User>> login(LoginRequest request) async {
    final response = await _apiClient.postReq(
      EndPoints.loginUser,
      request.toJson(),
    );

    return _decode<BaseResponse<User>>(
      response,
      (json) => BaseResponse<User>(
        json['status'],
        json['message'],
        User.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<User>> regiterUser(RegisterUserRequest request) async {
    final response = await _apiClient.postReq(
      EndPoints.registerUser,
      request.toJson(),
    );

    return _decode<BaseResponse<User>>(
      response,
      (json) => BaseResponse<User>(
        json['status'],
        json['message'],
        User.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<ForgetPassword>> forgetPassword(
      ForgetPasswordRequest request) async {
    final response = await _apiClient.postReq(
      EndPoints.forgotPassword,
      request.toJson(),
    );

    return _decode<BaseResponse<ForgetPassword>>(
      response,
      (json) => BaseResponse<ForgetPassword>(
        json['status'],
        json['message'],
        ForgetPassword.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<ChangePassword>> changePassword(
      ChangePasswordRequest request) async {
    final response = await _apiClient
        .postReq(EndPoints.changePassword, request.toJson(), headers: {
      'Accept': 'application/json',
    });
    return _decode<BaseResponse<ChangePassword>>(
      response,
      (json) => BaseResponse<ChangePassword>(
        json['status'],
        json['message'],
        ChangePassword.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<LogOutResponse>> logOut(LogOutRequest request) async {
    final response = await _apiClient.postReq(
      EndPoints.logout,
      request.toJson(),
    );
    response.body['data'] = {'login_token': request.loginToken};
    return _decode<BaseResponse<LogOutResponse>>(
      response,
      (json) => BaseResponse<LogOutResponse>(
        json['status'],
        json['message'],
        LogOutResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<OutLet>> getOutLets() async {
    final response = await _apiClient.getReq(EndPoints.getOutlets);
    return _decode<BaseResponse<OutLet>>(
      response,
      (json) => BaseResponse<OutLet>(
        json['status'],
        json['message'],
        OutLet.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<DashboardData>> fetchDashboard() async {
    final response = await _apiClient.getReq(EndPoints.getDashboardData);
    return _decode<BaseResponse<DashboardData>>(
      response,
      (json) => BaseResponse<DashboardData>(
        json['status'],
        json['message'],
        DashboardData.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<DashboardAddressData>> getDashboardAddressData() async {
    final response = await _apiClient.getReq(EndPoints.getAddressData);
    return _decode<BaseResponse<DashboardAddressData>>(
      response,
      (json) => BaseResponse<DashboardAddressData>(
        json['status'],
        json['message'],
        DashboardAddressData.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<AddAuthorizeUserResponse>> addAuthorizeUser(
      AddAuthorizeUser user) async {
    final response =
        await _apiClient.postReq(EndPoints.addAuthorizeUser, user.toJson());
    return _decode<BaseResponse<AddAuthorizeUserResponse>>(
      response,
      (json) => BaseResponse<AddAuthorizeUserResponse>(
        json['status'],
        json['message'],
        AddAuthorizeUserResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<DeleteAuthorizeResponse>> deleteAuthorizeUser(
      DeleteAuthorizeUser user) async {
    final response =
        await _apiClient.postReq(EndPoints.deleteAuthorizeUser, user.toJson());
    // only mobile side
    response.body['data'] = {'id': user.id};

    return _decode<BaseResponse<DeleteAuthorizeResponse>>(
      response,
      (json) => BaseResponse<DeleteAuthorizeResponse>(
        json['status'],
        json['message'],
        DeleteAuthorizeResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<EditAuthorizeUserResponse>> editAuthorizeUser(
      EditAuthorizeUser user) async {
    final response = await _apiClient.postReq(
      EndPoints.editAuthorizeUser,
      user.toJson(),
    );

    return _decode<BaseResponse<EditAuthorizeUserResponse>>(
      response,
      (json) => BaseResponse<EditAuthorizeUserResponse>(
        json['status'],
        json['message'],
        EditAuthorizeUserResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<AllAuthorizeUsersResponse>> getAllAuthorizeUsers(
      OffsetRequest request) async {
    final response = await _apiClient.postReq(
      EndPoints.getAuthorizeUsers,
      request.toJson(),
    );
    return _decode<BaseResponse<AllAuthorizeUsersResponse>>(
      response,
      (json) => BaseResponse<AllAuthorizeUsersResponse>(
        json['status'],
        json['message'],
        AllAuthorizeUsersResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<UpdateAuthorizeUserResponse>> updateAuthorizeUser(
      UpdateAuthorizeUser user) async {
    final response = await _apiClient.postReq(
      EndPoints.updateAuthorizeUser,
      user.toJson(),
    );
    return _decode<BaseResponse<UpdateAuthorizeUserResponse>>(
      response,
      (json) => BaseResponse<UpdateAuthorizeUserResponse>(
        json['status'],
        json['message'],
        UpdateAuthorizeUserResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<AllPackagesReadyToPick>> getAllPackagesReadyToPickup(
      OffsetRequest offsetRequest) async {
    final response = await _apiClient.postReq(
      EndPoints.getReadyforPickupPackages,
      offsetRequest.toJson(),
    );
    if (response.body.toString().contains('data') &&
        response.body['data'] != null) {
      response.body['status'] = 'true';
    }

    return _decode<BaseResponse<AllPackagesReadyToPick>>(
      response,
      (json) => BaseResponse<AllPackagesReadyToPick>(
        asBoolSafeCast(json['status']),
        json['message'],
        AllPackagesReadyToPick.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<GetAllPackagesResponse>> getAllPackages(
      OffsetRequest offsetRequest) async {
    final response = await _apiClient.postReq(
      EndPoints.getAllPackages,
      offsetRequest.toJson(),
    );
    if (response.body.toString().contains('data') &&
        response.body['data'] != null) {
      response.body['status'] = 'true';
    }

    return _decode<BaseResponse<GetAllPackagesResponse>>(
      response,
      (json) => BaseResponse<GetAllPackagesResponse>(
        asBoolSafeCast(json['status']),
        json['message'],
        GetAllPackagesResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<AllInvoiceResponse>> getAllInvoices(
      OffsetRequest offsetRequest) async {
    final response = await _apiClient.postReq(
      EndPoints.getAllInvoices,
      offsetRequest.toJson(),
    );
    return _decode<BaseResponse<AllInvoiceResponse>>(
      response,
      (json) => BaseResponse<AllInvoiceResponse>(
        json['status'],
        json['message'],
        AllInvoiceResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<InvoiceDetailResponse>> getInvoiceDetails(
      InvoiceDetailRequest request) async {
    final response = await _apiClient.postReq(
      EndPoints.invoicesDetail,
      request.toJson(),
    );
    return _decode<BaseResponse<InvoiceDetailResponse>>(
      response,
      (json) => BaseResponse<InvoiceDetailResponse>(
        json['status'],
        json['message'],
        InvoiceDetailResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<AllPurchases>> getAllPurchase(
      OffsetRequest offsetRequest) async {
    final response = await _apiClient.postReq(
      EndPoints.getPurchase,
      offsetRequest.toJson(),
    );
    return _decode<BaseResponse<AllPurchases>>(
      response,
      (json) => BaseResponse<AllPurchases>(
        json['status'],
        json['message'],
        AllPurchases.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<Purchase>> addPurchase(AddPurchasRequest request) async {
    final response = await _apiClient.postReq(
      EndPoints.addPurchase,
      request.toJson(),
    );
    return _decode<BaseResponse<Purchase>>(
      response,
      (json) => BaseResponse<Purchase>(
        json['status'],
        json['message'],
        Purchase.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<Purchase>> updatePurchase(
      UpdatePurchaseRequest request) async {
    final response = await _apiClient.postReq(
      EndPoints.addPurchase,
      request.toJson(),
    );
    return _decode<BaseResponse<Purchase>>(
      response,
      (json) => BaseResponse<Purchase>(
        json['status'],
        json['message'],
        Purchase.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<AddPreAlertResponse>> addPreAlert(
      AddPreAlertRequest request) async {
    final response = await _apiClient.postReq(
      EndPoints.addPreAlert,
      request.toJson(),
    );
    return _decode<BaseResponse<AddPreAlertResponse>>(
      response,
      (json) => BaseResponse<AddPreAlertResponse>(
        json['status'],
        json['message'],
        AddPreAlertResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<GetAllPackagesResponse>> getAllDeliveryPackage() async {
    final response = await _apiClient.getReq(EndPoints.getDeliveryPackages);
    if (response.body.toString().contains('data') &&
        response.body['data'] != null) {
      response.body['status'] = true;
    }
    return _decode<BaseResponse<GetAllPackagesResponse>>(
      response,
      (json) => BaseResponse<GetAllPackagesResponse>(
        json['status'],
        json['message'],
        GetAllPackagesResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<User>> updateUser(
    UpdateUserRequest request, {
    File? file,
  }) async {
    final dataMap = request.toJson();
    dataMap.remove('email');
    final formData = FormData(dataMap);

    if (file != null) {
      String fileName = file.path.split('/').last;
      final userImage = MultipartFile(file, filename: fileName);
      formData.files.add(
        MapEntry(
          'user_image',
          userImage,
        ),
      );
    }
    final response = await _apiClient.postReq(
      EndPoints.editProfile,
      formData,
    );
    return _decode<BaseResponse<User>>(
      response,
      (json) => BaseResponse<User>(
        json['status'],
        json['message'],
        User.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<UploadInvoiceResponse>> uploadInvoice({
    required UploadInvoiceRequest request,
    required File file,
    dynamic Function(double)? uploadProgress,
  }) async {
    final dataMap = request.toJson();
    final formData = FormData(dataMap);
    String fileName = file.path.split('/').last;
    final multiFile = MultipartFile(file, filename: fileName);
    formData.files.add(MapEntry('upload_invoice', multiFile));
    final response = await _apiClient.postReq(
      EndPoints.uploadInvoice,
      formData,
      uploadProgress: uploadProgress,
    );
    return _decode<BaseResponse<UploadInvoiceResponse>>(
      response,
      (json) => BaseResponse<UploadInvoiceResponse>(
        json['status'],
        json['message'],
        UploadInvoiceResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<File>> downloadFile(
    String url, {
    required String pathToSave,
  }) async {
    final response = await _apiClient.downloadFile(
      url,
      pathToSave: pathToSave,
    );
    return BaseResponse(
      true,
      'File Successfully Downloaded',
      response.toFile(),
    );
  }

  @override
  Future<BaseResponse<AppMeta>> getAppMeta() async {
    final response = await _apiClient.getReq(EndPoints.getMetraAppInformation);
    return _decode<BaseResponse<AppMeta>>(
      response,
      (json) => BaseResponse<AppMeta>(
        json['status'],
        json['message'],
        AppMeta.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<DeleteAccountResponse>> deleteAccount() async {
    final response = await _apiClient.getReq(EndPoints.deleteAccount);
    return _decode<BaseResponse<DeleteAccountResponse>>(
      response,
      (json) => BaseResponse<DeleteAccountResponse>(
        json['status'],
        json['message'],
        DeleteAccountResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<GetAllUsersResponse>> getRefferalUsers(
      OffsetRequest offsetRequest) async {
    final response = await _apiClient.postReq(
      EndPoints.getReferralUsers,
      offsetRequest.toJson(),
    );
    if (response.body.toString().contains('data') &&
        response.body['data'] != null) {
      response.body['status'] = true;
    }

    return _decode<BaseResponse<GetAllUsersResponse>>(
      response,
      (json) => BaseResponse<GetAllUsersResponse>(
        json['status'],
        json['message'],
        GetAllUsersResponse.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<ManagePickUpRequestMeta>>
      getManagePickUpRequestMeta() async {
    final response =
        await _apiClient.getReq(EndPoints.getManagePickUpDeliveryMeta);
    return _decode<BaseResponse<ManagePickUpRequestMeta>>(
      response,
      (json) => BaseResponse<ManagePickUpRequestMeta>(
        json['status'],
        json['message'],
        ManagePickUpRequestMeta.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<NewsList>> getNews(OffsetRequest request) async {
    final response = await _apiClient.postReq(
      EndPoints.getNews,
      request.toJson(),
    );
    if (response.body.toString().contains('data') &&
        response.body['data'] != null) {
      response.body['status'] = true;
    }
    return _decode<BaseResponse<NewsList>>(
      response,
      (json) => BaseResponse<NewsList>(
        json['status'],
        json['message'],
        NewsList.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<CreateDeliveryResponse>> createDeliveryRequest(
    CreateDeliveryRequest request,
  ) async {
    final response = await _apiClient.postReq(
      EndPoints.createDeliveryRequest,
      request.toJson(),
    );
    return _decode<BaseResponse<CreateDeliveryResponse>>(
      response,
      (json) => BaseResponse<CreateDeliveryResponse>(
        json['status'],
        json['message'],
        CreateDeliveryResponse(data: null),
      ),
    );
  }

  @override
  Future<BaseResponse<Managers>> getManagers() async {
    final response = await _apiClient.getReq(EndPoints.getManagers);
    if (response.body.toString().contains('data') &&
        response.body['data'] != null) {
      response.body['status'] = true;
    }
    return _decode<BaseResponse<Managers>>(
      response,
      (json) => BaseResponse<Managers>(
        json['status'],
        json['message'],
        Managers.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<GetAllUnpaidInvoices>> getAllUnpaidInvoices() async {
    final response = await _apiClient.getReq(EndPoints.getUnpaidInvoices);
    if (response.body.toString().contains('data') &&
        response.body['data'] != null) {
      response.body['status'] = 'true';
    }

    return _decode<BaseResponse<GetAllUnpaidInvoices>>(
      response,
      (json) => BaseResponse<GetAllUnpaidInvoices>(
        asBoolSafeCast(json['status']),
        json['message'],
        GetAllUnpaidInvoices.fromJson(json['data']),
      ),
    );
  }

  @override
  Future<BaseResponse<String>> lascoSinglePayInvoice(
      SingleLascoPayRequest request) async {
    final response = await _apiClient.postReq(
        EndPoints.lascoSinglePayInvoice, request.toJson());
    if (response.body.toString().contains('data') &&
        response.body['data'] != null) {
      response.body['status'] = 'true';
    }

    return _decode<BaseResponse<String>>(
      response,
      (json) => BaseResponse<String>(
        asBoolSafeCast(json['status']),
        json['message'],
        json['data'].toString(),
      ),
    );
  }

  @override
  Future<BaseResponse<String>> lascoMassPayInvoice(
      LascoMassPayInvoiceRequest request) async {
    final response = await _apiClient.postReq(
        EndPoints.lascoMassPayInvoice, request.toJson());
    if (response.body.toString().contains('data') &&
        response.body['data'] != null) {
      response.body['status'] = 'true';
    }

    return _decode<BaseResponse<String>>(
      response,
      (json) => BaseResponse<String>(
        asBoolSafeCast(json['status']),
        json['message'],
        json['data'].toString(),
      ),
    );
  }
}

T _decode<T>(Response response, T Function(dynamic) decoder) {
  if (response.hasError) {
    final isHTML = response.body.toString().containsHtml() ||
        (response.bodyString?.containsHtml() ?? false);
    if (isHTML) {
      throw CommonException(message: 'Something went wrong');
    }
    if (response.unauthorized) {
      throw UnAuthorizeException(
          message: response.statusText ?? 'User Session Expire');
    }

    throw CommonException(
      message: response.statusText ?? 'Something went wrong',
    );
  }
  if (response.body['status'] == false) {
    throw MessageException(message: response.body['message']);
  }
  return decoder(response.body);
}

class CommonException implements Exception {
  final String message;

  CommonException({required this.message});

  @override
  String toString() {
    return message.toString();
  }
}

class MessageException implements Exception {
  final String message;

  MessageException({required this.message});

  @override
  String toString() {
    return message.toString();
  }
}

class UnAuthorizeException implements Exception {
  final String message;

  UnAuthorizeException({required this.message});

  @override
  String toString() {
    return message.toString();
  }
}

bool asBoolSafeCast(dynamic value) {
  final isString = value is String;
  final isInt = value is int;
  if (isString) {
    final key = value.toString();
    return key == 'true';
  } else if (isInt) {
    final key = int.tryParse('$value') ?? 0;
    return key == 1;
  } else {
    return value as bool;
  }
}
