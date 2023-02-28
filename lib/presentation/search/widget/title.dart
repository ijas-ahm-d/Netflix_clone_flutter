import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTitleText extends StatelessWidget {
  final String title;
  const SearchTitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
