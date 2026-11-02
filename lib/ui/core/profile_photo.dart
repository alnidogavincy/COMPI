import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

/// Bound decoded memory and stored size while preserving the photo's ratio.
Future<Uint8List> prepareProfilePhoto(Uint8List bytes) async {
  if (bytes.length > 10 * 1024 * 1024) {
    throw const FormatException('Foto terlalu besar');
  }
  final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
  try {
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    try {
      final scale = math.min(
        1.0,
        384 / math.max(descriptor.width, descriptor.height),
      );
      final codec = await descriptor.instantiateCodec(
        targetWidth: math.max(1, (descriptor.width * scale).round()),
        targetHeight: math.max(1, (descriptor.height * scale).round()),
      );
      try {
        final frame = await codec.getNextFrame();
        try {
          final data = await frame.image.toByteData(
            format: ui.ImageByteFormat.png,
          );
          if (data == null) {
            throw const FormatException('Format foto tidak didukung');
          }
          return data.buffer.asUint8List(
            data.offsetInBytes,
            data.lengthInBytes,
          );
        } finally {
          frame.image.dispose();
        }
      } finally {
        codec.dispose();
      }
    } finally {
      descriptor.dispose();
    }
  } finally {
    buffer.dispose();
  }
}
