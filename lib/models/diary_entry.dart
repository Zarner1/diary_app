class DiaryEntry {
  final String id;
  final String userId;
  final String title;
  final String content;
  final DateTime date;
  final String mood;

  DiaryEntry({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.date,
    required this.mood,
  });

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      content: json['content'],
      date: DateTime.parse(json['date']),
      mood: json['mood'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'mood': mood,
    };
  }
}