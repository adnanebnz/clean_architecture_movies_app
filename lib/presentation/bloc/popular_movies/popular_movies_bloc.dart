import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  int currentPage = 1;
  PopularMoviesBloc({required this.getPopularMovies})
      : super(PopularMoviesInitial()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());
      final failureOrMovies = await getPopularMovies(currentPage);
      failureOrMovies.fold(
          (failure) => emit(PopularMoviesError(failure.message)),
          (movies) => emit(PopularMoviesLoaded(movies)));
    });
    on<FetchNextPage>((event, emit) async {
      currentPage = event.pageKey;
      emit(PopularMoviesLoading());
      final failureOrMovies = await getPopularMovies(currentPage);
      failureOrMovies.fold(
          (failure) => emit(PopularMoviesError(failure.message)), (movies) {
        if (state is PopularMoviesLoaded) {
          final previousState = state as PopularMoviesLoaded;
          final updatedMovies = List<Movie>.from(previousState.movies)
            ..addAll(movies);
          emit(PopularMoviesLoaded(updatedMovies));
        } else {
          emit(PopularMoviesLoaded(movies));
        }
      });
    });
  }
}
