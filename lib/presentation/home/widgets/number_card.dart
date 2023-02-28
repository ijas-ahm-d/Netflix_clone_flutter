import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart ';
import 'package:netflix_clone/core/colors.dart';
import 'package:netflix_clone/core/constant.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 30,
              height: 200,
            ),
            Container(
              width: 130,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: kRadius10,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://www.themoviedb.org/t/p/w220_and_h330_face/9a9pyJZRhUWUSBT8BQqWihtqbI8.jpg",
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
            left: 0,
            bottom: -25,
            child: BorderedText(
              strokeWidth: 5.0,
              strokeColor: kWhiteColor,
              child: Text(
                "${index + 1}",
                style: const TextStyle(
                    fontSize: 150,
                    fontWeight: FontWeight.bold,
                    color: kBlackColor,
                    decoration: TextDecoration.none,
                    decorationColor: Colors.black),
              ),
            )),
      ],
    );
  }
}
