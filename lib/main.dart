import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/providers/learning_progress_provider.dart';
import 'ui/providers/quiz_provider.dart';
import 'ui/features/auth/splash_screen.dart';

void main() {
  runApp(const CompiApp());
}

class CompiApp extends StatelessWidget {
  const CompiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LearningProgressProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: MaterialApp(
        title: 'COMPI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2954E3), // Warna biru utama mockup
            primary: const Color(0xFF2954E3),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: 'Roboto', // Default font
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Color(0xFFF8F9FA),
            foregroundColor: Color(0xFF1E293B),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

