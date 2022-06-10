// To parse this JSON data, do
//
//     final document = documentFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart';

Document documentFromJson(String str) => Document.fromJson(json.decode(str));

String documentToJson(Document data) => json.encode(data.toJson());

class Document {
  Document({
    required this.id,
    required this.idUser,
    required this.nama,
    required this.description,
    required this.image,
  });

  int id;
  int idUser;
  String nama;
  String description;
  String image;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        idUser: json["idUser"],
        nama: json["nama"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "nama": nama,
        "description": description,
        "image": image,
      };
}

class DocumentService {
  Future<Document> getDocumentActivity() async {
    final response = await get(Uri.parse('http://127.0.0.1:8000/api/scanner'));
    final dataUser = documentFromJson(response.body);
    return dataUser;
  }
}
