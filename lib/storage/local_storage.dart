import 'dart:core';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final box = GetStorage();
  final secureStorage = const FlutterSecureStorage();

  Future<void> saveCurrentUserData(
      {required int id,
      required String token,
      required String email,
      required String name}) async {
    await secureStorage.write(key: 'user_token', value: token);
    box.write('user_id', id);
    box.write('user_email', email);
    box.write('user_name', name);
    box.write('user_login', true);
  }

  bool? isUserLogin() {
    return box.read('user_login');
  }

  Future<void> deleteCurrentUserData() async {
    await secureStorage.delete(key: 'use_token');
    box.remove('user_id');
    box.remove('user_email');
    box.remove('user_name');
    box.remove('user_login');
  }

  Future<String?> getUserToken() async {
    return await secureStorage.read(key: 'user_token');
  }

  int? getUserId() {
    return box.read('user_token');
  }

  int? getUserEmail() {
    return box.read('user_email');
  }

  int? getUserName() {
    return box.read('user_name');
  }
}
