import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class AppInterceptors extends InterceptorsWrapper {
  final Box tokens = Hive.box('tokens');
  final Dio dio;

  AppInterceptors({ this.dio});

  @override
  Future onRequest(RequestOptions options) {
    String accessToken = tokens.get('access');
    if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';

    }

    return super.onRequest(options);
  }

  @override
  Future onError(DioError err) async {
    String refreshToken = tokens.get('refresh');
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      if (refreshToken != null) {
        final Response response =
            await dio.post('token/', data: {'refresh': refreshToken});
        if (response.statusCode == HttpStatus.unauthorized) {
          tokens.delete('refresh');
          tokens.delete('access');
        } else if (response.statusCode == HttpStatus.ok) {
          tokens.put('access', response.data['access']);
          tokens.put('refresh', response.data['refresh']);

          return dio.request(err.request.path, options: err.request);
        }
      }
    }
    return super.onError(err);
  }
}
