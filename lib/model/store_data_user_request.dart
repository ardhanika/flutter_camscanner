// To parse this JSON data, do
//
//     final storeDataUserRequest = storeDataUserRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StoreDataUserRequest storeDataUserRequestFromJson(String str) =>
    StoreDataUserRequest.fromJson(json.decode(str));

String storeDataUserRequestToJson(StoreDataUserRequest data) =>
    json.encode(data.toJson());

class StoreDataUserRequest {
  StoreDataUserRequest({
    required this.idUser,
    required this.nama,
    required this.description,
    required this.image,
  });

  final int idUser;
  final String nama;
  final String description;
  final String image;

  StoreDataUserRequest copyWith({
    int? idUser,
    String? nama,
    String? description,
    String? image,
  }) =>
      StoreDataUserRequest(
        idUser: idUser ?? this.idUser,
        nama: nama ?? this.nama,
        description: description ?? this.description,
        image: image ?? this.image,
      );

  factory StoreDataUserRequest.fromJson(Map<String, dynamic> json) =>
      StoreDataUserRequest(
        idUser: json["idUser"],
        nama: json["nama"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "nama": nama,
        "description": description,
        "image": image,
      };
}
