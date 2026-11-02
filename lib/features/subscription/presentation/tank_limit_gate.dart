import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/subscription_config.dart';
import '../../tank/presentation/controllers/tank_provider.dart';
import 'controllers/subscription_providers.dart';
import 'paywall_screen.dart';

/// Shows [child] (the new-tank form) unless a free user is at the tank limit,
/// in which case the paywall is shown in its place.
///
/// The decision is made once, when the screen opens: saving the tank that
/// reaches the limit must not swap the form for the paywall mid-save.
/// Existing tanks above the limit are never removed.
class TankLimitGate extends ConsumerStatefulWidget {
  const TankLimitGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<TankLimitGate> createState() => _TankLimitGateState();
}

class _TankLimitGateState extends ConsumerState<TankLimitGate> {
  bool? _allowed;

  @override
  Widget build(BuildContext context) {
    final isPremium = ref.watch(isPremiumProvider);
    final tankCount = ref.watch(tanksStreamProvider).value?.length;

    // Upgrading from the embedded paywall unlocks the form right away
    if (isPremium) _allowed = true;
    _allowed ??= tankCount == null
        ? null
        : tankCount < SubscriptionConfig.freeTankLimit;

    return switch (_allowed) {
      true => widget.child,
      false => const PaywallScreen(
        reason: PaywallReason.tankLimit,
        embedded: true,
      ),
      null => const Scaffold(body: Center(child: CircularProgressIndicator())),
    };
  }
}
