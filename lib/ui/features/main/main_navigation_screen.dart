import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../home/home_screen.dart';
import '../library/library_screen.dart';
import '../games/games_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});
  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _index = 0;
  final _screens = const [HomeScreen(), LibraryScreen(), GamesScreen()];
  @override
  Widget build(BuildContext context) {
    final reducedMotion = MediaQuery.disableAnimationsOf(context);
    final duration = Duration(milliseconds: reducedMotion ? 0 : 320);
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                height: 76,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .62),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .8),
                    width: 1.5,
                  ),
                ),
                child: LayoutBuilder(
                  builder:
                      (context, constraints) => Stack(
                        children: [
                          AnimatedAlign(
                            duration: duration,
                            curve: Curves.easeOutCubic,
                            alignment: Alignment(_index - 1.0, 0),
                            child: Container(
                              width: constraints.maxWidth / 3,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withValues(alpha: .75),
                                    AppColors.cyan.withValues(alpha: .32),
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: .18,
                                    ),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              _tab(0, Icons.home_rounded, 'Beranda', duration),
                              _tab(
                                1,
                                Icons.menu_book_rounded,
                                'Materi',
                                duration,
                              ),
                              _tab(
                                2,
                                Icons.sports_esports_rounded,
                                'Praktik',
                                duration,
                              ),
                            ],
                          ),
                        ],
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tab(int index, IconData icon, String label, Duration duration) =>
      Expanded(
        child: Semantics(
          selected: _index == index,
          button: true,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => setState(() => _index = index),
              child: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedScale(
                      scale: _index == index ? 1.12 : 1,
                      duration: duration,
                      child: Icon(icon, color: AppColors.primaryDark),
                    ),
                    Text(
                      label,
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
