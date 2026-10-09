import 'package:flutter/material.dart';
import '../../data/models/component_model.dart';
import 'app_colors.dart';

/// Lightweight illustrations for lists; real GLB rendering stays in Explore 3D.
class HardwareImage extends StatelessWidget {
  final ComponentModel component;
  final double? height;
  const HardwareImage({super.key, required this.component, this.height});

  @override
  Widget build(BuildContext context) => Image.asset(
    component.imagePath,
    width: double.infinity,
    height: height,
    fit: BoxFit.cover,
    semanticLabel: 'Ilustrasi ${component.name}',
    cacheWidth: 900,
    errorBuilder:
        (_, error, stack) => Container(
          height: height ?? 140,
          color: AppColors.primary,
          alignment: Alignment.center,
          child: Text(
            component.name,
            style: const TextStyle(color: Colors.white),
          ),
        ),
  );
}
