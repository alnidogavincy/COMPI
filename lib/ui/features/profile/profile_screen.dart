import 'avatar_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../providers/learning_progress_provider.dart';
import '../../providers/student_provider.dart';
import '../auth/login_screen.dart';
import 'developer_identity_screen.dart';
import 'model_credits_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loggingOut = false;
  bool _savingAvatar = false;

  Future<void> _pickAvatar() async {
    setState(() => _savingAvatar = true);
    try {
      final student = context.read<StudentProvider>();
      final selected = await showDialog<String>(
        context: context,
        builder: (_) => AvatarPickerDialog(currentId: student.avatarId),
      );
      if (selected == null || !mounted) return;
      await student.saveAvatar(selected);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Avatar gagal disimpan. Silakan coba lagi.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _savingAvatar = false);
    }
  }

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
    return Scaffold(
      body: CircuitBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    PhysicalButton(
                      child: IconButton.filled(
                        onPressed: () => Navigator.pop(context),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.orange,
                        ),
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                    const Expanded(child: Center(child: ProfileWordmark())),
                    const SoundToggle(),
                  ],
                ),
                const SizedBox(height: 20),
                CompiPanel(
                  child: Column(
                    children: [
                      const StudentAvatar(radius: 40),
                      PhysicalButton(
                        child: TextButton.icon(
                          onPressed: _savingAvatar ? null : _pickAvatar,
                          icon: const Icon(Icons.face_retouching_natural),
                          label: Text(
                            _savingAvatar
                                ? 'Menyimpan avatar...'
                                : 'Ubah Avatar',
                          ),
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
                const SizedBox(height: 12),
                CompiButton(
                  label: 'Ubah Identitas',
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
                                labelText: 'Nama',
                              ),
                            ),
                            actions: [
                              PhysicalButton(
                                child: TextButton(
                                  onPressed: () => Navigator.pop(dialogContext),
                                  child: const Text('Batal'),
                                ),
                              ),
                              PhysicalButton(
                                child: TextButton(
                                  onPressed:
                                      () => Navigator.pop(
                                        dialogContext,
                                        controller.text,
                                      ),
                                  child: const Text('Simpan'),
                                ),
                              ),
                            ],
                          ),
                    );
                    controller.dispose();
                    if (value != null &&
                        value.trim().isNotEmpty &&
                        context.mounted) {
                      await student.save(value);
                    }
                  },
                ),
                const SizedBox(height: 12),
                CompiButton(
                  label: 'Identitas Pengembang',
                  secondary: true,
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DeveloperIdentityScreen(),
                        ),
                      ),
                ),
                const SizedBox(height: 12),
                CompiButton(
                  label: 'Kredit Model 3D',
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
                PhysicalButton(
                  child: ElevatedButton.icon(
                    onPressed: _loggingOut ? null : _logout,
                    icon: const Icon(Icons.logout),
                    label: Text(_loggingOut ? 'Keluar...' : 'Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB91C1C),
                      foregroundColor: Colors.white,
                    ),
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

/// Clip only transparent margins; retain the supplied PNG unchanged.
class ProfileWordmark extends StatelessWidget {
  const ProfileWordmark({super.key});
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 170,
    height: 76,
    child: FittedBox(
      child: ClipRect(
        child: Align(
          widthFactor: 1640 / 2048,
          heightFactor: 704 / 2048,
          alignment: const Alignment(32 / 408, 112 / 1344),
          child: Image.asset(
            'assets/images/profile_wordmark.png',
            width: 256,
            height: 256,
          ),
        ),
      ),
    ),
  );
}
