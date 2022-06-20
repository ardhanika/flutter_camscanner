// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    required this.message,
    required this.data,
  });

  final String message;
  final List<UserDataResponse> data;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        message: json["message"],
        data: List<UserDataResponse>.from(
            json["data"].map((x) => UserDataResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UserDataResponse {
  UserDataResponse({
    required this.id,
    required this.idUser,
    required this.nama,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String idUser;
  final String nama;
  final String description;
  final String image;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      UserDataResponse(
        id: json["id"],
        idUser: json["idUser"],
        nama: json["nama"],
        description: json["description"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "nama": nama,
        "description": description,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
