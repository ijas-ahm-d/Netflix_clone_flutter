import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors.dart';

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
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                  child: Icon(
                Icons.wifi,
                color: kWhiteColor,
              ));
            },
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
