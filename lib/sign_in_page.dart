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

  Future<void> createUserFromEmail() async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: "test@test.com",
      password: "testtest",
    );
    if (kDebugMode) {
      print("Completed user creation from Email");
    }
  }

  Future<void> signInFromEmail() async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: "test@test.com",
      password: "testtest",
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
                createUserFromEmail();
              },
              child: const Text("Create Account"),
            ),
            ElevatedButton(
              onPressed: () {
                signInFromEmail();
              },
              child: const Text("Email Login"),
            ),
          ],
        ),
      ),
    );
  }
}
