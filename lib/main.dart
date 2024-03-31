import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/injection_container.dart';
import 'package:movies_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'package:movies_app/presentation/pages/home_screen.dart';

void main() async {
  init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<TrendingMoviesBloc>()..add(FetchTrendingMovies()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<PopularMoviesBloc>()..add(FetchPopularMovies()),
        ),
        BlocProvider(
          create: (context) => getIt<SearchMoviesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Lato"),
        home: const HomeScreen(),
      ),
    );
  }
}
