import 'package:itsmilife/pages/normal_user/activités/forum/models/author_model.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/models/replies_model.dart';

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

// List<Question> questions = [
//   Question(
//       author: mike,
//       title: 'Comment je suis sortis de ma depression ?',
//       content:
//           "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
//       createdAt: "1h ago",
//       views: 120,
//       votes: 100,
//       repliesCount: 80,
//       replies: replies),
//   Question(
//       author: john,
//       title: 'Les bienfaits du psychologue',
//       content:
//           "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
//       createdAt: "2h ago",
//       views: 20,
//       votes: 10,
//       repliesCount: 10,
//       replies: replies),
//   Question(
//       author: sam,
//       title: 'test',
//       content:
//           "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
//       createdAt: "4h ago",
//       views: 220,
//       votes: 107,
//       repliesCount: 67,
//       replies: replies),
// ];
