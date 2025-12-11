import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky_notes/screens/login/login_logic.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(LoginLogic());
    final state = Get.find<LoginLogic>().state;

    return const Placeholder();
  }
}
