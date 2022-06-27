import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserListCardShimmer extends StatelessWidget {
  const UserListCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCard();
  }

  Column buildCard() {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Color.fromARGB(255, 233, 233, 233),
          highlightColor: Color.fromARGB(255, 208, 208, 208),
          child: Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Shimmer.fromColors(
            baseColor: Color.fromARGB(255, 233, 233, 233),
            highlightColor: Color.fromARGB(255, 208, 208, 208),
            child: Container(
              height: 10,
              width: 80,
              color: Colors.white,
            )),
        const SizedBox(
          height: 5,
        ),
        Shimmer.fromColors(
          child: Container(
            width: 140,
            height: 20,
            color: Colors.white,
          ),
          baseColor: Color.fromARGB(255, 233, 233, 233),
          highlightColor: Color.fromARGB(255, 208, 208, 208),
        )
      ],
    );
  }
}
