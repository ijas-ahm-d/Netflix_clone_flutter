import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/application/downloads/downloads_bloc.dart';
import 'package:netflix_clone/core/colors.dart';
import 'package:netflix_clone/core/constant.dart';
import 'package:netflix_clone/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});
  final _widgetList = [
    const _SmartDownloads(),
   const Section2(),
    const Section3(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(
          100,
        ),
        child: AppBarWidget(
          title: 'Downloads',
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _widgetList.length,
        itemBuilder: (context, index) {
          return _widgetList[index];
        },
      ),
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        kWidth,
        Icon(
          Icons.settings,
          color: kWhiteColor,
        ),
        kWidth,
        Text('Smart Download')
      ],
    );
  }
}

class Section2 extends StatelessWidget {
  const Section2({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImages());
    });
    // BlocProvider.of<DownloadsBloc>(context)
    //     .add(const DownloadsEvent.getDownloadsImages());
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        kHeight,
        kHeight,
        Text(
          'Introducing Downloads for you',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 24,
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight,
        Text(
          "We'll download a personalized selection of\nmovies and shows for you, so there's \n always something to watch on your\n device.",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            try {
              return SizedBox(
                width: size.width,
                height: size.width,
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(
                              0.5,
                            ),
                            radius: size.width * 0.28,
                          ),
                          DownloadsImageWidget(
                            imageList:
                                '$imageAppentUrl${state.downloads[0].posterPath}',
                            margin: const EdgeInsets.only(
                              left: 150,
                              top: 20,
                              bottom: 0,
                            ),
                            angle: 20,
                            size: Size(
                              size.width * 0.30,
                              size.width * 0.37,
                            ),
                          ),
                          DownloadsImageWidget(
                            imageList:
                                '$imageAppentUrl${state.downloads[1].posterPath}',
                            margin: const EdgeInsets.only(
                              right: 150,
                              top: 20,
                              bottom: 0,
                            ),
                            angle: -20,
                            size: Size(
                              size.width * 0.30,
                              size.width * 0.37,
                            ),
                          ),
                          DownloadsImageWidget(
                            radius: 5,
                            imageList:
                                '$imageAppentUrl${state.downloads[2].posterPath}',
                            margin: const EdgeInsets.only(
                              bottom: 05,
                            ),
                            size: Size(
                              size.width * 0.33,
                              size.width * 0.44,
                            ),
                          ),
                        ],
                      ),
              );
            } catch (e) {
              return kHeight;
            }
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: kButtonColorBlue,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Text(
                'Setup',
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        kHeight,
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          color: kButtonColorWhite,
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Text(
              'See what you can download',
              style: GoogleFonts.montserrat(
                color: kBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget(
      {super.key,
      required this.imageList,
      required this.size,
      this.angle = 0,
      this.radius = 10,
      required this.margin});

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  imageList,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
