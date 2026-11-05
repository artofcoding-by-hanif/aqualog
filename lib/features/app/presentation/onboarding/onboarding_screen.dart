import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/settings/settings_provider.dart';
import '../../../../router/app_router.dart';
import 'onboarding_illustrations.dart';
import 'onboarding_page.dart';

/// Onboarding screen

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingPageData> get _pages => [
    OnboardingPageData(
      title: 'Welcome to TankMind',
      description:
          'Your all-in-one companion for aquarium care.\nSmarter care for healthier aquariums.',
      illustration: const WelcomeIllustration(),
    ),
    OnboardingPageData(
      title: 'Manage Your Tanks',
      description:
          'Track multiple aquariums with details about fish, plants, equipment, and more.',
      illustration: const TankManagementIllustration(),
    ),
    OnboardingPageData(
      title: 'Monitor Parameters',
      description:
          'Log water parameters and view trends to keep your aquatic friends healthy.',
      illustration: const MonitoringIllustration(),
    ),
    OnboardingPageData(
      title: 'Never Miss a Task',
      description:
          'Set reminders for water changes, feeding, and maintenance to stay on top of care.',
      illustration: const RemindersIllustration(),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    await ref.read(appSettingsProvider.notifier).setOnboardingCompleted(true);
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRouter.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(data: _pages[index]);
                },
              ),
            ),
            _buildIndicator(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    final isLastPage = _currentPage >= _pages.length - 1;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip button - hidden on last page
          isLastPage
              ? const SizedBox(width: 80)
              : TextButton(
                  onPressed: _completeOnboarding,
                  child: const Text('Skip'),
                ),
          FilledButton(
            onPressed: () {
              if (!isLastPage) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                _completeOnboarding();
              }
            },
            child: Text(isLastPage ? 'Get Started' : 'Next'),
          ),
        ],
      ),
    );
  }
}
