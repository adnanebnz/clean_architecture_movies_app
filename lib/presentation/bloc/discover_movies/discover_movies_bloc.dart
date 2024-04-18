import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/utils/filter_params.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/usecases/remote/discover_movies.dart';

part 'discover_movies_event.dart';
part 'discover_movies_state.dart';

class DiscoverMoviesBloc
    extends Bloc<DiscoverMoviesEvent, DiscoverMoviesState> {
  final DiscoverMovies discoverMovies;
  int currentPage = 1;

  DiscoverMoviesBloc({required this.discoverMovies})
      : super(DiscoverMoviesInitial()) {
    on<FetchDiscoverMovies>((event, emit) async {
      emit(DiscoverMoviesLoading());
      final failureOrMovies =
          await discoverMovies(currentPage, event.filterParams);
      failureOrMovies.fold(
          (failure) => emit(DiscoverMoviesError(message: failure.message)),
          (movies) => emit(DiscoverMoviesLoaded(movies: movies)));
    });
    on<FetchNextPage>((event, emit) async {
      currentPage = event.pageKey;
      emit(DiscoverMoviesLoading());
      final failureOrMovies =
          await discoverMovies(currentPage, event.filterParams);
      failureOrMovies.fold(
          (failure) => emit(DiscoverMoviesError(message: failure.message)),
          (movies) => emit(DiscoverMoviesLoaded(movies: movies)));
    });
  }
}
