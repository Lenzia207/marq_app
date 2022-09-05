import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

@override
class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;

// ignore: use_key_in_widget_constructors
  const ShimmerWidget.rectangular({
    this.width = double.infinity,
    required this.height,
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          width: width,
          height: height,
          color: Colors.grey,
        ),
      );
}
