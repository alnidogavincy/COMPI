import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/dummy_data.dart';
import '../../../data/models/component_model.dart';
import '../../core/app_colors.dart';
import '../../core/compi_widgets.dart';
import '../../providers/quiz_provider.dart';
import 'game_result_screen.dart';

class MatchUpScreen extends StatefulWidget {
  const MatchUpScreen({super.key});
  @override
  State<MatchUpScreen> createState() => _MatchUpScreenState();
}

class _MatchUpScreenState extends State<MatchUpScreen> {
  String? _selected;
  final Map<String, String> _answers = {};
  late final List<ComponentModel> _targets = [...dummyComponents.reversed];
  void _pair(String target) {
    if (_selected == null) return;
    setState(() {
      _answers.removeWhere((key, value) => value == target && key != _selected);
      _answers[_selected!] = target;
      _selected = null;
    });
  }

  void _submit() {
    final correct = dummyComponents.where((c) => _answers[c.id] == c.id).length;
    context.read<QuizProvider>().loadMatchResult(
      correct,
      dummyComponents.length,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const GameResultScreen()),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CircuitBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CompiHeader(
                title: 'Match the Component',
                onBack: () => Navigator.pop(context),
              ),
              const SectionBanner(
                icon: Icons.extension,
                title: 'Cocokkan Komponen',
              ),
              CompiPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pilih nama komponen, lalu ketuk fungsi yang sesuai.',
                      style: TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_answers.length} dari ${dummyComponents.length} pasangan dipilih',
                      style: const TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Komponen',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    dummyComponents
                        .map(
                          (c) => ChoiceChip(
                            avatar: Icon(_icon(c.id), size: 18),
                            label: Text(c.name),
                            selected: _selected == c.id,
                            selectedColor: AppColors.yellow,
                            onSelected: (_) => setState(() => _selected = c.id),
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 18),
              const Text(
                'Fungsi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              ..._targets.map((c) {
                final paired =
                    _answers.entries.where((e) => e.value == c.id).firstOrNull;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: InkWell(
                    onTap: _selected == null ? null : () => _pair(c.id),
                    child: CompiPanel(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              c.shortDescription,
                              style: const TextStyle(
                                color: AppColors.ink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            paired == null
                                ? Icons.add_circle_outline
                                : Icons.check_circle,
                            color:
                                paired == null
                                    ? AppColors.primary
                                    : AppColors.success,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              CompiButton(
                label: 'Kirim Jawaban',
                icon: Icons.send,
                onPressed:
                    _answers.length == dummyComponents.length ? _submit : null,
              ),
              TextButton(
                onPressed:
                    () => setState(() {
                      _answers.clear();
                      _selected = null;
                    }),
                child: const Text(
                  'Atur Ulang Pasangan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  IconData _icon(String id) => switch (id) {
    'cpu' => Icons.memory,
    'ram' => Icons.view_stream,
    'vga' => Icons.videogame_asset,
    _ => Icons.developer_board,
  };
}
