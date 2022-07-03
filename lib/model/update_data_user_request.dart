// To parse this JSON data, do
//
//     final UpdateDataUserRequest = UpdateDataUserRequestFromJson(jsonString);

import 'package:flutter_cache_manager/file.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

UpdateDataUserRequest updateDataUserRequestFromJson(String str) =>
    UpdateDataUserRequest.fromJson(json.decode(str));

String updateDataUserRequestToJson(UpdateDataUserRequest data) =>
    json.encode(data.toJson());

class UpdateDataUserRequest {
  UpdateDataUserRequest({
    required this.idUser,
    required this.nama,
    required this.description,
  });

  final int idUser;
  final String nama;
  final String description;

  UpdateDataUserRequest copyWith({
    int? idUser,
    String? nama,
    String? description,
  }) =>
      UpdateDataUserRequest(
        idUser: idUser ?? this.idUser,
        nama: nama ?? this.nama,
        description: description ?? this.description,
      );

  factory UpdateDataUserRequest.fromJson(Map<String, dynamic> json) =>
      UpdateDataUserRequest(
        idUser: json["idUser"],
        nama: json["nama"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "nama": nama,
        "description": description,
      };
}
