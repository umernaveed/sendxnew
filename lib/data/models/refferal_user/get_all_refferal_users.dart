import 'package:flutter/foundation.dart';
import 'package:sendx/data/models/refferal_user/refferal_user.dart';

class GetAllUsersResponse {
  final List<RefferalUser> users;

  GetAllUsersResponse({required this.users});

  factory GetAllUsersResponse.fromJson(List<dynamic> json) {
    return GetAllUsersResponse(
      users: json.map((e) {
        return RefferalUser.fromJson(e as Map<String, dynamic>);
      }).toList(),
    );
  }

  @override
  bool operator ==(covariant GetAllUsersResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.users, users);
  }

  @override
  int get hashCode => users.hashCode;
}
