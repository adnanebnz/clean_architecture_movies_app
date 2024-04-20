import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GenreListShimmer extends StatelessWidget {
  final int itemCount;

  const GenreListShimmer({super.key, this.itemCount = 8});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!.withAlpha(100),
      highlightColor: Colors.grey[300]!.withAlpha(100),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(itemCount, (index) {
            return Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Container(
                width: 50,
                height: 14,
                color: Colors.white,
              ),
            );
          }),
        ),
      ),
    );
  }
}
