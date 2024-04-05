import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/usecases/local/add_fav_movie.dart';

part 'save_local_fav_movies_event.dart';
part 'save_local_fav_movies_state.dart';

class SaveLocalFavMoviesBloc
    extends Bloc<SaveLocalFavMoviesEvent, SaveLocalFavMoviesState> {
  AddFavMovie addFavMovie;
  SaveLocalFavMoviesBloc({required this.addFavMovie})
      : super(SaveLocalFavMoviesInitial()) {
    on<SaveLocalFavMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
