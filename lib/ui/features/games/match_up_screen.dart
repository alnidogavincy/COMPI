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
                      'Seret setiap gambar ke nama komponen pilihanmu. Jawaban akan dikoreksi setelah dikirim.',
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
                  Expanded(flex: 2, child: _columnHeading('GAMBAR')),
                  const SizedBox(width: 12),
                  Expanded(flex: 3, child: _columnHeading('NAMA KOMPONEN')),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children:
                          _imageOptions.map((component) {
                            final isMatched = _answers.containsKey(
                              component.id,
                            );
                            final isCorrect =
                                isMatched &&
                                _answers[component.id] == component.id;
                            final imageWidth =
                                (MediaQuery.sizeOf(context).width - 44) * 0.4;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Draggable<String>(
                                key: ValueKey(
                                  'component-image-${component.id}',
                                ),
                                data: component.id,
                                maxSimultaneousDrags:
                                    _isSubmitted || isMatched ? 0 : 1,
                                feedback: Material(
                                  color: Colors.transparent,
                                  child: SizedBox(
                                    width: imageWidth,
                                    child: _imageCard(
                                      component,
                                      isMatched,
                                      isCorrect,
                                      _isSubmitted,
                                    ),
                                  ),
                                ),
                                childWhenDragging: Opacity(
                                  opacity: 0.35,
                                  child: _emptyImageSlot(component),
                                ),
                                child:
                                    isMatched
                                        ? _emptyImageSlot(component)
                                        : _imageCard(
                                          component,
                                          isMatched,
                                          isCorrect,
                                          _isSubmitted,
                                        ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children:
                          _nameOptions.map((component) {
                            final isMatched = _answers.containsValue(
                              component.id,
                            );
                            final assignedImage =
                                _answers.entries
                                    .where(
                                      (entry) => entry.value == component.id,
                                    )
                                    .firstOrNull
                                    ?.key;
                            final isCorrect = assignedImage == component.id;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _nameTarget(
                                component,
                                isMatched,
                                assignedImage == null
                                    ? null
                                    : dummyComponents.firstWhere(
                                      (image) => image.id == assignedImage,
                                    ),
                                isCorrect,
                              ),
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

  Widget _imageCard(
    ComponentModel component,
    bool isMatched,
    bool isCorrect,
    bool showResult,
  ) => CompiPanel(
    padding: const EdgeInsets.all(6),
    child: Container(
      height: 104,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color:
              showResult
                  ? isCorrect
                      ? AppColors.success
                      : AppColors.error
                  : isMatched
                  ? AppColors.primary
                  : AppColors.border,
          width: showResult || isMatched ? 3 : 1,
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
          if (showResult && isMatched)
            Positioned(
              top: 2,
              right: 2,
              child: Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? AppColors.success : AppColors.error,
                size: 20,
              ),
            ),
          if (isMatched && !showResult)
            const Positioned(
              top: 2,
              right: 2,
              child: Icon(Icons.link, color: AppColors.primary, size: 20),
            ),
        ],
      ),
    ),
  );

  Widget _emptyImageSlot(ComponentModel component) => CompiPanel(
    key: ValueKey('empty-source-${component.id}'),
    padding: const EdgeInsets.all(6),
    child: Container(
      height: 104,
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
    bool isMatched,
  ) => Draggable<String>(
    key: ValueKey('placed-image-drag-source-${target.id}'),
    data: image.id,
    maxSimultaneousDrags: _isSubmitted ? 0 : 1,
    feedback: Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 112,
        height: 124,
        child: _imageCard(image, isMatched, isCorrect, _isSubmitted),
      ),
    ),
    childWhenDragging: _emptyTargetSlot(target),
    child: Container(
      width: 82,
      height: 106,
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
        key: ValueKey('placed-image-${target.id}'),
        fit: BoxFit.contain,
        semanticLabel: 'Gambar ${image.name} ditempatkan pada ${target.name}',
      ),
    ),
  );

  Widget _emptyTargetSlot(ComponentModel component) => Container(
    key: ValueKey('empty-target-${component.id}'),
    width: 56,
    height: 64,
    padding: const EdgeInsets.all(4),
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
    bool isMatched,
    ComponentModel? assignedImage,
    bool isCorrect,
  ) => DragTarget<String>(
    key: ValueKey('match-target-${component.id}'),
    onWillAcceptWithDetails: (_) => !_isSubmitted,
    onAcceptWithDetails: (details) => _placeImage(details.data, component.id),
    builder: (context, candidates, rejected) {
      final isHovering = candidates.isNotEmpty;
      final resultColor =
          !isMatched
              ? AppColors.border
              : isCorrect
              ? AppColors.success
              : AppColors.error;
      return SizedBox(
        height: 122,
        child: CompiPanel(
          padding: const EdgeInsets.all(6),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  _isSubmitted && isMatched
                      ? resultColor.withValues(alpha: 0.12)
                      : isHovering
                      ? AppColors.primaryLight
                      : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color:
                    _isSubmitted && isMatched
                        ? resultColor
                        : isHovering
                        ? AppColors.primary
                        : AppColors.border,
                width: (_isSubmitted && isMatched) || isHovering ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 82,
                  height: 106,
                  child:
                      assignedImage == null
                          ? _emptyTargetSlot(component)
                          : Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color:
                                    _isSubmitted && isMatched
                                        ? resultColor
                                        : AppColors.border,
                              ),
                            ),
                            child: _placedImage(
                              component,
                              assignedImage,
                              isCorrect,
                              isMatched,
                            ),
                          ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        component.name,
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (!_isSubmitted)
                        Text(
                          assignedImage == null ? 'Belum diisi' : 'Terisi',
                          style: const TextStyle(
                            color: AppColors.textGray,
                            fontSize: 10,
                          ),
                        ),
                      if (_isSubmitted && assignedImage != null)
                        Text(
                          isCorrect ? 'Benar!' : 'Belum tepat',
                          style: TextStyle(
                            color:
                                isCorrect ? AppColors.success : AppColors.error,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    ],
                  ),
                ),
                if (_isSubmitted && isMatched)
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: resultColor,
                      size: 18,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
