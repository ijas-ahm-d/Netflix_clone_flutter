import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constant.dart';

import '../../../core/colors.dart';
import '../../home/widgets/custom_button_widget.dart';
import '../../widgets/video_widget.dart';

class EveryonesWatchingWidget extends StatelessWidget {
   final String posterPath;
  final String movieName;
  final String description;
  const EveryonesWatchingWidget({
    super.key, required this.posterPath, required this.movieName, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHeight,
          const Text(
            "friends",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          kHeight,
          const Text(
            "This hit sitcom followa the merry misadventures of sis 20-something pals as they navigate the pitfalls of the love in 1990's Manhattan",
            style: TextStyle(color: kGreyColor, fontSize: 16),
          ),
          kHeight50,
          const VideoWidget(url: newAndHot2,),
          kHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              CustomButtonWidget(
                  iconSize: 25,
                  textSize: 16,
                  icon: Icons.share,
                  title: "Share"),
              kWidth,
              CustomButtonWidget(
                iconSize: 25,
                textSize: 16,
                icon: Icons.add,
                title: "My List",
              ),
              kWidth,
              CustomButtonWidget(
                iconSize: 25,
                textSize: 16,
                icon: Icons.play_arrow,
                title: "Play",
              ),
              kWidth,
            ],
          )
        ],
      ),
    );
  }
}
