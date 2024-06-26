import 'package:flutter/material.dart';
import 'package:movies_app/presentation/widgets/movie_card_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class MoviesListShimmer extends StatelessWidget {
  final int itemCount;

  const MoviesListShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!.withAlpha(100),
      highlightColor: Colors.grey[300]!.withAlpha(100),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(itemCount, (index) {
            return const MovieCardShimmer();
          }),
        ),
      ),
    );
  }
}
