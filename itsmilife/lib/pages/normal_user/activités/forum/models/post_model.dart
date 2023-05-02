import 'package:itsmilife/pages/normal_user/activités/forum/models/author_model.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/models/replies_model.dart';
import 'package:intl/intl.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/models/replies_model.dart';

class Post {
  String id;
  String title;
  Map<String, dynamic> user;
  List<Comment> comments;
  String content;
  int replies_count;
  int? views;
  String date;

  Post({required this.id, required this.title, required this.content, required this.replies_count, required this.views, required this.date, required this.user, required this.comments});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['_id'],
        title: json['title'],
        user: json['user'],
        comments: List<Comment>.from(json['comments'].map((commentJson) => Comment.fromJson(commentJson))),
        content: json['content'],
        replies_count: json['replies_count'],
        views: json['views'],
        date: json['date']);
  }
}
