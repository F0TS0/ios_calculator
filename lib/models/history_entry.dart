// models/history_entry.dart
class HistoryEntry {
  final int? id;
  final String content; // e.g., "5+6/2=8" or "10.00 km=6.21 miles"
  final DateTime createdAt; // timestamp

  HistoryEntry({this.id, required this.content, required this.createdAt});

  factory HistoryEntry.fromMap(Map<String, dynamic> map) {
    return HistoryEntry(
      id: map['id'],
      content: map['content'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
