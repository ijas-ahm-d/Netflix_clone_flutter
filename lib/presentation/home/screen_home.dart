import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_clone/core/constant.dart';
import 'package:netflix_clone/presentation/home/widgets/background_card.dart';
import 'package:netflix_clone/presentation/home/widgets/number_title_card.dart';
import 'package:netflix_clone/presentation/widgets/main_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: scrollNotifier,
        builder: (context, value, child) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.reverse) {
                scrollNotifier.value = false;
              } else if (direction == ScrollDirection.forward) {
                scrollNotifier.value = true;
              }
              return true;
            },
            child: Stack(
              children: [
                ListView(
                  children: const [
                    BackgroundCard(),
                    kHeight,
                    MainTitleCard(
                      title: "Released in the Past Year",
                    ),
                    MainTitleCard(
                      title: "Trending Now",
                    ),
                    NumberTitleCard(),
                    MainTitleCard(
                      title: "Tense Dramas",
                    ),
                    MainTitleCard(
                      title: "South Indian Cinema",
                    ),
                  ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
        },
      ),
    );
  }
}
