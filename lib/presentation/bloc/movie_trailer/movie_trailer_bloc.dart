import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/core/exceptions/failure.dart';
import 'package:movies_app/core/managers/youtube_api_manager.dart';
import 'package:youtube_data_api/models/video.dart';

part 'movie_trailer_event.dart';
part 'movie_trailer_state.dart';

class MovieTrailerBloc extends Bloc<MovieTrailerEvent, MovieTrailerState> {
  MovieTrailerBloc() : super(MovieTrailerInitial()) {
    on<GetMovieTrailer>((event, emit) async {
      emit(MovieTrailerLoading());
      try {
        final List res = await YoutubeDataApiManager.getYoutubeApi()
            .fetchSearchVideo(
                "${event.query} Official Trailer", dotenv.env['YT_API_KEY']!);
        List<Video> videos = res.whereType<Video>().toList();

        emit(MovieTrailerLoaded(videos));
      } catch (e) {
        emit(MovieTrailerError(Failure(message: e.toString()).toString()));
      }
    });
  }
}
