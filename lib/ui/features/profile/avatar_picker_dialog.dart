import 'package:flutter/material.dart';
import '../../../data/avatar_catalog.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';

class AvatarPickerDialog extends StatefulWidget {
  const AvatarPickerDialog({super.key, required this.currentId});
  final String currentId;
  @override
  State<AvatarPickerDialog> createState() => _AvatarPickerDialogState();
}

class _AvatarPickerDialogState extends State<AvatarPickerDialog> {
  late String _selected = widget.currentId;
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Pilih Avatar'),
    content: SizedBox(
      width: 320,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Pilih karakter untuk profil kamu.'),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: .8,
              children: [
                for (final option in avatarOptions)
                  Semantics(
                    selected: _selected == option.id,
                    child: PhysicalButton(
                      child: InkWell(
                        key: ValueKey(option.id),
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => setState(() => _selected = option.id),
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            _selected == option.id
                                                ? AppColors.primary
                                                : AppColors.border,
                                        width: 3,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        option.asset,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  if (_selected == option.id)
                                    const Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: AppColors.primary,
                                        child: Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              option.label,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            PhysicalButton(
              child: TextButton.icon(
                onPressed: () => setState(() => _selected = 'default'),
                icon: Icon(
                  _selected == 'default'
                      ? Icons.check_circle
                      : Icons.person_outline,
                ),
                label: const Text('Gunakan Avatar Default'),
              ),
            ),
          ],
        ),
      ),
    ),
    actions: [
      PhysicalButton(
        child: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
      ),
      PhysicalButton(
        child: FilledButton(
          onPressed: () => Navigator.pop(context, _selected),
          child: const Text('Simpan'),
        ),
      ),
    ],
  );
}
