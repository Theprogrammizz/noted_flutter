class NotesModel {
  final int id;
  final String title;
  final String body;
  final String userId;
  final DateTime createdAt;

  NotesModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.createdAt,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'body': body};
  }
}
