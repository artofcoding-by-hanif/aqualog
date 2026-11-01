import '../../../core/theme/aqua_theme.dart';

/// Overall condition reported by the AI health check
enum TankHealthStatus {
  healthy('Healthy', AquaStatus.healthy),
  attention('Needs attention', AquaStatus.caution),
  critical('Critical', AquaStatus.danger);

  const TankHealthStatus(this.label, this.aquaStatus);

  final String label;
  final AquaStatus aquaStatus;

  static TankHealthStatus parse(Object? value) => TankHealthStatus.values
      .firstWhere((s) => s.name == value, orElse: () => attention);
}

enum FindingSeverity {
  good(AquaStatus.healthy),
  info(AquaStatus.neutral),
  warning(AquaStatus.caution),
  critical(AquaStatus.danger);

  const FindingSeverity(this.aquaStatus);

  final AquaStatus aquaStatus;

  static FindingSeverity parse(Object? value) => FindingSeverity.values
      .firstWhere((s) => s.name == value, orElse: () => info);
}

enum ActionPriority {
  now('Do now'),
  soon('This week'),
  routine('Routine');

  const ActionPriority(this.label);

  final String label;

  static ActionPriority parse(Object? value) => ActionPriority.values
      .firstWhere((p) => p.name == value, orElse: () => routine);
}

class AnalysisFinding {
  const AnalysisFinding({
    required this.title,
    required this.severity,
    required this.detail,
  });

  final String title;
  final FindingSeverity severity;
  final String detail;

  factory AnalysisFinding.fromJson(Map<String, dynamic> json) =>
      AnalysisFinding(
        title: json['title'] as String? ?? '',
        severity: FindingSeverity.parse(json['severity']),
        detail: json['detail'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    'title': title,
    'severity': severity.name,
    'detail': detail,
  };
}

class AnalysisAction {
  const AnalysisAction({
    required this.title,
    required this.detail,
    required this.priority,
  });

  final String title;
  final String detail;
  final ActionPriority priority;

  factory AnalysisAction.fromJson(Map<String, dynamic> json) => AnalysisAction(
    title: json['title'] as String? ?? '',
    detail: json['detail'] as String? ?? '',
    priority: ActionPriority.parse(json['priority']),
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'detail': detail,
    'priority': priority.name,
  };
}

/// Result of the AI health check for one tank
class TankAnalysis {
  const TankAnalysis({
    required this.status,
    required this.score,
    required this.headline,
    required this.summary,
    required this.findings,
    required this.actions,
    required this.createdAt,
  });

  final TankHealthStatus status;
  final int score;
  final String headline;
  final String summary;
  final List<AnalysisFinding> findings;
  final List<AnalysisAction> actions;
  final DateTime createdAt;

  factory TankAnalysis.fromJson(
    Map<String, dynamic> json, {
    DateTime? createdAt,
  }) {
    List<Map<String, dynamic>> list(String key) =>
        (json[key] as List? ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

    return TankAnalysis(
      status: TankHealthStatus.parse(json['status']),
      score: ((json['score'] as num?) ?? 0).round().clamp(0, 100),
      headline: json['headline'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      findings: list('findings').map(AnalysisFinding.fromJson).toList(),
      actions: list('actions').map(AnalysisAction.fromJson).toList()
        ..sort((a, b) => a.priority.index.compareTo(b.priority.index)),
      createdAt:
          createdAt ??
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status.name,
    'score': score,
    'headline': headline,
    'summary': summary,
    'findings': findings.map((f) => f.toJson()).toList(),
    'actions': actions.map((a) => a.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
  };
}
