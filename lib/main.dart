import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/core/app_theme.dart';
import 'ui/providers/learning_progress_provider.dart';
import 'ui/providers/quiz_provider.dart';
import 'ui/providers/student_provider.dart';
import 'ui/features/auth/splash_screen.dart';
import 'data/repositories/progress_repository.dart';
import 'data/repositories/content_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final progressRepository = ProgressRepository(prefs);
  final contentRepository = ContentRepository();
  final studentProvider = StudentProvider(prefs);

  runApp(
    CompiApp(
      progressRepository: progressRepository,
      contentRepository: contentRepository,
      studentProvider: studentProvider,
    ),
  );
}

class CompiApp extends StatelessWidget {
  final ProgressRepository progressRepository;
  final ContentRepository contentRepository;
  final StudentProvider? studentProvider;

  const CompiApp({
    super.key,
    required this.progressRepository,
    required this.contentRepository,
    this.studentProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ContentRepository>.value(value: contentRepository),
        ChangeNotifierProvider(
          create: (_) => LearningProgressProvider(progressRepository),
        ),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(
          create:
              (_) =>
                  studentProvider ??
                  StudentProvider(progressRepository.preferences),
        ),
      ],
      child: MaterialApp(
        title: 'COMPI',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
