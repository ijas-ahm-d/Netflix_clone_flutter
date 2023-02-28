import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constant.dart';

class MainCard extends StatelessWidget {
  const MainCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 130,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: kRadius10,
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "https://www.themoviedb.org/t/p/w220_and_h330_face/1MK86Vr2nf1GSYOtRd8pFvA5RM8.jpg",
          ),
        ),
      ),
    );
  }
}
