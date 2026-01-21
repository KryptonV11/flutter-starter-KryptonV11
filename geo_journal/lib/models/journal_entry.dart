class JournalEntry {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final double? lat;
  final double? lng;

  JournalEntry({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.lat,
    this.lng,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    // JSONPlaceholder отдаёт: id, title, body
    return JournalEntry(
      id: (json['id'] ?? 0) as int,
      title: (json['title'] ?? '') as String,
      description: (json['body'] ?? json['description'] ?? '') as String,
      createdAt: DateTime.now(),
      lat: (json['lat'] is num) ? (json['lat'] as num).toDouble() : null,
      lng: (json['lng'] is num) ? (json['lng'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": description,
        "createdAt": createdAt.toIso8601String(),
        "lat": lat,
        "lng": lng,
      };
}
