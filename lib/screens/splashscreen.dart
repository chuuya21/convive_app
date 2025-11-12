import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:convive_app/main.dart';     // HomScreen
import 'package:convive_app/screens/login.dart'; // LoginScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => opacity = 0.0);

      Future.delayed(const Duration(milliseconds: 500), () {
        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Usuario autenticado → a Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        } else {
          // No autenticado → a Login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  return Scaffold(
    backgroundColor: cs.primary, // solid background color (theme primary)
    body: Center(
      child: Image.asset(
        'assets/img/splash_logo.png', // your logo file
        width: 140, // adjust as needed
        fit: BoxFit.contain,
      ),
    ),
  );
}


}
