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
           Text(
           movieName,
            style:const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          kHeight,
           Text(
            description,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style:const TextStyle(color: kGreyColor, fontSize: 16),
          ),
          kHeight50,
           VideoWidget(url: posterPath,),
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
