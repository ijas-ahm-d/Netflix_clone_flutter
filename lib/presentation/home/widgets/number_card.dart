import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart ';
import 'package:netflix_clone/core/colors.dart';
import 'package:netflix_clone/core/constant.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index,required this.imageUrl});
  final int index;
  final String imageUrl;
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
                image:  DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                  imageUrl,
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
