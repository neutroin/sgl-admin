// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgl_admin/screens/auth/loginScreen.dart';
import 'package:sgl_admin/screens/home/homeScreen.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(msg: 'Welcome!');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!.trim().toString());
    }
  }

  Future<void> logout(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: ((context) => const LoginScreen())));

    try {} on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }
}
