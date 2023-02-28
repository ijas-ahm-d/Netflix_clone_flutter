import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/hot_and_new/hot_and_new_service.dart';

import '../../domain/hot_and_new/models/hot_and_new/hot_and_new.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    //  Get hot and new Movie Data
    on<LoadDataInComingSoon>((event, emit) async {
      // SendLoading to UI
      emit(const HotAndNewState(
          comingSoonList: [],
          everyoneIsWatchingList: [],
          isLoading: true,
          hasError: false));
      // get data from remote
      final result = await _hotAndNewService.getHotAndNewMovieData();
      //  data to state
      final newState = result.fold((MainFailure failure) {
        return const HotAndNewState(
            comingSoonList: [],
            everyoneIsWatchingList: [],
            isLoading: false,
            hasError: true);
      }, (HotAndNew hotAndNew) {
        return HotAndNewState(
            comingSoonList: hotAndNew.results,
            everyoneIsWatchingList: state.everyoneIsWatchingList,
            isLoading: false,
            hasError: false);
      });
      emit(newState);
    });
    //  Get hot and new Tv Data
    on<LoadDataInEveryOneIsWatching>((event, emit) {});
  }
}
