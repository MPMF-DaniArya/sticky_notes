import 'package:flutter/cupertino.dart';

class LoginState {
  GlobalKey<FormState>? formKey;
  TextEditingController? enteredEmail;
  TextEditingController? enteredPassword;

  LoginState() {
    formKey = GlobalKey<FormState>();
    enteredEmail = TextEditingController();
    enteredPassword = TextEditingController();
  }
}