// To parse this JSON data, do
//
//     final generalResponse = generalResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GeneralResponse generalResponseFromJson(String str) =>
    GeneralResponse.fromJson(json.decode(str));

String generalResponseToJson(GeneralResponse data) =>
    json.encode(data.toJson());

class GeneralResponse {
  GeneralResponse({
    required this.message,
    required this.isSuccess,
  });

  final String message;
  final bool isSuccess;

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      GeneralResponse(
        message: json["message"],
        isSuccess: json["isSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
      };
}
