import 'package:chat_app/model/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static Account? myAccount;

  static Future<dynamic> signUp(String email, String password) async {
    try {
      UserCredential newAccount = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print("Registration Completed.");
      }
      return newAccount;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("FAILED, $e");
      }
      return false;
    }
  }

  static Future<dynamic> emailSignIn(String email, String password) async {
    try {
      final UserCredential result =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentFirebaseUser = result.user;
      if (kDebugMode) {
        print("Login Success.");
      }
      return result;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("FAILED, $e");
      }
      return false;
    }
  }

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  static Future<void> deleteAuth() async {
    await currentFirebaseUser!.delete();
  }
}
