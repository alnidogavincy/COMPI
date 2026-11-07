import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../../core/app_colors.dart';

/// A single bundled model at a time, with a bounded loading indicator.
class HardwareModelViewer extends StatefulWidget {
  const HardwareModelViewer({super.key, required this.src, required this.name});
  final String src, name;
  @override
  State<HardwareModelViewer> createState() => _HardwareModelViewerState();
}

class _HardwareModelViewerState extends State<HardwareModelViewer> {
  Timer? _deadline;
  bool _loaded = false;
  String? _error;
  int _attempt = 0;

  @override
  void initState() {
    super.initState();
    _startDeadline();
  }

  void _startDeadline() {
    _deadline?.cancel();
    if (kIsWeb) return;
    _deadline = Timer(const Duration(seconds: 60), () {
      if (mounted && !_loaded) {
        setState(
          () =>
              _error =
                  'Model membutuhkan waktu lebih lama. Coba muat ulang atau perbarui Android System WebView.',
        );
      }
    });
  }

  void _receive(String message) {
    if (!mounted) return;
    if (message == 'loaded') {
      _deadline?.cancel();
      setState(() {
        _loaded = true;
        _error = null;
      });
    } else if (message == 'error') {
      _deadline?.cancel();
      setState(
        () =>
            _error =
                'Model 3D gagal dimuat. Coba lagi. Jika berulang, perbarui Android System WebView.',
      );
    }
  }

  @override
  void dispose() {
    _deadline?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Positioned.fill(
        child: ModelViewer(
          key: ValueKey(_attempt),
          src: widget.src,
          alt: 'Model 3D ${widget.name}',
          loading: Loading.eager,
          reveal: Reveal.auto,
          cameraControls: true,
          autoRotate: false,
          ar: false,
          interactionPrompt: InteractionPrompt.none,
          debugLogging: kDebugMode,
          backgroundColor: AppColors.primaryDark,
          javascriptChannels: {
            JavascriptChannel(
              'CompiModel',
              onMessageReceived: (message) => _receive(message.message),
            ),
          },
          relatedJs: """
        const viewer = document.querySelector('model-viewer');
        const report = (status) => {
          if (window.CompiModel) window.CompiModel.postMessage(status);
        };
        viewer.addEventListener('load', () => report('loaded'));
        viewer.addEventListener('error', () => report('error'));
        if (viewer.loaded) report('loaded');
      """,
        ),
      ),
      if (!kIsWeb && !_loaded && _error == null)
        const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(height: 8),
                  Text('Memuat model 3D...', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      if (_error != null)
        Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _attempt++;
                        _loaded = false;
                        _error = null;
                      });
                      _startDeadline();
                    },
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          ),
        ),
    ],
  );
}
