import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/aqua_widgets.dart';
import '../../../router/aqua_page_route.dart';
import '../domain/share_content.dart';
import 'share_cards.dart';

/// Opens a preview of [card]; the Share button captures it as a 1080 x 1350
/// image and hands it to the system share sheet with [caption] and a
/// tracked Play Store link.
///
/// Returns true if the share sheet reported a share.
Future<bool> showSharePreview(
  BuildContext context, {
  required ShareKind kind,
  required Widget card,
  required String caption,
  List<String> precache = const [],
}) async {
  final shared = await Navigator.of(context).push<bool>(
    AquaPageRoute(
      fullscreenDialog: true,
      builder: (_) => SharePreviewScreen(
        kind: kind,
        card: card,
        caption: caption,
        precache: precache,
      ),
    ),
  );
  return shared ?? false;
}

class SharePreviewScreen extends StatefulWidget {
  const SharePreviewScreen({
    super.key,
    required this.kind,
    required this.card,
    required this.caption,
    this.precache = const [],
  });

  final ShareKind kind;
  final Widget card;
  final String caption;

  /// Image files the card shows; loaded before Share is enabled so the
  /// capture never contains a blank photo
  final List<String> precache;

  @override
  State<SharePreviewScreen> createState() => _SharePreviewScreenState();
}

class _SharePreviewScreenState extends State<SharePreviewScreen> {
  final _boundary = GlobalKey();
  bool _ready = false;
  bool _sharing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_ready) _warmUp();
  }

  Future<void> _warmUp() async {
    for (final path in widget.precache) {
      if (File(path).existsSync()) {
        await precacheImage(FileImage(File(path)), context);
      }
    }
    if (!mounted) return;
    await precacheImage(const AssetImage('app_icon.png'), context);
    // One more frame so fonts and images are laid out before capture
    await WidgetsBinding.instance.endOfFrame;
    if (mounted) setState(() => _ready = true);
  }

  Future<File> _capture() async {
    final boundary =
        _boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(
      pixelRatio: 1080 / kShareCardSize.width,
    );
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    final dir = await getTemporaryDirectory();
    final file = File(
      '${dir.path}/tankmind_${widget.kind.name}_'
      '${DateTime.now().millisecondsSinceEpoch}.png',
    );
    await file.writeAsBytes(bytes!.buffer.asUint8List());
    return file;
  }

  Future<void> _share() async {
    setState(() => _sharing = true);
    try {
      final file = await _capture();
      final origin = _shareOrigin();
      final result = await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'image/png')],
          text: '${widget.caption}\n\n${ShareLinks.playStore(widget.kind)}',
          sharePositionOrigin: origin,
        ),
      );
      if (mounted && result.status == ShareResultStatus.success) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not share: $e')));
      }
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  /// iPad needs an anchor for the share popover
  Rect? _shareOrigin() {
    final box = context.findRenderObject() as RenderBox?;
    return box == null ? null : box.localToGlobal(Offset.zero) & box.size;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Share'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          tooltip: 'Close',
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Center(
                  child: FittedBox(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.35),
                            blurRadius: 30,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: RepaintBoundary(
                          key: _boundary,
                          // Cards always use the dark brand look, whatever
                          // the app theme
                          child: Theme(
                            data: AppTheme.darkTheme,
                            child: Builder(builder: (_) => widget.card),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Column(
                children: [
                  Text(
                    'Share to Instagram, WhatsApp, Facebook and more. '
                    'Your post includes a link so friends can try TankMind.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GradientButton(
                    label: _sharing ? 'Preparing…' : 'Share',
                    icon: _sharing ? null : Icons.ios_share_rounded,
                    expand: true,
                    onPressed: _ready && !_sharing ? _share : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
