import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_socmed/features/post/controller/post_controller.dart';
import 'package:my_socmed/features/post/model/post.dart';
import 'package:my_socmed/features/profile/controller/profile_controller.dart';
import 'package:my_socmed/shared/fetch_status.dart';
import 'package:my_socmed/shared/value.dart';
import '../../../extension/date_time_extension.dart';
import '../../user/model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.userId, Key? key}) : super(key: key);
  final String userId;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileController = Get.put(ProfileController());
  final _postController = Get.put(PostController());

  @override
  void initState() {
    _profileController.loadUserDetail(widget.userId);
    _postController.load(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final user = User.fromJson(_profileController.userDetail);
    //final post = _postController.posts[0];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "USER PROFILE",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_rounded)),
      ),
      body: Obx(
        () => _profileController.userDetailLoaded.value == FetchStatus.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.grey.shade300,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() =>
                      buildCard(User.fromJson(_profileController.userDetail))),
                  Container(
                    height: 14,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(() => Text(
                          "${_profileController.userDetail['firstName']} Blog",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                      child: Obx(() => _postController.postLoadedStatus.value ==
                              FetchStatus.success
                          ? PageView.builder(
                              itemCount: _postController.posts.length,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: ((context, index) {
                                return buildPostCard(
                                    _postController.posts[index]);
                              }),
                              // builder: (context) {
                              //   return buildPostCard(post);
                              // }
                            )
                          : const SizedBox.shrink()))
                ],
              ),
      ),
    );
  }

  Container buildPostCard(Post post) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 1),
            blurRadius: 5,
            spreadRadius: -1)
      ]),
      margin: const EdgeInsets.only(
          left: defaultPadding * 2,
          right: defaultPadding * 2,
          bottom: defaultPadding * 2),
      child: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(post.image), fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
              children: List.generate(
                  post.tags.length,
                  (index) => Container(
                        margin: EdgeInsets.only(
                            left: index == 0 ? defaultPadding / 2 : 0,
                            right: defaultPadding / 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                            vertical: defaultPadding / 4),
                        decoration: BoxDecoration(
                            color: Colors.red.shade200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          post.tags[index],
                          style: TextStyle(fontSize: 11),
                        ),
                      ))),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  post.publishDate.displayDate(),
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.pink.shade300,
                    ),
                    Text(
                      " ${post.likes} likes",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    post.text,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Flexible(
            child: Row(
              children: [
                GetBuilder<PostController>(builder: (controller) {
                  return IconButton(
                    onPressed: () {
                      print("liked ${!post.isLiked}");
                      controller.like(post.id, !post.isLiked);
                      controller.update();
                    },
                    icon: post.isLiked
                        ? Icon(Icons.thumb_up_rounded)
                        : Icon(Icons.thumb_up_outlined),
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column buildCard(User user) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 3,
                    color: user.gender == "female"
                        ? Colors.pink.shade400
                        : Color.fromARGB(255, 10, 65, 213))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                user.picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRowText(
                  'Name ', '${user.title} ${user.firstName} ${user.lastName}'),
              const SizedBox(
                height: 10,
              ),
              buildRowText('Date of birth',
                  '${DateTime.parse(user.dateOfBirth!).displayDate()}'),
              const SizedBox(
                height: 10,
              ),
              buildRowText('Join from', "${user.registerDate!.displayDate()}"),
              const SizedBox(
                height: 10,
              ),
              buildRowText('Email', "${user.email}"),
              const SizedBox(
                height: 10,
              ),
              buildRowText('Address',
                  "${user.location?.street}, ${user.location?.city}, ${user.location?.state}, ${user.location?.country}"),
              //buildRichText('Join From', value)
              // Text(
              //   "${user.title}".toUpperCase(),
              //   style: TextStyle(
              //       color: Color.fromARGB(255, 139, 139, 139), fontSize: 12),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Text(
              //   "${user.firstName} ${user.lastName}".toUpperCase(),
              //   style: TextStyle(fontWeight: FontWeight.w600),
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              // )
            ],
          ),
        ),
      ],
    );
  }

  RichText buildRichText(String label, String value) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: '$label ', style: TextStyle(color: Colors.grey.shade400)),
      TextSpan(
          text: '$value',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black))
    ]));
  }

  Widget buildRowText(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade400)),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
            maxLines: 2,
            textAlign: TextAlign.end,
            overflow: TextOverflow.clip,
          ),
        )
      ],
    );
  }
}
