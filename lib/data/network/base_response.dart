import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  BaseResponse(
    this.status,
    this.message,
    this.data,
  );

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);
  final bool status;
  final String message;
  final T data;

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}

extension BaseResponseX on BaseResponse {
  bool isSuccess() => status;
  String getMessage() => message;
  bool get showMessage => message.isNotEmpty;
}
