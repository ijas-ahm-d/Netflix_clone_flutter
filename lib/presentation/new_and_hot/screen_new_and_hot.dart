import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netflix_clone/core/colors.dart';
import 'package:netflix_clone/core/constant.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/everyones_watching_widget.dart';

import '../../application/hot_and_new/hot_and_new_bloc.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(
            100,
          ),
          child: AppBar(
            title: Text(
              "New & Hot",
              style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              const Icon(
                Icons.cast,
                color: Colors.white,
                size: 30,
              ),
              kWidth,
              Container(
                width: 30,
                height: 30,
                color: Colors.blue,
              )
            ],
            bottom: TabBar(
              labelColor: kBlackColor,
              isScrollable: true,
              unselectedLabelColor: kWhiteColor,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              indicator: BoxDecoration(
                color: kWhiteColor,
                borderRadius: kRadius30,
              ),
              tabs: const [
                Tab(
                  text: "🍿 C o m i n g  S o o n",
                ),
                Tab(
                  text: "👀 E v e r y o n e ' s   W a t c h i n g",
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(children: [
          ComingSoonList(
            key: Key('coming_soon'),
          ),
          EveryoneWatchingList(
            key: Key("everyone_watching"),
          )
        ]),
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(
        const LoadDataInComingSoon(),
      );
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context).add(
          const LoadDataInComingSoon(),
        );
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text("Error in Loading Coming Soon List"),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text("Coming Soon List Is Empty"),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 05),
              itemCount: state.comingSoonList.length,
              itemBuilder: (context, index) {
                final movie = state.comingSoonList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }

                final date = DateTime.tryParse(movie.releaseDate!);
                final formatedDate = DateFormat.yMMMMd('en_US').format(date!);

                return ComingSoonWidget(
                  id: movie.id.toString(),
                  month: formatedDate
                      .split(' ')
                      .first
                      .substring(0, 3)
                      .toUpperCase(),
                  day: movie.releaseDate!.split('-')[1],
                  posterPath: '$imageAppentUrl${movie.posterPath}',
                  movieName: movie.originalTitle ?? "NO Title",
                  description: movie.overview ?? "NO description",
                );
              },
            );
          }
        },
      ),
    );
  }
}

class EveryoneWatchingList extends StatelessWidget {
  const EveryoneWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryOneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryOneIsWatching());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text("Error in Loading Everyone Watching List"),
            );
          } else if (state.everyoneIsWatchingList.isEmpty) {
            return const Center(
              child: Text("evryone watching List Is Empty"),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.everyoneIsWatchingList.length,
              itemBuilder: (context, index) {
                final tv = state.everyoneIsWatchingList[index];
                if (tv.id == null) {
                  return const SizedBox();
                }

                return EveryonesWatchingWidget(
                    posterPath: '$imageAppentUrl${tv.posterPath}',
                    movieName: tv.originalName ?? "No Name",
                    description: tv.overview ?? "No Description");
              },
            );
          }
        },
      ),
    );
  }
}
