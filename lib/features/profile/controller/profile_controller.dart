import 'package:get/get.dart';
import 'package:my_socmed/shared/fetch_status.dart';

import '../../../config/api_url.dart';
import '../../../http/request_service.dart';
import '../../user/model/user.dart';

class ProfileController extends GetxController {
  var userDetailLoaded = FetchStatus.loading.obs;
  var userDetail = Map<String, dynamic>().obs;

  loadUserDetail(String id) async {
    userDetailLoaded.value = FetchStatus.loading;
    print(id);
    final response = await RequestService.get(url: "$url/user/$id");
    print(response);
    if (response.data != null) {
      userDetailLoaded.value = FetchStatus.success;
      print(response.data);
      userDetail.value = User.fromJson(response.data).toJson();
    } else {
      userDetailLoaded.value = FetchStatus.failed;
    }
  }
}
