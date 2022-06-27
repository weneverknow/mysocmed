import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_socmed/features/profile/ui/profile_screen.dart';
import 'package:my_socmed/features/user/controller/user_controller.dart';
import 'package:my_socmed/features/user/model/user.dart';
import 'package:my_socmed/features/user/ui/components/user_list_card.dart';
import 'package:my_socmed/features/user/ui/components/user_list_card_shimmer.dart';
import 'package:my_socmed/shared/fetch_status.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _userController = Get.put(UserController());
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController()..addListener(scrollListener);
    _userController.loadUser(1);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _userController.loadUser(_userController.currentPage.value + 1);
      _userController.currentPage.value += 1;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      //_scrollController.jumpTo(MediaQuery.of(context).size.height * 1.5);

      print("[scrollListener] isLoading");
      print("[scrollListener] run loadmore with page++");
      print("[scrollListener] add new data to current data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User List",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // const SizedBox(
            //   height: 20,
            // ),
            Flexible(
              child: Obx(() => GridView.count(
                    controller: _scrollController,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    //children: [buildCard(), buildCard()],
                    children: _userController.userLoaded.value ==
                            FetchStatus.loading
                        ? List.generate(10, (index) => UserListCardShimmer())
                        : _userController.users
                            .map((user) => UserListCard(
                                  user: user,
                                  onTap: () {
                                    Get.to(() => ProfileScreen(userId: user.id),
                                        preventDuplicates: false);
                                  },
                                ))
                            .toList(),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
