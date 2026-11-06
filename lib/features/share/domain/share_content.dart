/// What a share card is about; also used to tag installs from shares
enum ShareKind { tank, health, tip, milestone }

/// Links used on share cards and captions
class ShareLinks {
  ShareLinks._();

  static const String packageName = 'com.growdiom.aqualog';

  /// Play Store link tagged with an install referrer, so Play Console
  /// (Statistics → acquisition) shows how many installs each share type
  /// brought in
  static String playStore(ShareKind kind) {
    final referrer = Uri.encodeComponent(
      'utm_source=tankmind_share&utm_medium=social&utm_campaign=${kind.name}',
    );
    return 'https://play.google.com/store/apps/details'
        '?id=$packageName&referrer=$referrer';
  }

  /// Short form printed on the card image itself
  static const String display = 'Get TankMind on Google Play';
}

/// Plain text from the assistant's markdown, for quote cards
String plainTextFromMarkdown(String markdown) {
  String unwrap(String text, String pattern) =>
      text.replaceAllMapped(RegExp(pattern), (m) => m[1]!);

  var text = unwrap(markdown, r'\*\*(.+?)\*\*');
  text = unwrap(text, r'__(.+?)__');
  text = unwrap(text, r'(?<![\*\w])\*(?![\s\*])(.+?)\*');
  text = unwrap(text, r'`([^`]*)`');
  return text
      .replaceAll(RegExp(r'^#{1,6}\s*', multiLine: true), '')
      .replaceAll(RegExp(r'^[ \t]*[-*+][ \t]+', multiLine: true), '• ')
      .replaceAll(RegExp(r'\n{3,}'), '\n\n')
      .trim();
}

/// Shortens [text] to about [maxChars], ending on a word boundary with "…"
String excerpt(String text, int maxChars) {
  if (text.length <= maxChars) return text;
  final cut = text.substring(0, maxChars);
  final lastSpace = cut.lastIndexOf(RegExp(r'\s'));
  return '${(lastSpace > maxChars * 0.6 ? cut.substring(0, lastSpace) : cut).trimRight()}…';
}
