import 'package:get/get.dart';
import 'package:sticky_notes/models/api/login_response.dart';
import 'package:sticky_notes/screens/login/login_state.dart';
import 'package:sticky_notes/service/login_service.dart';
import 'package:sticky_notes/service/service.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  var isLoading = false.obs;

  void doLogin({required String email, required String password}) async {
    try {
      isLoading.value = true;

      LoginResponse? result = await getService<LoginService>()
          ?.doLogin(email: email, password: password);

      if (result != null) {
        print('Token : ${result.token}');
        print('Token : ${result.user?.id}');
        print('Token : ${result.user?.name}');
        print('Token : ${result.user?.email}');
      } else {
        await Future.delayed(Duration.zero);
        Get.snackbar('Info', 'Terjadi kesalahan pada data response API');
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
