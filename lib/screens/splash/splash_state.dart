import 'package:sticky_notes/storage/local_storage.dart';

class SplashState {
  LocalStorage? localStorage;

  SplashState() {
    localStorage = LocalStorage();
  }
}