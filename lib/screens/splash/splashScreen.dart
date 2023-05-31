import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgl_admin/screens/auth/loginScreen.dart';

import '../home/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _navigateTo() async {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateTo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Image.asset('assets/images/SGL-SPLASH-SCREEN.gif')),
      ),
    );
  }
}
