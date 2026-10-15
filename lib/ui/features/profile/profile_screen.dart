import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/dummy_data.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../providers/learning_progress_provider.dart';
import '../../providers/student_provider.dart';
import '../auth/login_screen.dart';
import 'model_credits_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loggingOut = false;

  Future<void> _logout() async {
    setState(() => _loggingOut = true);
    try {
      await context.read<StudentProvider>().logout();
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (_) => false,
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _loggingOut = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal logout. Silakan coba lagi.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = context.watch<StudentProvider>();
    final progress = context.watch<LearningProgressProvider>();
    final total = dummyMaterials.length;
    return Scaffold(
      body: CircuitBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CompiHeader(
                  title: 'Profil & Progress',
                  onBack: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                CompiPanel(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        student.identity.isEmpty
                            ? 'Siswa COMPI'
                            : student.identity,
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text(
                        'Identitas tersimpan di perangkat',
                        style: TextStyle(color: AppColors.textGray),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                const SectionBanner(
                  icon: Icons.bar_chart,
                  title: 'Progress Belajar',
                ),
                CompiPanel(
                  child: Column(
                    children: [
                      Text(
                        '${progress.completedCount} dari $total materi selesai',
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value:
                            total == 0
                                ? 0
                                : (progress.completedCount / total).clamp(0, 1),
                        minHeight: 12,
                        color: AppColors.orange,
                        backgroundColor: AppColors.primaryLight,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Skor tertinggi: ${progress.highestScore}/100',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                if (progress.badges.isNotEmpty) ...[
                  const SizedBox(height: 18),
                  const SectionBanner(icon: Icons.emoji_events, title: 'Badge'),
                  CompiPanel(
                    child: Wrap(
                      spacing: 8,
                      children:
                          progress.badges
                              .map((b) => Chip(label: Text(b)))
                              .toList(),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                CompiButton(
                  label: 'Kredit Model 3D',
                  icon: Icons.attribution,
                  secondary: true,
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ModelCreditsScreen(),
                        ),
                      ),
                ),
                const SizedBox(height: 12),
                CompiButton(
                  label: 'Ubah Identitas',
                  icon: Icons.edit,
                  secondary: true,
                  onPressed: () async {
                    final controller = TextEditingController(
                      text: student.identity,
                    );
                    final value = await showDialog<String>(
                      context: context,
                      builder:
                          (dialogContext) => AlertDialog(
                            title: const Text('Identitas Siswa'),
                            content: TextField(
                              controller: controller,
                              autofocus: true,
                              decoration: const InputDecoration(
                                labelText: 'Nama atau NISN',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(dialogContext),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed:
                                    () => Navigator.pop(
                                      dialogContext,
                                      controller.text,
                                    ),
                                child: const Text('Simpan'),
                              ),
                            ],
                          ),
                    );
                    controller.dispose();
                    if (value != null &&
                        value.trim().isNotEmpty &&
                        context.mounted)
                      await student.save(value);
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _loggingOut ? null : _logout,
                  icon: const Icon(Icons.logout),
                  label: Text(_loggingOut ? 'Keluar...' : 'Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB91C1C),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
