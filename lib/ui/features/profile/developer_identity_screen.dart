import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';

const _developers = [
  _DeveloperProfile(
    name: '',
    npm: '',
    origin: '',
    address: '',
    socialMedia: '',
  ),
  _DeveloperProfile(
    name: '',
    npm: '',
    origin: '',
    address: '',
    socialMedia: '',
  ),
  _DeveloperProfile(
    name: '',
    npm: '',
    origin: '',
    address: '',
    socialMedia: '',
  ),
];

class _DeveloperProfile {
  final String name;
  final String npm;
  final String origin;
  final String address;
  final String socialMedia;
  final String? photoPath;

  const _DeveloperProfile({
    required this.name,
    required this.npm,
    required this.origin,
    required this.address,
    required this.socialMedia,
    this.photoPath,
  });
}

class DeveloperIdentityScreen extends StatelessWidget {
  const DeveloperIdentityScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CircuitBackground(
      child: SafeArea(
        child: Column(
          children: [
            CompiHeader(
              title: 'Identitas Pengembang',
              onBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Column(
                  children: [
                    for (final developer in _developers) ...[
                      _DeveloperCard(developer: developer),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _DeveloperCard extends StatelessWidget {
  final _DeveloperProfile developer;

  const _DeveloperCard({required this.developer});

  String _value(String value) => value.isEmpty ? 'Belum diisi' : value;

  @override
  Widget build(BuildContext context) => CompiPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.primaryLight,
              backgroundImage:
                  developer.photoPath == null
                      ? null
                      : AssetImage(developer.photoPath!),
              child:
                  developer.photoPath == null
                      ? const Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 36,
                      )
                      : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                developer.name.isEmpty ? 'Nama belum diisi' : developer.name,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 24),
        _DeveloperInfoRow(label: 'NPM', value: _value(developer.npm)),
        const SizedBox(height: 8),
        const _DeveloperInfoRow(
          label: 'Pendidikan',
          value: 'S1 Pendidikan Teknologi Informasi',
        ),
        const SizedBox(height: 4),
        const _DeveloperInfoRow(
          label: 'Universitas',
          value: 'Universitas Lampung',
        ),
        const SizedBox(height: 8),
        _DeveloperInfoRow(label: 'Asal', value: _value(developer.origin)),
        const SizedBox(height: 8),
        _DeveloperInfoRow(label: 'Alamat', value: _value(developer.address)),
        const SizedBox(height: 8),
        _DeveloperInfoRow(
          label: 'Media Sosial',
          value: _value(developer.socialMedia),
        ),
      ],
    ),
  );
}

class _DeveloperInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _DeveloperInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 94,
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.textGray,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const Text(': ', style: TextStyle(color: AppColors.ink)),
      Expanded(
        child: Text(value, style: const TextStyle(color: AppColors.ink)),
      ),
    ],
  );
}
