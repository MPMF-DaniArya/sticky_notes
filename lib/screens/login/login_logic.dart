import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sticky_notes/models/api/login_response.dart';
import 'package:sticky_notes/screens/login/login_state.dart';
import 'package:sticky_notes/screens/splash/splash_state.dart';
import 'package:sticky_notes/screens/test/kalau_login_screen.dart';
import 'package:sticky_notes/service/login_service.dart';
import 'package:sticky_notes/service/service.dart';

class LoginLogic extends GetxController {
  final box = GetStorage();
  final LoginState state = LoginState();
  final SplashState splashState = SplashState();
  var isLoading = false.obs;

  void doLogin() async {
    final isValid = state.formKey!.currentState!.validate();

    if (!isValid) {
      return;
    }

    state.formKey!.currentState!.save();

    try {
      isLoading.value = true;

      LoginResponse? result = await getService<LoginService>()?.doLogin(
          email: state.emailController!.text,
          password: state.passwordController!.text);

      if (result != null) {
        splashState.localStorage?.saveCurrentUserData(
            id: result.user!.id!,
            token: result.token!,
            email: result.user!.email!,
            name: result.user!.name!);
        await Future.delayed(Duration.zero);
        Get.snackbar('Sukses', 'Berhasil login');
        Get.to(const KalauLoginScreen());
      } else {
        await Future.delayed(Duration.zero);
        Get.snackbar('Info', result!.message!);
      }
    } catch (e) {
      print('Logic error: $e');
      await Future.delayed(Duration.zero);
      Get.snackbar('Error', 'Terjadi kesalahan sistem');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
