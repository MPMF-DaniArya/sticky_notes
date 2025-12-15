import 'package:dio/dio.dart';
import 'dart:io';

import 'package:dio/io.dart';
import 'package:sticky_notes/service/base_service.dart';
import 'package:sticky_notes/service/login_service.dart';
import 'package:sticky_notes/service/note_service.dart';

class Service {
  Dio? client;
  static late Service instance;

  Service();

  Service.setup(this.client) {
    instance = this;
    client?.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    });
  }

  Map<Type, BaseService> get classes {
    return {
      LoginService: LoginService.instance,
      NoteService: NoteService.instance
    };
  }

  static T? resolve<T extends BaseService?>() {
    if (instance.classes[T] == null) {
      throw '$T tidak diregistrasi. Periksa service!';
    }
    return instance.classes[T] as T?;
  }
}

T? getService<T extends BaseService>() {
  return Service.resolve<T>();
}
