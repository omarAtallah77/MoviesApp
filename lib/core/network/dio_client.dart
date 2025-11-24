import 'package:dio/dio.dart';

import '../utils/constants.dart';

class DioClient {
  final Dio _dio = Dio(BaseOptions(baseUrl: TMDB_BASE_URL));

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    final q = {'api_key': TMDB_API_KEY, ...?queryParameters};
    return _dio.get(path, queryParameters: q);
  }
}
