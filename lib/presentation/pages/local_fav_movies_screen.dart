import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/bloc/local_fav_movies/local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/pages/single_movie_screen.dart';
import 'package:movies_app/presentation/widgets/movie_card.dart';

class LocalFavMoviesScreen extends StatefulWidget {
  const LocalFavMoviesScreen({super.key});

  @override
  State<LocalFavMoviesScreen> createState() => _LocalFavMoviesScreenState();
}

class _LocalFavMoviesScreenState extends State<LocalFavMoviesScreen> {
  List<Movie> selectedMovies = [];

  @override
  void initState() {
    super.initState();
    context.read<LocalFavMoviesBloc>().add(const FetchLocalFavMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalFavMoviesBloc, LocalFavMoviesState>(
      builder: (context, state) {
        if (state is LocalFavMoviesLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is LocalFavMoviesLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: selectedMovies.isEmpty
                  ? const Text("Favorite Movies")
                  : Text("${selectedMovies.length} selected"),
              actions: [
                if (selectedMovies.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      if (selectedMovies.isNotEmpty) {
                        context.read<LocalFavMoviesBloc>().add(
                            DeleteLocalFavMovieEvent(selectedMovies.toList()));
                        setState(() {
                          selectedMovies.clear();
                        });
                      } else {
                        log("No movies selected");
                      }
                    },
                  ),
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: state.movies.length != 0
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: state.movies.length,
                        itemBuilder: (context, index) {
                          final movie = state.movies[index];
                          return GestureDetector(
                            onLongPress: () {
                              setState(() {
                                if (selectedMovies.contains(movie)) {
                                  selectedMovies.remove(movie);
                                } else {
                                  selectedMovies.add(movie);
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: selectedMovies.contains(movie)
                                    ? Border.all(
                                        color: Colors.blue,
                                        width: 1.5,
                                      )
                                    : null,
                              ),
                              child: MovieCard(
                                movie,
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SingleMovieScreen(movie: movie)),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          "No movies found",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
          );
        }
        if (state is LocalFavMoviesError) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
