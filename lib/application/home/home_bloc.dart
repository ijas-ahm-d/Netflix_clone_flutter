import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/hot_and_new/models/hot_and_new/hot_and_new.dart';

import '../../domain/hot_and_new/hot_and_new_service.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@Injectable()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
  final HotAndNewService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    // on Event get Homescreen data
    on<GetHomeScreenData>((event, emit) async {
      // send loading to UI
      emit(state.copyWith(
        isLoading: true,
        hasError: false,
      ));

      // Get Data
      final _movieresult = await _homeService.getHotAndNewMovieData();
      final _tvResult = await _homeService.getHotAndNewTvData();

      // transform data
      final _state1 = _movieresult.fold((MainFailure failure) {
        return  HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true);
      }, (HotAndNew resp) {
        final pastYear = resp.results;
        final trending = resp.results;
        final dramas = resp.results;
        final southIndian = resp.results;
        pastYear.shuffle();
        trending.shuffle();
        dramas.shuffle();
        southIndian.shuffle();
        return HomeState(
                    stateId: DateTime.now().millisecondsSinceEpoch.toString(),

          pastYearMovieList: pastYear,
          trendingMovieList: trending,
          tenseDramasMovieList: dramas,
          southIndianMovieList: southIndian,
          trendingTvList: state.trendingTvList,
          isLoading: false,
          hasError: false,
        );
      });
      emit(_state1);
   final _state2=   _tvResult.fold((MainFailure failure) {
        return  HomeState(
                  stateId: DateTime.now().millisecondsSinceEpoch.toString(),

          pastYearMovieList: [],
          trendingMovieList: [],
          tenseDramasMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNew resp) {
        final top10List = resp.results;
        top10List.shuffle();
        return HomeState(
                    stateId: DateTime.now().millisecondsSinceEpoch.toString(),

          pastYearMovieList: state.pastYearMovieList,
          trendingMovieList: state.trendingMovieList,
          tenseDramasMovieList: state.tenseDramasMovieList,
          southIndianMovieList: state.southIndianMovieList,
          trendingTvList: top10List,
          isLoading: false,
          hasError: false,
        );
      }); 

      // send to UI
      emit(_state2);
    });
  }
}
