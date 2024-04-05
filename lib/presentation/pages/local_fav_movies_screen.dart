import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/presentation/bloc/get_local_fav_movies/get_local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/pages/single_movie_screen.dart';
import 'package:movies_app/presentation/widgets/movie_card.dart';

class LocalFavMoviesScreen extends StatefulWidget {
  const LocalFavMoviesScreen({super.key});

  @override
  State<LocalFavMoviesScreen> createState() => _LocalFavMoviesScreenState();
}

class _LocalFavMoviesScreenState extends State<LocalFavMoviesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetLocalFavMoviesBloc>().add(GetLocalFavMoviesEventGet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite movies"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: BlocBuilder<GetLocalFavMoviesBloc, GetLocalFavMoviesState>(
            builder: (context, state) {
          if (state is GetLocalFavMoviesLoading) {
            return const CircularProgressIndicator();
          } else if (state is GetLocalFavMoviesError) {
            return Center(child: Text(state.message));
          } else if (state is GetLocalFavMoviesSuccess) {
            return GridView.builder(
              itemCount: state.movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.75,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard(
                  movie,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleMovieScreen(movie: movie),
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
