import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky_notes/screens/splash/splash_logic.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final logic = Get.put(SplashLogic());
  final state = Get.find<SplashLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    logic.checkLoginAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
