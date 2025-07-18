import 'package:berty1/btnnavigationbar.dart';
import 'package:berty1/start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            print(
                "User logged in: ${FirebaseAuth.instance.currentUser?.email}");

            if (snapshot.hasData) {
              return Btnnavigationbar();
            } else {
              return Start();
            }
          }),
    );
  }
}
