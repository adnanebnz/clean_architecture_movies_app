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
      final failureOrMovies = await getPopularMovies(currentPage);
      failureOrMovies.fold(
          (failure) => emit(PopularMoviesError(failure.toString())),
          (movies) => emit(PopularMoviesLoaded(movies)));
    });
    on<FetchNextPage>((event, emit) async {
      if (state is! PopularMoviesLoaded) {
        emit(PopularMoviesLoading());

        currentPage++;
        final failureOrMovies = await getPopularMovies(currentPage);
        failureOrMovies
            .fold((failure) => emit(PopularMoviesError(failure.toString())),
                (movies) {
          final previousState = state as PopularMoviesLoaded;
          final updatedMovies = List<Movie>.from(previousState.movies)
            ..addAll(movies);
          emit(PopularMoviesLoaded(updatedMovies));
        });
      }
    });
  }
}
