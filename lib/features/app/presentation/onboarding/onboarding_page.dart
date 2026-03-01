import 'package:flutter/material.dart';

/// Onboarding page data model
class OnboardingPageData {
  final String title;
  final String description;
  final Widget illustration;

  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.illustration,
  });
}

/// Onboarding page widget
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.data});

  final OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Cartoon illustration
          data.illustration,
          const SizedBox(height: 48),
          Text(
            data.title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            data.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.outline,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
