import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppLoginFirebase{

  static Future signInWithFirebase(TextEditingController emailController,TextEditingController passwordController, FirebaseAuth auth ) async {
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    emailController.clear();
    passwordController.clear();
 

    return  userCredential.user!.uid;
  } catch (e) {
    if (e is FirebaseAuthException) {
    } else {
    }
  }
}
} 