import 'package:flutter/material.dart';
import 'package:wonder_trip_travel_crm/core/theme/app_colors.dart';

class OnboardingStepWidget extends StatelessWidget {
  final String imagePath; // Usaremos imágenes de assets en el futuro
  final String title;
  final String description;

  const OnboardingStepWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder para la imagen
          Icon(Icons.phone_android, size: 150, color: AppColors.primaryLight.withOpacity(0.5)),
          const SizedBox(height: 48),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.fontTitleLight,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.fontBodyLight,
            ),
          ),
        ],
      ),
    );
  }
}