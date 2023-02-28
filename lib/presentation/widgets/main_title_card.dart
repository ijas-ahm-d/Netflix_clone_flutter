import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constant.dart';
import 'package:netflix_clone/presentation/widgets/main_card.dart';
import 'package:netflix_clone/presentation/widgets/main_title.dart';

class MainTitleCard extends StatelessWidget {
  const MainTitleCard({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(
          title: title,
        ),

        kHeight,
        // MainCard()
        LimitedBox(
          maxHeight: 200,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const MainCard();
              },
              separatorBuilder: (context, index) {
                return kWidth;
              },
              itemCount: 20),
        ),
        kHeight
      ],
    );
  }
}
