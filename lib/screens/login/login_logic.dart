import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky_notes/core/exceptions/app_exception.dart';
import 'package:sticky_notes/models/api/login_response.dart';
import 'package:sticky_notes/screens/login/login_state.dart';
import 'package:sticky_notes/screens/notes/notes_screen.dart';
import 'package:sticky_notes/service/login_service.dart';
import 'package:sticky_notes/service/service.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  var isLoading = false.obs;

  void doLogin() async {
    final isValid = state.formKey!.currentState!.validate();

    if (!isValid) {
      return;
    }

    state.formKey!.currentState!.save();

    if (isLoading.value) return;

    try {
      isLoading.value = true;

      LoginResponse? result = await getService<LoginService>()?.doLogin(
          email: state.emailController!.text,
          password: state.passwordController!.text);

      if (result != null) {
        state.localStorage?.saveCurrentUserData(
            id: result.user!.id!,
            token: result.token!,
            email: result.user!.email!,
            name: result.user!.name!);
        await Future.delayed(Duration.zero);
        Get.offAll(const NotesScreen());
        Get.snackbar('Sukses', 'Berhasil login');
      }
    } on AppException catch (e) {
      await Future.delayed(Duration.zero);
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      await Future.delayed(Duration.zero);
      print(e);
      Get.snackbar('Error', 'Terjadi kesalahan aplikasi');
    } finally {
      isLoading.value = false;
    }
  }
}
