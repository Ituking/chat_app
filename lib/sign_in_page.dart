import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInAnonymously() async {
    UserCredential userCredential = await _auth.signInAnonymously();
    if (kDebugMode) {
      print(userCredential);
    }
  }

  Future<void> createUserFromEmail(String email, String password) async {
    if (kDebugMode) {
      print("Completed user creation from Email");
    }
  }

  Future<void> signInFromEmail(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (kDebugMode) {
      print(userCredential.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                createUserFromEmail('email', 'password');
              },
              child: const Text("Create Account"),
            ),
            ElevatedButton(
              onPressed: () {
                signInFromEmail('email', 'password');
              },
              child: const Text("Login by Email"),
            ),
          ],
        ),
      ),
    );
  }
}
