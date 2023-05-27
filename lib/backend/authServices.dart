import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(msg: 'Welcome!');
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!.trim().toString());
    }
  }
}
