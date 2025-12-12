import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sticky_notes/screens/login/login_screen.dart';
import 'package:sticky_notes/screens/splash/splash_state.dart';
import 'package:sticky_notes/screens/test/kalau_login_screen.dart';

class SplashLogic extends GetxController {
  final box = GetStorage();
  final SplashState state = SplashState();

  Future<void> checkLoginAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    final isLogin = state.localStorage?.isUserLogin();

    if (isLogin == true) {
      Get.to(const KalauLoginScreen());
    } else {
      Get.to(const LoginScreen());
    }
  }
}
