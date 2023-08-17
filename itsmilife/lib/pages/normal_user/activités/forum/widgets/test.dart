import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/models/post_model.dart';
import 'package:itsmilife/services/NetworkManager.dart';

class TestPostWidget extends StatefulWidget {
  const TestPostWidget({super.key});

  @override
  State<TestPostWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestPostWidget> {
  late Future<List<Post>> postFuture;

  Future<List<Post>> fetchAllPost() async {
    final response = await NetworkManager.get('forums');
    if (response.data['success'] == true) {
      List<Post> posts = [];
      for (var post in response.data["message"]) {
        posts.add(Post.fromJson(response.data['message'][post]));
      }
      return posts;
    } else {
      throw Exception();
    }
  }

  @override
  void initState() {
    super.initState();
    postFuture = fetchAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
