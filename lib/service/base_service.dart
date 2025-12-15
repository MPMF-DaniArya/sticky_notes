import 'dart:convert';
import 'dart:io';
import 'package:sticky_notes/models/generator/generator.dart' as models;

import 'package:dio/dio.dart';
import 'package:sticky_notes/utils/app_exception.dart';

class ServiceLoggerInterceptor extends InterceptorsWrapper {
  JsonEncoder encoder = const JsonEncoder.withIndent(' ');
}

abstract class BaseService {
  static late Dio client;

  static initialize(Dio newClient) async {
    client = newClient;
  }

  dynamic _processResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;

      case 400:
      case 401:
      case 403:
      case 404:
      case 422:
        String errorMessage = 'Terjadi kesalahan';

        try {
          if (response.data is Map) {
            errorMessage = response.data['message'] ??
                response.data['error'] ??
                'Error ${response.statusCode}';
          }
        } catch (_) {}
        throw AppException(errorMessage);

      case 500:
      default:
        throw AppException('Server sedang bermasalah (${response.statusCode}');
    }
  }

  Future<T?> post<T>(String url, {Map<String, dynamic>? body}) async {
    try {
      final response = await _wrapRequest(() => client.post(url, data: body));

      var json = _processResponse(response);

      return models.ModelGenerator.resolve<T>(json);
    } on DioException catch (e) {
      if (e.response != null){
        _processResponse(e.response!);
      }
      throw AppException('Koneksi bermasalah: ${e.type}');
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<T?> get<T>(String url, {Map<String, dynamic>? queryParameters}) async {
    final response = await _wrapRequest(
        () => client.get(url, queryParameters: queryParameters));

    return models.ModelGenerator.resolve(response.data);
  }

  _wrapRequest(request, {int retryCount = 3}) async {
    try {
      return await request();
    } on DioException catch (e) {
      if (e.error is SocketException) {
        if (retryCount == 3) {
          rethrow;
        } else {
          await Future.delayed(const Duration(seconds: 1), () {
            print('retrying request');
          });
          return _wrapRequest(request, retryCount: retryCount + 1);
        }
      }
      rethrow;
    } on SocketException catch (e) {
      if (retryCount == 3) {
        rethrow;
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          print('retrying request');
        });
        return _wrapRequest(request, retryCount: retryCount + 1);
      }
    } catch (e) {
      rethrow;
    }
  }
}
