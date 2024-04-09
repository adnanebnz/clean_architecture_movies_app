import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/genre.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/injection_container.dart';
import 'package:movies_app/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movies_app/presentation/bloc/local_fav_movies/local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movie_trailer/movie_trailer_bloc.dart';
import 'package:movies_app/presentation/widgets/genres_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SingleMovieScreen extends StatefulWidget {
  const SingleMovieScreen({super.key, required this.movie});

  final Movie movie;

  @override
  State<SingleMovieScreen> createState() => _SingleMovieScreenState();
}

class _SingleMovieScreenState extends State<SingleMovieScreen> {
  late YoutubePlayerController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<MovieTrailerBloc>()..add(GetMovieTrailer(widget.movie.title)),
      child: BlocBuilder<MovieTrailerBloc, MovieTrailerState>(
        builder: (context, state) {
          if (state is MovieTrailerLoaded) {
            _controller = YoutubePlayerController(
              initialVideoId: state.videos[0].videoId!,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            );
          } else if (state is MovieTrailerError) {
            return Scaffold(
                body: Center(child: Text('Error: ${state.message}')));
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
          return YoutubePlayerBuilder(
            builder: (context, player) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ),
                body: ListView(
                  children: [
                    Image.network(
                      widget.movie.posterPath == ""
                          ? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"
                          : 'https://image.tmdb.org/t/p/w500/${widget.movie.posterPath}',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 20,
                                        ),
                                        Text(
                                          widget.movie.voteAverage
                                              .toStringAsFixed(2),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // vote count
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.people,
                                          size: 20,
                                        ),
                                        Text(
                                          widget.movie.voteCount.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                widget.movie.releaseDate,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          // is adult
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              BlocBuilder<LocalFavMoviesBloc,
                                  LocalFavMoviesState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
                                      overlayColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.hovered)) {
                                            return Colors.white
                                                .withOpacity(0.04);
                                          }
                                          if (states.contains(
                                                  MaterialState.focused) ||
                                              states.contains(
                                                  MaterialState.pressed)) {
                                            return Colors.white
                                                .withOpacity(0.12);
                                          }
                                          return null; // Defer to the widget's default.
                                        },
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: const BorderSide(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      context.read<LocalFavMoviesBloc>().add(
                                            AddLocalFavMovieEvent(widget.movie),
                                          );
                                    },
                                    child: const Text('Add to Favorites'),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Genres",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          // ADD MOVIE TO FAV
                          BlocBuilder<GenresBloc, GenresState>(
                            builder: (context, state) {
                              if (state is GenresLoaded) {
                                List<Genre> movieGenres = state.genres
                                    .where((genre) => widget.movie.genreIds
                                        .contains(genre.id))
                                    .toList();

                                return GenreList(genres: movieGenres);
                              } else if (state is GenresError) {
                                return Text('Error: ${state.message}');
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          const SizedBox(height: 14),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Synopsis",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              widget.movie.overview,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          )
                        ],
                      ),
                    ),
                    player
                  ],
                ),
              );
            },
            player: YoutubePlayer(controller: _controller),
          );
        },
      ),
    );
  }
}
