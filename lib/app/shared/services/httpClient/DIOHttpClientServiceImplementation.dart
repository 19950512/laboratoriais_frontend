// ignore_for_file: unused_local_variable, file_names, prefer_interpolation_to_compose_strings

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../either.dart';
import '../../stores/auth/auth_store.dart';
import 'HttpClientResponse.dart';
import 'IHttpClientServiceInterface.dart';

class DIOHttpClientServiceImplementation
    implements IHttpClientServiceInterface {
  @override
  String get baseUrl => 'http://192.168.1.110:8052';

  Dio get httpClient => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Modular.get<AuthStore>().accessToken}',
          },
        ),
      );

  @override
  Future<bool> downloadFile(String urlOfFile, localToSaveInDevice) async {
    try {
      final response = await httpClient.download(
        urlOfFile,
        '$localToSaveInDevice${DateTime.now().millisecond}.jpg',
      );

      if (response.data != null) {
        return false;
      }

      return false;
    } on DioException catch (error) {
      throw Exception(error.message);
    }
  }

  @override
  Future<Either<String, HttpClientResponse>> get(String url) async {
    AuthStore authStore = Modular.get<AuthStore>();

    httpClient.options.headers['Authorization'] =
        'Bearer ${authStore.accessToken}';

    print('Bearer ${authStore.accessToken}');
    try {
      final response = await httpClient.get(url);

      return Right(HttpClientResponse(response.data));
    } on DioException catch (error) {
      String resposta = error.message ?? '';

      if (error.response != null) {
        if (error.response!.statusCode == 500) {
          return Left('Erro interno do servidor');
        }

        if (error.response!.statusCode == 403) {
          if (resposta.contains('token')) {
            //Modular.get<AuthStore>().removeAcessToken();
          }
        }
        resposta = error.response!.data['message'] ?? '';
      }
      return Left(resposta);
    }
  }

  @override
  Future<bool> refreshToken() async {
    //final refreshToken = await _storage.read('refreshToken');
    final response = await httpClient
        .post('/auth/refresh', data: {'refreshToken': refreshToken});

    if (response.statusCode == 201) {
      //authStore.setAcessToken(response.data);
      return true;
    } else {
      // refresh token is wrong
      //authStore.removeAcessToken();
      //  _storage.deleteAll();
      return false;
    }
  }

  @override
  Future<Either<String, HttpClientResponse>> post(
      {required String endpoint, required Map<String, dynamic> body}) async {
    AuthStore authStore = Modular.get<AuthStore>();

    httpClient.options.headers['Authorization'] =
        'Bearer ${authStore.accessToken}';

    try {
      final response = await httpClient.post(
        endpoint,
        data: body,
      );

      return Right(HttpClientResponse(response.data));
    } on DioException catch (error) {
      String resposta = error.message ?? 'Alguma coisa aconteceu';
      if (error.response != null) {
        if (error.response!.statusCode == 500) {
          return Left('Erro interno do servidor');
        }

        resposta = error.message!;

        if (error.response!.statusCode == 403) {
          if (resposta.contains('token')) {
            Modular.get<AuthStore>().removeAcessToken();
            Modular.to.navigate('/auth');
          }
        }
        resposta = error.response!.data['message'] ?? '';
      }
      return Left(resposta);
    }
  }

  @override
  Future<Either<String, HttpClientResponse>> delete(String endpoint) async {
    AuthStore authStore = Modular.get<AuthStore>();

    httpClient.options.headers['Authorization'] =
        'Bearer ${authStore.accessToken}';

    try {
      final response = await httpClient.delete(endpoint);

      return Right(HttpClientResponse(response.data));
    } on DioException catch (error) {
      String resposta = error.message ?? 'Alguma coisa aconteceu';
      if (error.response != null) {
        if (error.response!.statusCode == 500) {
          return Left('Erro interno do servidor');
        }

        resposta = error.message!;

        if (error.response!.statusCode == 403) {
          if (resposta.contains('token')) {
            Modular.get<AuthStore>().removeAcessToken();
            Modular.to.navigate('/auth');
          }
        }
        resposta = error.response!.data['message'] ?? '';
      }
      return Left(resposta);
    }
  }
}
