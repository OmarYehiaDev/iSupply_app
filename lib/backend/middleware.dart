import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:isupply/backend/endpoints.dart';
import 'package:isupply/utils/cache_service.dart';

import '../models/user_model.dart';

class ApiService {
  final CacheService _service = CacheService.getInstance();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.api,
      validateStatus: (status) => status! < 400,
      headers: {HttpHeaders.acceptHeader: ContentType.json.mimeType},
    ),
  );
  Future<Either<String?, MapEntry<String, String>>> loginOrRegister(String phone) async {
    return _basicErrorHandling(() async {
      final res = await _dio.post(
        Endpoints.loginRegister,
        data: {"phone_number": phone},
      );
      return res.data;
    });
  }

  Future<Either<String?, String>> resendOtp(String phone) async {
    return _basicErrorHandling(() async {
      final res = await _dio.post(
        Endpoints.resendOtp,
        data: {"phone_number": phone},
      );
      return res.data;
    });
  }

  Future<Either<String?, bool>> verifyOtp(String phone, String otp) async {
    return _basicErrorHandling(() async {
      final res = await _dio.post(
        Endpoints.resendOtp,
        data: {
          "phone_number": phone,
          "otp": otp,
        },
      );
      UserModel user = UserModel.fromJson(res.data);
      await _service.saveData(
        "user",
        jsonEncode(
          user.toJson(),
        ),
      );
      return await _service.saveData("token", user.token);
    });
  }
}

extension on ApiService {
  dynamic _onServerErrorBase(dynamic e, [StackTrace? st]) {
    if (e is DioError) {
      switch (e.type) {
        case DioErrorType.response:
          if (e.response == null) return;
          final errors = e.response!.data['errors'];

          String errorMessage = '';
          if (errors is String) {
            return errors;
          } else if (errors is Map<String, dynamic>) {
            if (!errors.containsKey("errors")) return errors["message"];
            errors.forEach((err, list) {
              list as List<dynamic>;
              errorMessage += list.join("");
              if (errors.length > 1) errorMessage += " | ";
            });
            return errorMessage;
          }
          break;
        default:
          return e.message;
      }
    }
    return e;
  }

  Future<Either<String?, T>> _basicErrorHandling<T>(
    Future<T> Function() apiRequest, {
    Future<String> Function<T>(T error)? onError,
  }) async {
    try {
      final f = await apiRequest();
      return Right(f);
    } catch (e, st) {
      if (onError != null) {
        final f = await onError(e);
        return Left(f);
      }
      final f = _onServerErrorBase(e, st);
      if (f is! String) {
        return const Left("Something went wrong");
      }

      return Left(f);
    }
  }
}
