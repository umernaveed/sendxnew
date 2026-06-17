import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_authorize_users_response.g.dart';

@JsonSerializable()
class AuthorizeUsersResponse {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'proof')
  final String proof;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  const AuthorizeUsersResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.proof,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AuthorizeUsersResponse.fromJson(Map<String, dynamic> json) {
    return _$AuthorizeUsersResponseFromJson(json);
  }

  factory AuthorizeUsersResponse.empty() {
    return const AuthorizeUsersResponse(
      id: -1,
      createdAt: '',
      name: '',
      phone: '',
      proof: '',
      updatedAt: '',
      userId: -1,
    );
  }

  Map<String, dynamic> toJson() => _$AuthorizeUsersResponseToJson(this);

  @override
  bool operator ==(covariant AuthorizeUsersResponse other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.name == name &&
        other.phone == phone &&
        other.proof == proof &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        proof.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class AllAuthorizeUsersResponse {
  final List<AuthorizeUsersResponse> authorizeUsers;

  AllAuthorizeUsersResponse({
    required this.authorizeUsers,
  });

  factory AllAuthorizeUsersResponse.fromJson(List<dynamic> json) {
    return AllAuthorizeUsersResponse(
      authorizeUsers: json
          .map(
              (e) => AuthorizeUsersResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  bool operator ==(covariant AllAuthorizeUsersResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.authorizeUsers, authorizeUsers);
  }

  @override
  int get hashCode => authorizeUsers.hashCode;
}
