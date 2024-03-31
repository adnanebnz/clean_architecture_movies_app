import 'package:bloc/bloc.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/usecases/get_trending_movies.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_state.dart';

import 'trending_movies_event.dart';

class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final GetTrendingMovies getTrendingMovies;
  int currentPage = 1;
  TrendingMoviesBloc({required this.getTrendingMovies})
      : super(TrendingMoviesInitial()) {
    on<FetchTrendingMovies>((event, emit) async {
      emit(TrendingMoviesLoading());
      final failureOrMovies = await getTrendingMovies(currentPage);
      failureOrMovies.fold(
        (failure) => emit(TrendingMoviesError(failure.message)),
        (movies) => emit(TrendingMoviesLoaded(movies)),
      );
    });
    on<FetchNextPage>((event, emit) async {
      currentPage = event.pageKey;
      emit(TrendingMoviesLoading());
      final failureOrMovies = await getTrendingMovies(currentPage);
      failureOrMovies.fold(
          (failure) => emit(TrendingMoviesError(failure.toString())), (movies) {
        if (state is TrendingMoviesLoaded) {
          final previousState = state as TrendingMoviesLoaded;
          final updatedMovies = List<Movie>.from(previousState.movies)
            ..addAll(movies);
          emit(TrendingMoviesLoaded(updatedMovies));
        } else {
          emit(TrendingMoviesLoaded(movies));
        }
      });
    });
  }
}
