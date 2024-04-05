import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/usecases/remote/get_trending_movies.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_state.dart';

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
        (movies) => emit(TrendingMoviesLoaded(movies, currentPage + 1)),
      );
    });

    on<FetchNextPage>((event, emit) async {
      currentPage = event.pageKey;
      emit(TrendingMoviesLoading());
      final failureOrMovies = await getTrendingMovies(currentPage);
      failureOrMovies.fold(
        (failure) => emit(TrendingMoviesError(failure.message)),
        (movies) {
          final nextPageKey = movies.isEmpty ? null : currentPage + 1;
          emit(TrendingMoviesLoaded(movies, nextPageKey));
        },
      );
    });
  }
}
