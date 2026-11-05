import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config/legal_links.dart';
import '../../../core/config/subscription_config.dart';
import '../../../core/theme/aqua_theme.dart';
import '../../../core/theme/color_scheme.dart';
import '../../../core/widgets/aqua_widgets.dart';
import '../data/subscription_service.dart';
import 'controllers/subscription_providers.dart';

/// Why the paywall opened; tailors the headline
enum PaywallReason {
  general(
    'Unlock AquaLog Premium',
    'Everything you need to keep every tank thriving.',
  ),
  tankLimit(
    'Add more tanks with Premium',
    'Free accounts can track ${SubscriptionConfig.freeTankLimit} tanks. Premium has no limit.',
  ),
  aiLimit(
    "You've used today's free AI",
    'Free accounts get ${SubscriptionConfig.freeAiDailyLimit} AI requests a day. Premium gives you far more.',
  ),
  charts(
    'See your full water history',
    'Free accounts chart the last ${SubscriptionConfig.freeChartDays} days. Premium adds 90-day, 1-year and all-time trends, parameter overlays and CSV export.',
  );

  const PaywallReason(this.title, this.subtitle);

  final String title;
  final String subtitle;
}

/// Opens the paywall; resolves to true if the user is Premium afterwards
Future<bool> showPaywall(
  BuildContext context, {
  PaywallReason reason = PaywallReason.general,
}) async {
  final result = await Navigator.of(context).push<bool>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => AquaBackground(child: PaywallScreen(reason: reason)),
    ),
  );
  return result ?? false;
}

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({
    super.key,
    this.reason = PaywallReason.general,
    this.embedded = false,
  });

  final PaywallReason reason;

  /// Shown in place of gated content (see TankLimitGate): on success the
  /// gate swaps in the content, so the screen must not pop itself
  final bool embedded;

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  Package? _selected;
  bool _busy = false;
  String? _error;

  static const _benefits = [
    (
      Icons.auto_awesome_rounded,
      AquaHue.maintenance,
      'AI assistant & health checks',
      'Up to ${SubscriptionConfig.premiumAiDailyLimit} requests a day instead of ${SubscriptionConfig.freeAiDailyLimit}',
    ),
    (
      Icons.water_rounded,
      AquaHue.fish,
      'Unlimited tanks',
      'Track every aquarium, pond and quarantine tank',
    ),
    (
      Icons.insights_rounded,
      AquaHue.testing,
      'Advanced charts & export',
      'Full-history trends, parameter overlays and CSV export',
    ),
  ];

  List<Package> _plans(Offering offering) {
    final plans = [?offering.annual, ?offering.monthly];
    return plans.isNotEmpty ? plans : offering.availablePackages;
  }

  Future<void> _buy() async {
    final package = _selected;
    if (package == null) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final unlocked = await ref
          .read(subscriptionServiceProvider)
          .purchase(package);
      if (unlocked && mounted && !widget.embedded) {
        Navigator.pop(context, true);
      }
    } on PurchaseFailure catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _restore() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final unlocked = await ref.read(subscriptionServiceProvider).restore();
      if (!mounted) return;
      if (unlocked) {
        if (!widget.embedded) Navigator.pop(context, true);
      } else {
        setState(() => _error = 'No active Premium purchase was found.');
      }
    } on PurchaseFailure catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPremium = ref.watch(isPremiumProvider);
    final offering = ref.watch(currentOfferingProvider);
    final aqua = AquaTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          tooltip: 'Close',
          onPressed: () => Navigator.pop(context, isPremium),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
            Center(
              child: GradientIconTile(
                icon: Icons.workspace_premium_rounded,
                size: 84,
                gradient: aqua.accentGradient,
              ),
            ),
            const SizedBox(height: 20),
            GradientText(
              isPremium ? "You're Premium" : widget.reason.title,
              gradient: aqua.accentGradient,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isPremium
                  ? 'Thanks for supporting AquaLog. Everything is unlocked.'
                  : widget.reason.subtitle,
              style: textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Column(
                children: [
                  for (final (icon, hue, title, detail) in _benefits)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          GradientIconTile(icon: icon, color: hue, size: 40),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title, style: textTheme.titleSmall),
                                Text(
                                  detail,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (isPremium)
              _buildManage(context)
            else
              offering.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => _Notice(
                  'Could not load plans. Check your connection and try again.',
                  onRetry: () => ref.invalidate(currentOfferingProvider),
                ),
                data: (offering) {
                  if (offering == null) {
                    return const _Notice(
                      "Subscriptions aren't available in this build yet.",
                    );
                  }
                  final plans = _plans(offering);
                  _selected ??= plans.firstOrNull;
                  return _buildPlans(context, plans);
                },
              ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(color: aqua.danger),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlans(BuildContext context, List<Package> plans) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final selected = _selected;
    final trial = selected == null ? null : _trialLabel(selected);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final plan in plans)
          _PlanCard(
            package: plan,
            selected: plan == selected,
            trial: _trialLabel(plan),
            onTap: _busy ? null : () => setState(() => _selected = plan),
          ),
        const SizedBox(height: 8),
        GradientButton(
          label: _busy
              ? 'Please wait…'
              : trial != null
              ? 'Start $trial'
              : 'Continue',
          gradient: AquaTheme.of(context).accentGradient,
          expand: true,
          onPressed: _busy || selected == null ? null : _buy,
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: _busy ? null : _restore,
          child: const Text('Restore purchases'),
        ),
        Text(
          'Payment is charged to your store account. Subscriptions renew '
          'automatically unless cancelled at least 24 hours before the end of '
          'the period. Manage or cancel anytime in your store settings.',
          textAlign: TextAlign.center,
          style: textTheme.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        TextButton(
          onPressed: () => launchUrl(
            Uri.parse(LegalLinks.privacyPolicy),
            mode: LaunchMode.externalApplication,
          ),
          child: const Text('Privacy Policy'),
        ),
      ],
    );
  }

  Widget _buildManage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GradientButton(
          label: 'Done',
          gradient: AquaTheme.of(context).accentGradient,
          expand: true,
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }

  /// "7-day free trial" when the plan has a free introductory phase
  static String? _trialLabel(Package package) {
    final period = package.storeProduct.defaultOption?.freePhase?.billingPeriod;
    if (period != null)
      return '${_periodText(period.value, period.unit)} free trial';
    final intro = package.storeProduct.introductoryPrice;
    if (intro != null && intro.price == 0) {
      return '${_periodText(intro.periodNumberOfUnits, intro.periodUnit)} free trial';
    }
    return null;
  }

  static String _periodText(int value, PeriodUnit unit) {
    final name = switch (unit) {
      PeriodUnit.day => 'day',
      PeriodUnit.week => 'week',
      PeriodUnit.month => 'month',
      PeriodUnit.year => 'year',
      PeriodUnit.unknown => 'day',
    };
    return '$value-$name';
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.package,
    required this.selected,
    required this.trial,
    required this.onTap,
  });

  final Package package;
  final bool selected;
  final String? trial;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final product = package.storeProduct;
    final isAnnual = package.packageType == PackageType.annual;
    final accent = scheme.tertiary;

    final period = switch (package.packageType) {
      PackageType.annual => 'per year',
      PackageType.monthly => 'per month',
      PackageType.weekly => 'per week',
      PackageType.lifetime => 'one time',
      _ => '',
    };

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      glowColor: selected ? accent : null,
      borderColor: selected ? accent.withValues(alpha: 0.8) : null,
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            selected
                ? Icons.radio_button_checked_rounded
                : Icons.radio_button_off_rounded,
            color: selected ? accent : scheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      isAnnual ? 'Yearly' : 'Monthly',
                      style: textTheme.titleSmall,
                    ),
                    if (isAnnual) ...[
                      const SizedBox(width: 8),
                      StatusPill(label: 'Best value', color: aqua.healthy),
                    ],
                  ],
                ),
                if (isAnnual && product.pricePerMonthString != null)
                  Text(
                    '${product.pricePerMonthString} / month',
                    style: textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                if (trial != null)
                  Text(
                    trial!,
                    style: textTheme.bodySmall?.copyWith(color: aqua.healthy),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(product.priceString, style: textTheme.titleMedium),
              Text(
                period,
                style: textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice(this.message, {this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          Text(message, textAlign: TextAlign.center),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
    );
  }
}
