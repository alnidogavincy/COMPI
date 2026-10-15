import 'package:flutter/material.dart';

/// Keep the complete supplied composition visible at its original proportions.
class HardwareShowcase extends StatelessWidget {
  const HardwareShowcase({super.key});

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(18),
    child: AspectRatio(
      aspectRatio: 1672 / 941,
      child: Image.asset(
        'assets/images/hardware_showcase.png',
        fit: BoxFit.contain,
        semanticLabel: 'Komponen komputer: RAM, CPU, GPU, pendingin, dan SSD',
      ),
    ),
  );
}
