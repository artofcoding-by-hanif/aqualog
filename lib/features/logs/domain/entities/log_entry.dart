/// Log entry entity

class LogEntry {
  final String id;
  final String tankId;
  final String
  type; // waterChange, feeding, maintenance, observation, treatment
  final String title;
  final String? description;
  final Map<String, dynamic>? metadata;
  final List<String>? images;
  final DateTime createdAt;

  const LogEntry({
    required this.id,
    required this.tankId,
    required this.type,
    required this.title,
    this.description,
    this.metadata,
    this.images,
    required this.createdAt,
  });

  LogEntry copyWith({
    String? id,
    String? tankId,
    String? type,
    String? title,
    String? description,
    Map<String, dynamic>? metadata,
    List<String>? images,
    DateTime? createdAt,
  }) {
    return LogEntry(
      id: id ?? this.id,
      tankId: tankId ?? this.tankId,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      metadata: metadata ?? this.metadata,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
