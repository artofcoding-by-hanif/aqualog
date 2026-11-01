import 'package:flutter/material.dart';

import '../core/widgets/aqua_widgets.dart';

/// [MaterialPageRoute] that paints the ocean backdrop behind its page.
///
/// Scaffolds are transparent app-wide, so every route must draw its own
/// background; this keeps pages from showing through each other mid-transition.
class AquaPageRoute<T> extends MaterialPageRoute<T> {
  AquaPageRoute({
    required super.builder,
    super.settings,
    super.fullscreenDialog,
  });

  @override
  Widget buildContent(BuildContext context) {
    return AquaBackground(child: super.buildContent(context));
  }
}
