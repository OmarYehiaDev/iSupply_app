import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interceptor.dart';

part 'client_impl.dart';

abstract class DioClient {
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  static DioClient get instance => Modular.get();
}
