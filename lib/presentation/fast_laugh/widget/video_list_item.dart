import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/colors.dart';
import 'package:netflix_clone/core/constant.dart';
import 'package:netflix_clone/domain/downloads/models/downloads.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';
import '../../../application/fast_laugh/fast_laugh_bloc.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;
  const VideoListItemInheritedWidget({
    super.key,
    required this.widget,
    required this.movieData,
  }) : super(child: widget);
  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;

    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];

    return Stack(
      children: [
        FastLaughVideoPlayer(
          videoUrl: videoUrl,
          onStateChanged: (bool) {},
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Side
              CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                radius: 30,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.volume_up,
                    color: kWhiteColor,
                  ),
                ),
              ),

              // Right Side
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundImage: posterPath == null
                          ? null
                          : NetworkImage('$imageAppentUrl$posterPath'),
                      backgroundColor: Colors.black.withOpacity(0.5),
                      radius: 30,
                    ),
                    kHeight,
                    ValueListenableBuilder(
                      valueListenable: likedVideosIdsNotifier,
                      builder: (BuildContext context, Set<int> newLikedIds,
                          Widget? _) {
                        final _index = index;
                        if (newLikedIds.contains(_index)) {
                          return GestureDetector(
                            onTap: () {
                              likedVideosIdsNotifier.value.remove(_index);
                              likedVideosIdsNotifier.notifyListeners();
                              // BlocProvider.of<FastLaughBloc>(context).add(
                              //   Unlikevideo(id: _index),
                              // );
                            },
                            child: const VideoActionsWidget(
                              icon: Icons.favorite_outline,
                              title: 'Liked',
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            likedVideosIdsNotifier.value.add(_index);
                            likedVideosIdsNotifier.notifyListeners();
                            // BlocProvider.of<FastLaughBloc>(context).add(
                            //   LikeVideo(id: _index),
                            // );
                          },
                          child: const VideoActionsWidget(
                            icon: Icons.emoji_emotions,
                            title: 'LOL',
                          ),
                        );
                      },
                    ),
                    const VideoActionsWidget(
                      icon: Icons.add,
                      title: 'My List',
                    ),
                    GestureDetector(
                      onTap: () {
                        final movieName =
                            VideoListItemInheritedWidget.of(context)
                                ?.movieData
                                .title;
                        if (movieName != null) {
                          Share.share(movieName);
                        }
                      },
                      child: const VideoActionsWidget(
                        icon: Icons.share,
                        title: 'Share',
                      ),
                    ),
                    const VideoActionsWidget(
                      icon: Icons.play_arrow,
                      title: 'Play',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class VideoActionsWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActionsWidget(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Icon(
            icon,
            color: kWhiteColor,
            size: 30,
          ),
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: kWhiteColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.onStateChanged,
  });

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {});
      _videoPlayerController.play();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )

          //  VideoPlayer(_videoPlayerController)
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
