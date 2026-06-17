import 'package:json_annotation/json_annotation.dart';

part 'offset_request.g.dart';

@JsonSerializable()
class OffsetRequest {
  @JsonKey(name: 'offset')
  final String offset;
  @JsonKey(name: 'keyword')
  final String keyword;

  const OffsetRequest({required this.offset, this.keyword = ''});

  factory OffsetRequest.fromJson(Map<String, dynamic> json) {
    return _$OffsetRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OffsetRequestToJson(this);
}
