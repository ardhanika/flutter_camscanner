import 'package:meta/meta.dart';
import 'dart:convert';

UserResponsee userResponseeFromJson(String str) =>
    UserResponsee.fromJson(json.decode(str));

String userResponseeToJson(UserResponsee data) => json.encode(data.toJson());

class UserResponsee {
  UserResponsee({
    required this.message,
    required this.data,
  });

  final String message;
  final UserDataResponsee data;

  factory UserResponsee.fromJson(Map<String, dynamic> json) => UserResponsee(
        message: json["message"],
        data: UserDataResponsee.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class UserDataResponsee {
  UserDataResponsee({
    required this.id,
    required this.name,
    required this.email,
  });

  final int id;
  final String name;
  final String email;

  factory UserDataResponsee.fromJson(Map<String, dynamic> json) =>
      UserDataResponsee(
        id: json["id"],
        name: json["full_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": name,
        "email": email,
      };
}
