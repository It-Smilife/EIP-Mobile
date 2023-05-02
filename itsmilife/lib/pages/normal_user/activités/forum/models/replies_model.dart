import 'package:itsmilife/pages/normal_user/activités/forum/models/author_model.dart';

class Comment {
  String id;
  String content;
  Map<String, dynamic> user;
  String date;

  Comment({
    required this.id,
    required this.content,
    required this.user,
    required this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      content: json['content'],
      user: json['user'],
      date: json['date'],
    );
  }
}