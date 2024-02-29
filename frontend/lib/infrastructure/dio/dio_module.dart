import 'package:frontend/di/di.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import 'error_interceptor.dart';

@module
abstract class DioModule {
  @local
  @Named("BaseUrl")
  String get localBaseUrl => "http://10.0.2.2:8080";

  @dev
  @Named("BaseUrl")
  String get devBaseUrl => "https://booper-api-dev.azurewebsites.net/api";

  @prod
  @Named("BaseUrl")
  String get prodBaseUrl => "https://booper-api.azurewebsites.net/api";

  @singleton
  Dio dio(
    @Named('BaseUrl') String url,
    ErrorInterceptor error,
  ) {
    return Dio(
      BaseOptions(baseUrl: url),
    )..interceptors.addAll(
        [
          error,
        ],
      );
  }
}
