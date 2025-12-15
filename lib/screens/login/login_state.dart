import 'package:flutter/cupertino.dart';
import 'package:sticky_notes/storage/local_storage.dart';

class LoginState {
  GlobalKey<FormState>? formKey;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  LocalStorage? localStorage;

  LoginState() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    localStorage = LocalStorage();
  }
}