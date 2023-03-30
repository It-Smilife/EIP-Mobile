import 'package:itsmilife/pages/normal_user/activités/forum/models/author_model.dart';

class Reply {
  Author author;
  String content;
  int likes;

  Reply({
    required this.author,
    required this.content,
    required this.likes
  });

  factory Reply.fromJson(Map<dynamic, dynamic> json) {
    return Reply(
      content: json['content'],
      author: Author.fromJson(json['user']),
      likes: json['likes']
    );
  }
}

List<Reply> replies = [
  Reply(
    author: mike,
    content: 'super trop lourd mec',
    likes: 10
  ),
  Reply(
    author: john,
    content: 'oh woaaaaaaaaaaaaaaaaaw',
    likes: 120
  ),
  Reply(
    author: mark,
    content: 'la frappe sa mere.',
    likes: 67
  ),
];