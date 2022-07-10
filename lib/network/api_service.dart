import 'dart:convert';
import 'dart:io';

import 'package:docscan/model/data_user_model.dart';
import 'package:dio/dio.dart';
import 'package:docscan/network/endpoint.dart';
import 'package:docscan/model/general_response.dart';
import 'package:docscan/model/store_data_user_request.dart';
import 'package:docscan/model/update_data_user_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final _dio = Dio();
  String token = '';

  Future _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token_sanctum') ?? '');
    return token;
  }

  Future<List<UserDataResponse>> getDataUser() async {
    final token = await _loadToken();
    final _response = await _dio.get(Endpoint.getDataUser,
        options: Options(headers: {"authorization": "Bearer $token"}));
    return (_response.data as List)
        .map((x) => UserDataResponse.fromJson(x))
        .toList();
  }

  Future<StoreDataUserRequest?> createDataUser(
      String nama, String description, File? image) async {
    try {
      final token = await _loadToken();
      final String foto = image!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'nama': nama,
        'description': description,
        'image': await MultipartFile.fromFile(image.path, filename: foto)
      });
      final response = await Dio().post(
        Endpoint.createDataUser,
        data: formData,
        options: Options(
            followRedirects: true,
            validateStatus: (status) => true,
            headers: {
              "Accept": "application/json",
              "authorization": "Bearer $token"
            }),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GeneralResponse> updateDataUser(
      UpdateDataUserRequest request, int id) async {
    final token = await _loadToken();
    final _response = await _dio.put("${Endpoint.updateDataUser}/$id",
        data: request.toJson(),
        options: Options(headers: {"authorization": "Bearer $token"}));

    return GeneralResponse.fromJson(_response.data);
  }

  Future<GeneralResponse> deleteDataUser(int id) async {
    final token = await _loadToken();
    final _response = await _dio.delete("${Endpoint.deleteDataUser}/$id",
        options: Options(headers: {"authorization": "Bearer $token"}));

    return GeneralResponse.fromJson(_response.data);
  }
}
