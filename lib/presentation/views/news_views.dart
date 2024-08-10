import 'package:flutter/material.dart';
import 'package:fortnite_app/presentation/views/painters/painters.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LeftWavesPainterView(
      colorWave: Colors.white,
    );
  }
}