import 'dart:async';

import 'package:frontend/di/di.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class ErrorInterceptor extends Interceptor {
  final StreamController<DioError> errors = StreamController<DioError>.broadcast();

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    errors.add(err);
    DI.logger().e(err.response?.data);
    return handler.reject(err);
  }

  @disposeMethod
  void dispose() {
    errors.close();
  }
}
