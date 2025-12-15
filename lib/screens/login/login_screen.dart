import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky_notes/screens/login/login_logic.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(LoginLogic());
    final state = Get.find<LoginLogic>().state;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: state.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: state.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Inputan tidak valid';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: state.passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Inputan tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Obx(
                    () {
                      if (logic.isLoading.value) {
                        return const CircularProgressIndicator();
                      }

                      return ElevatedButton(
                          onPressed: logic.doLogin, child: const Text('Login'));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
