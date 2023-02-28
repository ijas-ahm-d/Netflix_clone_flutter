import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/search/search_bloc.dart';
import 'package:netflix_clone/core/constant.dart';
import 'package:netflix_clone/presentation/search/widget/title.dart';

// const imageUrl =
//     "https://www.themoviedb.org/t/p/w220_and_h330_face/m1b9toKYyCujHuLoXB5GSDunO9e.jpg";

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTitleText(
          title: 'Movies & Tv',
        ),
        kHeight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return GridView.count(
                shrinkWrap: true,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.5,
                children: List.generate(state.searchResultList.length, (index) {
                  final movie = state.searchResultList[index];
                  return MainCard(
                    imageUrl: movie.posterImageUrl,
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final nuus = null;
    return imageUrl == "$imageAppentUrl$nuus"
        ? Center(
            child: Text("No Image Found"),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
