import 'dart:convert';
import 'dart:io';

import 'package:docscan/model/data_user_model.dart';
import 'package:dio/dio.dart';
import 'package:docscan/network/endpoint.dart';
import 'package:docscan/model/general_response.dart';
import 'package:docscan/model/store_data_user_request.dart';
import 'package:docscan/pages/login/bloc/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final _dio = Dio();
  String token = '';

  Future _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token_sanctum') ?? '');
    return token;
  }

  // List<UserResponse> dataUser(String responseBody) {
  //   var list = jsonDecode(responseBody) as List<dynamic>;
  //   List<UserResponse> dataUsers = list
  //       .map((model) => UserResponse.fromJson(model))
  //       .cast<UserResponse>()
  //       .toList();
  //   return dataUsers;
  // }

  // Future<List<UserResponse>> fetchData() async {
  //   final token = await _loadToken();
  //   final _response = await _dio.get(Endpoint.getDataUser,
  //       options: Options(headers: {"authorization": "Bearer $token"}));

  //   if (_response.statusCode == 200) {
  //     return compute(dataUser, _response.data);
  //   } else {
  //     throw Exception('Error API');
  //   }
  // }

  Future<UserDataResponse> getDataUser() async {
    final token = await _loadToken();
    final _response = await _dio.get(Endpoint.getDataUser,
        options: Options(headers: {"authorization": "Bearer $token"}));

    return UserDataResponse.fromJson(jsonDecode(_response.data));
  }

  Future<GeneralResponse> createDataUser(StoreDataUserRequest request) async {
    final _response = await _dio.post(
      Endpoint.createDataUser,
      data: request.toJson(),
    );

    return GeneralResponse.fromJson(_response.data[0]);
  }

  Future<GeneralResponse> updateDataUser(StoreDataUserRequest request) async {
    final _response = await _dio.put(
      Endpoint.updateDataUser,
      data: request.toJson(),
    );

    return GeneralResponse.fromJson(_response.data);
  }

  Future<GeneralResponse> deleteDataUser(StoreDataUserRequest request) async {
    final _response =
        await _dio.delete(Endpoint.deleteDataUser, data: request.toJson());

    return GeneralResponse.fromJson(_response.data);
  }

  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final _response = await _dio.post(Endpoint.createDataUser, data: formData);
    return _response.data['id'];
  }
}
