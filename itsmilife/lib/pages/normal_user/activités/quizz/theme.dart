import '../../../../services/NetworkManager.dart';

Future<List<Category>> getThemes() async {
  return await NetworkManager.get("themes").then((value) {
    if (value.data["success"] == true) {
      final themes = List<Category>.from(value.data["message"]
          .map((themeData) => Category.fromData(themeData)));
      return themes;
    } else {
      throw Exception('Failed to load themes');
    }
  });
}

Future<List<Category>> getThemesByName(name) async {
  return await NetworkManager.get("themes/" + name + "/quizzes/name")
      .then((value) {
    if (value.data["success"] == true) {
      final themes = List<Category>.from(value.data["message"]
          .map((themeData) => Category.fromData(themeData)));
      return themes;
    } else {
      throw Exception('Failed to load themes');
    }
  });
}

class Category {
  final String id;
  final String title;
  final String avatar;

  Category({
    required this.id,
    required this.title,
    required this.avatar,
  });

  factory Category.fromData(Map<String, dynamic> data) {
    return Category(
      id: data['_id'],
      title: data['title'],
      avatar: data['avatar'],
    );
  }
}
