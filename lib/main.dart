import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sgl_admin/screens/auth/loginScreen.dart';
import 'package:sgl_admin/screens/home/homeScreen.dart';
import 'package:sgl_admin/screens/splash/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SGL-ADMIN',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: uid != null ? const SplashScreen() : const LoginScreen(),
    );
  }
}
