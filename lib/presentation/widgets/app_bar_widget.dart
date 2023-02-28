import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/constant.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          kWidth,
          Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: 30, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.cast,
              color: Colors.white,
            ),
          ),
          kWidth,
          Container(
            width: 30,
            height: 30,
            color: Colors.blue,
          ),
          kWidth,
        ],
      ),
    );
  }
}
