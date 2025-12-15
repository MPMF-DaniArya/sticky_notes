import 'package:get/get.dart';
import 'package:sticky_notes/screens/login/login_screen.dart';
import 'package:sticky_notes/screens/notes/notes_screen.dart';
import 'package:sticky_notes/screens/splash/splash_state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();

  Future<void> checkLoginAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    final isLogin = state.localStorage?.isUserLogin();

    if (isLogin == true) {
      Get.offAll(const NotesScreen());
    } else {
      Get.offAll(const LoginScreen());
    }
  }
}
