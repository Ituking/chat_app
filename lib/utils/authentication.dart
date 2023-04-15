import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;

  static Future<dynamic> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (kDebugMode) {
        print("Registration Completed.");
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("FAILED, $e");
      }
      return "Registration error.";
    }
  }
}
