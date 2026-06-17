class DeleteAuthorizeResponse {
  final String id;

  const DeleteAuthorizeResponse({required this.id});

  factory DeleteAuthorizeResponse.fromJson(Map<String, dynamic> map) {
    return DeleteAuthorizeResponse(
      id: map['id'] as String,
    );
  }
}
