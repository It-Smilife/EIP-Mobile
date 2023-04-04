import 'package:itsmilife/pages/normal_user/activités/forum/models/author_model.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/models/replies_model.dart';
import 'package:intl/intl.dart';

class Post {
  String id;
  String title;
  String user;
  List<String> comments;
  String content;
  int replies_count;
  int views;
  String date;

  Post(
      {required this.id,
      required this.title,
      required this.content,
      required this.replies_count,
      required this.views,
      required this.date,
      required this.user,
      required this.comments});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['_id'],
        title: json['title'],
        user: json['user'],
        comments: List<String>.from(json['comments']),
        content: json['content'],
        replies_count: json['replies_count'],
        views: json['views'],
        date: json['date']);
  }
}
