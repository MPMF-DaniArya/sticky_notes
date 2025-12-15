import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sticky_notes/screens/login/login_screen.dart';
import 'package:sticky_notes/storage/local_storage.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage localStorage;

  const AuthInterceptor(this.localStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const nonTokenPath = [
      '/api/login',
      '/api/canvas/notes/mobile'
    ];

    final isNonTokenPath = nonTokenPath.any(
      (path) => options.path.contains(path),
    );

    if (isNonTokenPath) {
      return handler.next(options);
    }

    try {
      final token = await localStorage.getUserToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      print('Error mengambil token dari interceptor: $e');
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      print('Token kedaluwarsa. Logout paksa...');

      await localStorage.deleteCurrentUserData();
      
      Get.offAll(const LoginScreen());

      Get.snackbar(
        'Session expired',
        'Your session expired, please login again!',
      );
    }
    super.onError(err, handler);
  }
}
