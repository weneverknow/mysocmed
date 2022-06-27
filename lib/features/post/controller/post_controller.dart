import 'package:get/get.dart';
import 'package:my_socmed/config/api_url.dart';
import 'package:my_socmed/features/post/model/post.dart';
import 'package:my_socmed/http/request_service.dart';
import 'package:my_socmed/shared/fetch_status.dart';

class PostController extends GetxController {
  var postLoadedStatus = FetchStatus.loading.obs;
  var posts = <Post>[].obs;

  like(String id, bool isLike) {
    var updatedPost = posts.firstWhere((element) => element.id == id);
    updatedPost = updatedPost.copyWith(isLiked: isLike);
    update();

    //posts.value = (posts.where((post) => (post.id != id))).firstWhere((element) => false).toList();
    //posts.value.add(updatedPost);
  }

  load(String id) async {
    postLoadedStatus.value = FetchStatus.loading;
    final response = await RequestService.get(url: "$url/user/$id/post");
    print("[PostController] $response");
    if (response.data["data"] != null) {
      postLoadedStatus.value = FetchStatus.success;
      List<Post> userPosts =
          (response.data["data"] as List).map((e) => Post.fromJson(e)).toList();
      posts.value = userPosts;
    } else {
      postLoadedStatus.value = FetchStatus.failed;
    }
  }
}
