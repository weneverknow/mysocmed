import 'package:get/get.dart';
import 'package:my_socmed/features/user/model/user.dart';
import 'package:my_socmed/http/request_service.dart';
import 'package:my_socmed/shared/fetch_status.dart';

import '../../../config/api_url.dart';

class UserController extends GetxController {
  var userLoaded = FetchStatus.loading.obs;
  var currentPage = 1.obs;
  var users = <User>[].obs;

  loadUser(int page) async {
    //userLoaded.value = FetchStatus.loading;
    final response =
        await RequestService.get(url: "$url/user?page=$page&limit=20");
    if (response.data["data"] != null) {
      await Future.delayed(Duration(seconds: 2));
      userLoaded.value = FetchStatus.success;
      List<User> newUsers =
          (response.data["data"] as List).map((e) => User.fromJson(e)).toList();
      addUser(newUsers);
    } else {
      userLoaded.value = FetchStatus.failed;
    }
  }

  addUser(List<User> newUsers) {
    if (users.isEmpty) {
      users.value = newUsers;
    } else {
      users.addAll(newUsers);
    }
  }
}
