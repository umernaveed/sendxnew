import 'package:json_annotation/json_annotation.dart';

part 'refferal_user.g.dart';

@JsonSerializable()
class RefferalUser {
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'first_name')
  final String? firstName;
  final String? mailbox;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'pending_balance', defaultValue: '0')
  final dynamic pendingBalance;
  @JsonKey(name: 'available_balance', defaultValue: '0')
  final dynamic availableBalance;
  final String? description;
  @JsonKey(name: 'status', defaultValue: '')
  final String? status;

  const RefferalUser({
    this.userId,
    this.firstName,
    this.mailbox,
    this.createdAt,
    this.pendingBalance,
    this.availableBalance,
    this.description,
    this.status,
  });

  factory RefferalUser.fromJson(Map<String, dynamic> json) {
    return _$RefferalUserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RefferalUserToJson(this);

  @override
  bool operator ==(covariant RefferalUser other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.firstName == firstName &&
        other.mailbox == mailbox &&
        other.createdAt == createdAt &&
        other.pendingBalance == pendingBalance &&
        other.availableBalance == availableBalance &&
        other.description == description &&
        other.status == status;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        firstName.hashCode ^
        mailbox.hashCode ^
        createdAt.hashCode ^
        pendingBalance.hashCode ^
        availableBalance.hashCode ^
        description.hashCode ^
        status.hashCode;
  }
}
