import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_clone/presentation/fast_laugh/widget/video_list_item.dart';

class ScreenFastLaugh extends StatelessWidget {
  const ScreenFastLaugh({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
    });
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FastLaughBloc, FastLaughState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            } else if (state.isError) {
              return const Center(
                child: Text('Error While getting data'),
              );
            } else if (state.videoList.isEmpty) {
              return const Center(
                child: Text('video list is empty'),
              );
            } else {
              return PageView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  state.videoList.length,
                  (index) {
                    return VideoListItemInheritedWidget(
                        widget: VideoListItem(
                          index: index,
                          key: Key(index.toString()),
                        ),
                        movieData: state.videoList[index]);
                    // return VideoListItem(
                    //   index: index,
                    // );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
