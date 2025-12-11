import 'dart:convert';
import 'dart:io';
import 'package:sticky_notes/models/generator/generator.dart' as models;

import 'package:dio/dio.dart';

class ServiceLoggerInterceptor extends InterceptorsWrapper {
  JsonEncoder encoder = const JsonEncoder.withIndent(' ');
}

abstract class BaseService {
  static late Dio client;

  static initialize(Dio newClient) async {
    client = newClient;
  }

  Future<T?> post<T>(String url, {Map<String, dynamic>? body}) async {
    final response = await _wrapRequest(() => client.post(url, data: body));

    return models.ModelGenerator.resolve<T>(response.data);
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
