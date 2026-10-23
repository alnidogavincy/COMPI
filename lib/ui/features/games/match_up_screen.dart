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
  final Map<String, String> _answers = {};
  late final List<ComponentModel> _imageOptions;
  late final List<ComponentModel> _nameOptions;
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _imageOptions = [...dummyComponents]..shuffle();
    _nameOptions = [...dummyComponents]..shuffle();
    if (_imageOptions.length > 1 &&
        List.generate(
          _imageOptions.length,
          (index) => _imageOptions[index].id == _nameOptions[index].id,
        ).every((samePosition) => samePosition)) {
      _nameOptions.add(_nameOptions.removeAt(0));
    }
  }

  void _placeImage(String imageId, String nameId) {
    if (_isSubmitted || _answers[imageId] == nameId) return;
    setState(() {
      final sourceNameId = _answers[imageId];
      final displacedImageId =
          _answers.entries
              .where((entry) => entry.value == nameId)
              .firstOrNull
              ?.key;

      _answers.remove(imageId);
      if (displacedImageId != null) _answers.remove(displacedImageId);
      _answers[imageId] = nameId;
      if (displacedImageId != null && sourceNameId != null) {
        _answers[displacedImageId] = sourceNameId;
      }
    });
  }

  void _submit() {
    final correct =
        _answers.entries.where((entry) => entry.key == entry.value).length;
    context.read<QuizProvider>().loadMatchResult(
      correct,
      dummyComponents.length,
    );
    setState(() => _isSubmitted = true);
  }

  void _viewResults() {
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
                      'Seret gambar ke nama komponen yang sesuai. Jawaban dikoreksi setelah dikirim.',
                      style: TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isSubmitted
                          ? '${_answers.entries.where((entry) => entry.key == entry.value).length} dari ${dummyComponents.length} jawaban benar'
                          : '${_answers.length} dari ${dummyComponents.length} gambar ditempatkan',
                      style: const TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _columnHeading('GAMBAR')),
                  const SizedBox(width: 12),
                  Expanded(child: _columnHeading('NAMA KOMPONEN')),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children:
                          _imageOptions.map((component) {
                            final isPlaced = _answers.containsKey(component.id);
                            final isCorrect =
                                isPlaced &&
                                _answers[component.id] == component.id;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Draggable<String>(
                                key: ValueKey(
                                  'component-image-${component.id}',
                                ),
                                data: component.id,
                                maxSimultaneousDrags:
                                    _isSubmitted || isPlaced ? 0 : 1,
                                feedback: Material(
                                  color: Colors.transparent,
                                  child: SizedBox(
                                    width:
                                        (MediaQuery.sizeOf(context).width -
                                            44) /
                                        2,
                                    child: _imageCard(
                                      component,
                                      isPlaced,
                                      isCorrect,
                                    ),
                                  ),
                                ),
                                childWhenDragging: _emptyImageSlot(component),
                                child:
                                    isPlaced
                                        ? _emptyImageSlot(component)
                                        : _imageCard(
                                          component,
                                          isPlaced,
                                          isCorrect,
                                        ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children:
                          _nameOptions.map((component) {
                            final imageId =
                                _answers.entries
                                    .where(
                                      (entry) => entry.value == component.id,
                                    )
                                    .firstOrNull
                                    ?.key;
                            final image =
                                imageId == null
                                    ? null
                                    : _imageOptions.firstWhere(
                                      (option) => option.id == imageId,
                                    );
                            final isCorrect = imageId == component.id;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _nameTarget(component, image, isCorrect),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CompiButton(
                label: _isSubmitted ? 'Lihat Hasil' : 'Kirim Jawaban',
                icon: _isSubmitted ? Icons.emoji_events : Icons.send,
                onPressed:
                    _answers.length != dummyComponents.length
                        ? null
                        : _isSubmitted
                        ? _viewResults
                        : _submit,
              ),
              if (!_isSubmitted)
                TextButton(
                  onPressed: () => setState(_answers.clear),
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

  Widget _columnHeading(String label) => Text(
    label,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: AppColors.yellow,
      fontSize: 13,
      fontWeight: FontWeight.w700,
    ),
  );

  Widget _imageCard(ComponentModel component, bool isPlaced, bool isCorrect) =>
      CompiPanel(
        padding: const EdgeInsets.all(6),
        child: Container(
          height: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color:
                  _isSubmitted
                      ? isCorrect
                          ? AppColors.success
                          : AppColors.error
                      : AppColors.border,
              width: _isSubmitted ? 3 : 1,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    component.imagePath,
                    fit: BoxFit.contain,
                    semanticLabel: 'Gambar ${component.name} untuk diseret',
                  ),
                ),
              ),
              if (_isSubmitted && isPlaced)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: isCorrect ? AppColors.success : AppColors.error,
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
      );

  Widget _emptyImageSlot(ComponentModel component) => CompiPanel(
    key: ValueKey('empty-source-${component.id}'),
    padding: const EdgeInsets.all(6),
    child: Container(
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: const Icon(Icons.open_with, color: AppColors.primary, size: 28),
    ),
  );

  Widget _placedImage(
    ComponentModel target,
    ComponentModel image,
    bool isCorrect,
  ) => Draggable<String>(
    key: ValueKey('placed-image-drag-source-${target.id}'),
    data: image.id,
    maxSimultaneousDrags: _isSubmitted ? 0 : 1,
    feedback: Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 112,
        height: 132,
        child: _imageCard(image, true, isCorrect),
      ),
    ),
    childWhenDragging: _emptyTargetSlot(target),
    child: Container(
      key: ValueKey('placed-image-${target.id}'),
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:
              _isSubmitted
                  ? isCorrect
                      ? AppColors.success
                      : AppColors.error
                  : AppColors.border,
          width: _isSubmitted ? 2 : 1,
        ),
      ),
      child: Image.asset(
        image.imagePath,
        fit: BoxFit.contain,
        semanticLabel: 'Gambar ${image.name} ditempatkan pada ${target.name}',
      ),
    ),
  );

  Widget _emptyTargetSlot(ComponentModel component) => Container(
    key: ValueKey('empty-target-${component.id}'),
    height: 80,
    width: double.infinity,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.border),
    ),
    child: const Icon(
      Icons.add_photo_alternate_outlined,
      color: AppColors.primary,
      size: 28,
    ),
  );

  Widget _nameTarget(
    ComponentModel component,
    ComponentModel? image,
    bool isCorrect,
  ) => DragTarget<String>(
    key: ValueKey('match-target-${component.id}'),
    onWillAcceptWithDetails: (_) => !_isSubmitted,
    onAcceptWithDetails: (details) => _placeImage(details.data, component.id),
    builder: (context, candidates, rejected) {
      final isHovering = candidates.isNotEmpty;
      final hasImage = image != null;
      final resultColor = isCorrect ? AppColors.success : AppColors.error;
      return CompiPanel(
        key: ValueKey('answer-card-${component.id}'),
        padding: const EdgeInsets.all(6),
        child: Container(
          height: 150,
          width: double.infinity,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color:
                _isSubmitted && hasImage
                    ? resultColor.withValues(alpha: 0.12)
                    : isHovering
                    ? AppColors.primaryLight
                    : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color:
                  _isSubmitted && hasImage
                      ? resultColor
                      : isHovering
                      ? AppColors.primary
                      : AppColors.border,
              width: (_isSubmitted && hasImage) || isHovering ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child:
                    hasImage
                        ? _placedImage(component, image, isCorrect)
                        : _emptyTargetSlot(component),
              ),
              const SizedBox(height: 5),
              Text(
                component.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (_isSubmitted && hasImage)
                Text(
                  isCorrect ? 'Benar!' : 'Belum tepat',
                  style: TextStyle(
                    color: isCorrect ? AppColors.success : AppColors.error,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}
