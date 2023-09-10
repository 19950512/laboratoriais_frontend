// ignore: file_names

// ignore_for_file: file_names, duplicate_ignore

import '../../either.dart';
import 'HttpClientResponse.dart';

abstract class IHttpClientServiceInterface {
  abstract final String baseUrl;
  Future<bool> downloadFile(String urlOfFile, String localToSaveInDevice);

  Future<Either<String, HttpClientResponse>> post(
      {required String endpoint, required Map<String, dynamic> body});

  Future<Either<String, HttpClientResponse>> get(String endpoint);

  Future<bool> refreshToken();

  Future<Either<String, HttpClientResponse>> delete(String endpoint);
}
