class DeleteAccountResponse {
  final dynamic data;

  DeleteAccountResponse({required this.data});

  factory DeleteAccountResponse.fromJson(dynamic value) {
    return DeleteAccountResponse(data: value);
  }
}
