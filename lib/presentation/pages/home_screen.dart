import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movies_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_state.dart';
import 'package:movies_app/presentation/pages/popular_movies_screen.dart';
import 'package:movies_app/presentation/pages/trending_movies_screen.dart';
import 'package:movies_app/presentation/widgets/genre_list_shimmer.dart';
import 'package:movies_app/presentation/widgets/genres_list.dart';
import 'package:movies_app/presentation/widgets/movies_list.dart';
import 'package:movies_app/presentation/widgets/movies_list_shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(18, 18, 18, 1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Default Image
              Container(
                height: 180,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1616530940355-351fabd9524b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Genres",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<GenresBloc, GenresState>(
                builder: (context, state) {
                  if (state is GenresLoading) {
                    return const GenreListShimmer();
                  } else if (state is GenresLoaded) {
                    return GenreList(genres: state.genres);
                  }
                  return const SizedBox();
                },
              ),
              // Trending Movies
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      'Trending Movies',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TrendingMoviesScreen()));
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
                  builder: (context, state) {
                    if (state is TrendingMoviesLoading) {
                      return const MoviesListShimmer();
                    } else if (state is TrendingMoviesLoaded) {
                      return MoviesList(movies: state.movies);
                    } else if (state is TrendingMoviesError) {
                      return Text(state.message);
                    }
                    return Container();
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              // Popular Movies
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      'Popular Movies',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PopularMoviesScreen()));
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                  builder: (context, state) {
                    if (state is PopularMoviesLoading) {
                      return const MoviesListShimmer();
                    } else if (state is PopularMoviesLoaded) {
                      return MoviesList(movies: state.movies);
                    } else if (state is PopularMoviesError) {
                      return Text(state.message);
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
