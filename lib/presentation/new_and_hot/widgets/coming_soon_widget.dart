import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors.dart';
import 'package:netflix_clone/core/constant.dart';
import 'package:netflix_clone/presentation/home/widgets/custom_button_widget.dart';

import '../../widgets/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
    final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;

  const ComingSoonWidget({super.key, required this.id, required this.month, required this.day, required this.posterPath, required this.movieName, required this.description});

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Text(
                  month,
                  style:const TextStyle(fontSize: 20, color: kWhiteColor),
                ),
                Text(
                  day,
                  style:const TextStyle(
                    fontSize: 30,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: size.width - 70,
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 VideoWidget(url: posterPath),
                kHeight,
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      
                     movieName,
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                      style:
                       const   TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.blue,),
                    ),
                    const Spacer(),
                    Row(
                      children: const [
                        CustomButtonWidget(
                            iconSize: 20,
                            textSize: 16,
                            icon: Icons.all_out_sharp,
                            title: "Remind Me"),
                        kWidth,
                        CustomButtonWidget(
                            iconSize: 20,
                            textSize: 16,
                            icon: Icons.info,
                            title: "info"),
                        kWidth,
                      ],
                    )
                  ],
                ),
                kHeight,
                 Text("Coming on $day $month"),
                kHeight,
                 Text(
                 movieName,
                  style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                kHeight,
                 Text(
                  description,
                  style:const TextStyle(color: kGreyColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
