import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {super.key,
      required this.icon,
      this.iconSize = 30,
      this.textSize = 18,
      required this.title});
  final IconData icon;
  final String title;
  final double iconSize;
  final double textSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: kWhiteColor,
          size: iconSize,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: textSize,
          ),
        )
      ],
    );
  }
}
