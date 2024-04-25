import 'package:hive_flutter/hive_flutter.dart';

part 'hive_generated/user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String? token;

  @HiveField(1)
  String? userId;

  @HiveField(2)
  String? userEmail;

  @HiveField(3)
  String? userNicename;

  @HiveField(4)
  String? userDisplayName;

  @HiveField(5)
  String? userRole;

  UserModel({
    this.token,
    this.userId,
    this.userEmail,
    this.userNicename,
    this.userDisplayName,
    this.userRole,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        userId: json["user_id"],
        userEmail: json["user_email"],
        userNicename: json["user_nicename"],
        userDisplayName: json["user_display_name"],
        userRole: json["user_role"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_id": userId,
        "user_email": userEmail,
        "user_nicename": userNicename,
        "user_display_name": userDisplayName,
        "user_role": userRole,
      };

  @override
  String toString() {
    return 'userLoginModel(token: $token, userId: $userId, userEmail: $userEmail, userNicename: $userNicename, userDisplayName: $userDisplayName, userRole: $userRole)';
  }
}
