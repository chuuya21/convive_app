import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:convive_app/screens/home.dart';     // HomeScreen

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

        if (!mounted) return;

        if (user != null) {
          // Usuario no autenticado → a Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        } else {
          // Usuario autenticado → a Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  return Scaffold(
    backgroundColor: cs.primary, // Color fondo
    body: Center(
      child: Image.asset(
        'assets/img/splash_logo.png', // Imagen
        width: 110, // tamaño
        fit: BoxFit.contain,
      ),
    ),
  );
}


}
