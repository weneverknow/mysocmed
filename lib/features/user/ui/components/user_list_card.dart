import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_socmed/features/profile/ui/profile_screen.dart';

import '../../model/user.dart';

class UserListCard extends StatelessWidget {
  const UserListCard({required this.user, this.onTap, Key? key})
      : super(key: key);
  final User user;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return buildCard(user, onTap: onTap);
  }

  Widget buildCard(User user, {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: Color(0xff2e63f4))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                user.picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${user.title}".toUpperCase(),
            style: TextStyle(
                color: Color.fromARGB(255, 139, 139, 139), fontSize: 12),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "${user.firstName} ${user.lastName}".toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
