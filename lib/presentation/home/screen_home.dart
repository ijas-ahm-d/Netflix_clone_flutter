import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/home/home_bloc.dart';
import 'package:netflix_clone/core/colors.dart';
import 'package:netflix_clone/core/constant.dart';
import 'package:netflix_clone/presentation/home/widgets/background_card.dart';
import 'package:netflix_clone/presentation/home/widgets/number_title_card.dart';
import 'package:netflix_clone/presentation/widgets/main_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              } else if (state.hasError) {
                return const Center(
                  child: Text(
                    "Error while getting data",
                    style: TextStyle(
                      color: kWhiteColor,
                    ),
                  ),
                );
              }
              // released past year
              final releasedPastYear = state.pastYearMovieList.map((m) {
                return "$imageAppentUrl${m.posterPath}";
              }).toList();
              releasedPastYear.shuffle();
              // trending now
              final trendingNow = state.trendingMovieList.map((m) {
                return "$imageAppentUrl${m.posterPath}";
              }).toList();
              trendingNow.shuffle();
              // tense Dramas MovieList
              final tenseDramas = state.tenseDramasMovieList.map((m) {
                return "$imageAppentUrl${m.posterPath}";
              }).toList();
              tenseDramas.shuffle();
              // south Indian MovieList
              final southIndian = state.southIndianMovieList.map((m) {
                return "$imageAppentUrl${m.posterPath}";
              }).toList();
              southIndian.shuffle(); 
       // Top 10 tv shows
       final top10TvShows=state.trendingTvList.map((m){
        return "$imageAppentUrl${m.posterPath}";
       }).toList();
       top10TvShows.shuffle();
              return ListView(
                children: [
                  const BackgroundCard(),
                  kHeight,
                  MainTitleCard(
                    posterList: releasedPastYear,
                    title: "Released in the Past Year",
                  ),
                  MainTitleCard(
                    posterList: trendingNow,
                    title: "Trending Now",
                  ),
                   NumberTitleCard(
                    postersList:top10TvShows ,
                   ),
                  MainTitleCard(
                    posterList: tenseDramas,
                    title: "Tense Dramas",
                  ),
                  MainTitleCard(
                    posterList: southIndian,
                    title: "South Indian Cinema",
                  ),
                ],
              );
            },
          ),
          scrollNotifier.value == true
              ? AnimatedContainer(
                  duration: const Duration(microseconds: 1000),
                  width: double.infinity,
                  height: 130,
                  color: Colors.black.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.network(
                              'https://s.yimg.com/fz/api/res/1.2/0C3qj4EY9V.ciWG9oNddUQ--~C/YXBwaWQ9c3JjaGRkO2ZpPWZpdDtoPTI2MDtxPTgwO3c9MjYw/https://s.yimg.com/zb/imgv1/b696b8bc-fcfd-3123-83cf-5dfa4c0a3bee/t_500x300',
                              width: 50,
                              height: 50,
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
                        kHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text(
                              'TV Shows',
                              style: kHomeTitleText,
                            ),
                            Text(
                              'Movies',
                              style: kHomeTitleText,
                            ),
                            Text(
                              'Categories',
                              style: kHomeTitleText,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : kHeight
        ],
      ),
    );
  }
}
