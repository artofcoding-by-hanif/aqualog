import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config/subscription_config.dart';
import '../../../core/theme/aqua_theme.dart';
import '../../../core/widgets/aqua_widgets.dart';
import '../data/subscription_service.dart';
import 'controllers/subscription_providers.dart';
import 'paywall_screen.dart';

/// Plan status at the top of Settings, with upgrade / manage / restore
class PremiumSettingsCard extends ConsumerWidget {
  const PremiumSettingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(isPremiumProvider);
    final service = ref.watch(subscriptionServiceProvider);
    final aqua = AquaTheme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GlassCard(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(18),
      glowColor: scheme.tertiary,
      borderColor: scheme.tertiary.withValues(alpha: 0.35),
      onTap: isPremium ? null : () => showPaywall(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GradientIconTile(
                icon: Icons.workspace_premium_rounded,
                size: 48,
                gradient: aqua.accentGradient,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(
                      isPremium ? 'TankMind Premium' : 'Free plan',
                      gradient: aqua.accentGradient,
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isPremium
                          ? 'Unlimited tanks and up to '
                                '${SubscriptionConfig.premiumAiDailyLimit} AI requests a day'
                          : '${SubscriptionConfig.freeTankLimit} tanks · '
                                '${SubscriptionConfig.freeAiDailyLimit} AI requests a day',
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (isPremium)
            OutlinedButton.icon(
              onPressed: () => _manage(context, service),
              icon: const Icon(Icons.open_in_new_rounded, size: 18),
              label: const Text('Manage subscription'),
            )
          else
            GradientButton(
              label: 'Upgrade to Premium',
              icon: Icons.workspace_premium_rounded,
              gradient: aqua.accentGradient,
              expand: true,
              onPressed: () => showPaywall(context),
            ),
          if (!isPremium && service.isAvailable)
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => _restore(context, service),
                child: const Text('Restore purchases'),
              ),
            ),
          if (kDebugMode) ...[
            const SizedBox(height: 4),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text('Simulate Premium (debug)'),
              subtitle: const Text('Test gated features without a purchase'),
              value: ref.watch(debugPremiumOverrideProvider),
              onChanged: (value) =>
                  ref.read(debugPremiumOverrideProvider.notifier).set(value),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _manage(
    BuildContext context,
    SubscriptionService service,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final url = await service.managementUrl();
    final launched =
        url != null &&
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    if (!launched) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Manage your subscription in Google Play or App Store settings.',
          ),
        ),
      );
    }
  }

  Future<void> _restore(
    BuildContext context,
    SubscriptionService service,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final unlocked = await service.restore();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            unlocked
                ? 'Premium restored'
                : 'No active Premium purchase was found',
          ),
        ),
      );
    } on PurchaseFailure catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
