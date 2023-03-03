import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home_screen.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  static const String routeName = "/auth";

  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
