import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/screens/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(()=>const AuthGate());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/background.png")
            )
          ),
        child: Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/logo.png"),
            const SizedBox(height: 40),
            Text("Welcome to Notes", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),),
            const SizedBox(height: 150),
          ],
        )),
      ),
    );
  }
}
