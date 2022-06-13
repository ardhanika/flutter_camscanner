import 'dart:io';

import 'package:docscan/model/data_user_model.dart';
import 'package:dio/dio.dart';
import 'package:docscan/network/endpoint.dart';
import 'package:docscan/model/general_response.dart';
import 'package:docscan/model/store_data_user_request.dart';
import 'package:docscan/pages/login/bloc/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final _dio = Dio();
  // final String baseUrl = "http://10.0.2.2:8000";
  final String baseUrl = "http://127.0.0.1:8000";
  String token = '';

  _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('sanctum_token') ?? '');
  }

  Future<UserResponse> getDataUser() async {
    _loadToken();
    final _response = await _dio.get(Endpoint.getDataUser,
        // $TokenAuth belum fix
        options: Options(headers: {"authorization": "Bearer $token"}));

    return UserResponse.fromJson(_response.data);
  }

  Future<GeneralResponse> createDataUser(StoreDataUserRequest request) async {
    final _response = await _dio.post(
      Endpoint.createDataUser,
      data: request.toJson(),
    );

    return GeneralResponse.fromJson(_response.data);
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
    final _response = await _dio.post("/info", data: formData);
    return _response.data['id'];
  }
}
