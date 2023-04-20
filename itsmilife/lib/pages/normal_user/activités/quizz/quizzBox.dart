import '../../../../services/NetworkManager.dart';

Future<List<quizzBox>> getQuizzes(id) async {
  return await NetworkManager.get("themes/" + id + "/quizzes").then((value) {
    if (value.data["success"] == true) {
      final quizzes = List<quizzBox>.from(value.data["message"]
          .map((themeData) => quizzBox.fromData(themeData)));
      return quizzes;
    } else {
      throw Exception('Failed to load themes');
    }
  });
}

class quizzBox {
  final String id;
  final String title;
  final String avatar;

  quizzBox({
    required this.id,
    required this.title,
    required this.avatar,
  });

  factory quizzBox.fromData(Map<String, dynamic> data) {
    return quizzBox(
      id: data['_id'],
      title: data['title'],
      avatar: data['avatar'],
    );
  }
}
