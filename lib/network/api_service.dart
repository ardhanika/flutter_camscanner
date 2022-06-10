import 'package:docscan/model/data_user_model.dart';
import 'package:dio/dio.dart';
import 'package:docscan/network/endpoint.dart';
import 'package:docscan/model/general_response.dart';
import 'package:docscan/model/store_data_user_request.dart';
import 'package:docscan/bloc/auth/auth_repository.dart';

class ApiService {
  final _dio = Dio();
  // final String baseUrl = "http://10.0.2.2:8000";
  final String baseUrl = "http://127.0.0.1:8000";

  Future<UserResponse> getDataUser() async {
    final token = await AuthRepository().hasToken();
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
}
