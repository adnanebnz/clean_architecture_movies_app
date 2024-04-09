import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/usecases/local/add_fav_movie.dart';
import 'package:movies_app/domain/usecases/local/get_fav_movies.dart';
import 'package:movies_app/domain/usecases/local/remove_fav_movie.dart';
import 'package:movies_app/domain/usecases/local/search_fav_movies.dart';

part 'local_fav_movies_event.dart';
part 'local_fav_movies_state.dart';

class LocalFavMoviesBloc
    extends Bloc<LocalFavMoviesEvent, LocalFavMoviesState> {
  GetFavMovies getFavMovies;
  RemoveFavMovie removeFavMovie;
  SearchFavMovies searchFavMovies;
  AddFavMovie addFavMovie;
  LocalFavMoviesBloc({
    required this.getFavMovies,
    required this.removeFavMovie,
    required this.searchFavMovies,
    required this.addFavMovie,
  }) : super(LocalFavMoviesInitial()) {
    on<FetchLocalFavMoviesEvent>(_onFetchLocalFavMoviesEvent);
    on<DeleteLocalFavMovieEvent>(_onDeleteLocalFavMovieEvent);
    on<AddLocalFavMovieEvent>(_onAddLocalFavMovieEvent);
    on<SearchLocalMoviesEvent>(_onSearchLocalMoviesEvent);
  }

  void _onFetchLocalFavMoviesEvent(
      FetchLocalFavMoviesEvent event, Emitter<LocalFavMoviesState> emit) async {
    emit(LocalFavMoviesLoading());
    final result = await getFavMovies();
    result.fold(
      (l) => emit(LocalFavMoviesError(l.toString())),
      (r) => emit(LocalFavMoviesLoaded(r)),
    );
  }

  void _onDeleteLocalFavMovieEvent(
      DeleteLocalFavMovieEvent event, Emitter<LocalFavMoviesState> emit) async {
    log("Length is ${event.movies.length}");
    for (var movie in event.movies) {
      log(movie.title);
      final result = await removeFavMovie(movie);
      result.fold(
        (l) => emit(LocalFavMoviesError(l.toString())),
        (r) {
          add(const FetchLocalFavMoviesEvent());
        },
      );
    }
  }

  void _onAddLocalFavMovieEvent(
      AddLocalFavMovieEvent event, Emitter<LocalFavMoviesState> emit) async {
    final result = await addFavMovie(event.movie);
    result.fold(
      (l) => emit(LocalFavMoviesError(l.toString())),
      (r) => add(const FetchLocalFavMoviesEvent()),
    );
  }

  void _onSearchLocalMoviesEvent(
      SearchLocalMoviesEvent event, Emitter<LocalFavMoviesState> emit) async {
    final result = await searchFavMovies(event.query);
    result.fold(
      (l) => emit(LocalFavMoviesError(l.toString())),
      (r) => emit(LocalFavMoviesSearchLoaded(r)),
    );
  }
}
