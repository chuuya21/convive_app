
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:convive_app/screens/splashscreen.dart';
import 'package:convive_app/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAUl-jBGmBBxf_UPjKnEOCV4SSMTfYqs1c",
        authDomain: "convive-app-3ec38.firebaseapp.com",
        projectId: "convive-app-3ec38",
        storageBucket: "convive-app-3ec38.firebasestorage.app",
        messagingSenderId: "812873041446",
        appId: "1:812873041446:web:f4520f2f3f2d47084b88e7",
      ),
    );
  } on FirebaseException catch (e) {
    // Si la app ya estaba inicializada, ignora el error
    if (e.code != 'duplicate-app') rethrow;
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system,
  home: const SplashScreen(),
);

  }
}




