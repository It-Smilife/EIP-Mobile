import 'package:itsmilife/pages/normal_user/activités/forum/models/author_model.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/models/replies_model.dart';

class Question{
  String question;
  String content;
  int votes;
  int repliesCount;
  int views;
  String createdAt;
  Author author;
  List<Reply> replies;

  Question({
    required this.question,
    required this.content,
    required this.votes,
    required this.repliesCount,
    required this.views,
    required this.createdAt,
    required this.author,
    required this.replies
  });
}

List<Question> questions = [
  Question(
    author: mike,
    question: 'Comment je suis sortis de ma depression ?',
    content: "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
    createdAt: "1h ago",
    views: 120,
    votes: 100,
    repliesCount: 80,
    replies: replies
  ),
  Question(
    author: john,
    question: 'Les bienfaits du psychologue',
    content: "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
    createdAt: "2h ago",
    views: 20,
    votes: 10,
    repliesCount: 10,
    replies: replies
  ),
  Question(
    author: sam,
    question: 'test',
    content: "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
    createdAt: "4h ago",
    views: 220,
    votes: 107,
    repliesCount: 67,
    replies: replies
  ),
];