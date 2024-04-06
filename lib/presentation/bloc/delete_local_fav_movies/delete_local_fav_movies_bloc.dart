import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/usecases/local/remove_fav_movie.dart';

part 'delete_local_fav_movies_event.dart';
part 'delete_local_fav_movies_state.dart';

class DeleteLocalFavMoviesBloc
    extends Bloc<DeleteLocalFavMoviesEvent, DeleteLocalFavMoviesState> {
  final RemoveFavMovie removeFavMovie;

  DeleteLocalFavMoviesBloc({
    required this.removeFavMovie,
  }) : super(DeleteLocalFavMoviesInitial()) {
    on<DeleteFavMovies>((event, emit) async {
      emit(DeleteLocalFavMoviesLoading());
      for (final movie in event.movies) {
        log(movie.title);
        final failureOrUnit = await removeFavMovie(movie);
        failureOrUnit.fold(
          (failure) {
            log(failure.message);
            emit(DeleteLocalFavMoviesError(failure.message));
          },
          (_) {
            log('Removed ${movie.title} from local fav movies');
            emit(DeleteLocalFavMoviesSuccess());
          },
        );
      }
    });
  }
}
