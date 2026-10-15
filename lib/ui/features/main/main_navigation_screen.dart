import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
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
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: _index, children: _screens),
    bottomNavigationBar: Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryDark,
        border: Border(top: BorderSide(color: AppColors.yellow, width: 4)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 4),
          child: CompiPanel(
            padding: const EdgeInsets.all(3),
            child: Row(
              children: [
                _tab(0, Icons.home_rounded, 'Beranda'),
                _tab(1, Icons.menu_book_rounded, 'Materi'),
                _tab(2, Icons.sports_esports_rounded, 'Praktik'),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  Widget _tab(int index, IconData icon, String label) => Expanded(
    child: InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => setState(() => _index = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          gradient:
              _index == index
                  ? const LinearGradient(
                    colors: [AppColors.cyan, AppColors.primary],
                  )
                  : null,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _index == index ? Colors.white : AppColors.primaryDark,
            ),
            Text(
              label,
              style: TextStyle(
                color: _index == index ? Colors.white : AppColors.primaryDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
