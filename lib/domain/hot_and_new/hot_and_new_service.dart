

import 'package:dartz/dartz.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/hot_and_new/models/hot_and_new/hot_and_new.dart';

abstract class HotAndNewService{

  Future<Either<MainFailure,HotAndNew>> getHotAndNewMovieData();
  Future<Either<MainFailure,HotAndNew>> getHotAndNewTvData();
}