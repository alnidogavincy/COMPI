import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

/// Adds motion without replacing the child's keyboard/semantic/tap behavior.
class PhysicalButton extends StatefulWidget {
  const PhysicalButton({super.key, required this.child});
  final Widget child;
  @override
  State<PhysicalButton> createState() => _PhysicalButtonState();
}

class _PhysicalButtonState extends State<PhysicalButton> {
  bool _hover = false, _pressed = false;
  Offset? _down;
  bool get _enabled {
    final child = widget.child;
    if (child is ButtonStyleButton) return child.onPressed != null;
    if (child is IconButton) return child.onPressed != null;
    if (child is InkWell) return child.onTap != null;
    if (child is ChoiceChip) return child.onSelected != null;
    if (child is ListTile) return child.enabled && child.onTap != null;
    return true;
  }

  void _click() => context.read<AudioProvider?>()?.effect('puck');

  @override
  Widget build(BuildContext context) {
    final reduced = MediaQuery.disableAnimationsOf(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit:
          (_) => setState(() {
            _hover = false;
            _pressed = false;
          }),
      child: Focus(
        canRequestFocus: false,
        onKeyEvent: (_, event) {
          if (_enabled &&
              (event.logicalKey == LogicalKeyboardKey.enter ||
                  event.logicalKey == LogicalKeyboardKey.space)) {
            setState(() => _pressed = event is! KeyUpEvent);
            if (event is KeyUpEvent) _click();
          }
          return KeyEventResult.ignored;
        },
        child: Listener(
          onPointerDown: (e) {
            if (!_enabled) return;
            _down = e.position;
            setState(() => _pressed = true);
          },
          onPointerMove: (e) {
            if (_down != null && (e.position - _down!).distance > 12) {
              _down = null;
              setState(() => _pressed = false);
            }
          },
          onPointerCancel: (_) {
            _down = null;
            setState(() => _pressed = false);
          },
          onPointerUp: (_) {
            if (_down != null && _enabled) _click();
            _down = null;
            setState(() => _pressed = false);
          },
          child: AnimatedContainer(
            duration:
                reduced ? Duration.zero : const Duration(milliseconds: 140),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(
              0,
              reduced || !_enabled ? 0 : (_pressed ? 1 : (_hover ? -3 : 0)),
              0,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class SoundToggle extends StatelessWidget {
  const SoundToggle({super.key});
  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioProvider?>();
    if (audio == null) return const SizedBox.shrink();
    return PhysicalButton(
      child: IconButton.filled(
        tooltip:
            audio.error ?? (audio.enabled ? 'Matikan suara' : 'Nyalakan suara'),
        isSelected: audio.enabled,
        style: IconButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: const Size(48, 48),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        onPressed: audio.toggle,
        icon: const Icon(Icons.volume_off_rounded),
        selectedIcon: const Icon(Icons.volume_up_rounded),
      ),
    );
  }
}
