import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sticky_notes/core/networking/auth_interceptor.dart';
import 'package:sticky_notes/screens/login/login_screen.dart';
import 'package:sticky_notes/screens/splash/splash_screen.dart';
import 'package:sticky_notes/service/base_service.dart';
import 'package:sticky_notes/service/service.dart';
import 'package:sticky_notes/storage/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  final localStorage = LocalStorage();

  final client = Dio(BaseOptions(
      baseUrl: 'https://humic.xtrahera.com',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60)));

  client.interceptors.add(AuthInterceptor(localStorage));

  client.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false));

  BaseService.initialize(client);
  Service.setup(client);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Latihan',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
