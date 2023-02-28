import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors.dart';
import 'package:netflix_clone/core/constant.dart';

class VideoWidget extends StatelessWidget {
  final String url;
  const VideoWidget({
   required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
           url,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            radius: 20,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.volume_up,
                color: kWhiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
