import 'package:flutter/material.dart';
import 'package:fortnite_app/contants.dart';
import 'package:fortnite_app/presentation/views/home_view.dart';
import 'package:fortnite_app/presentation/views/painters/left_waves_painter_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            LeftWavesPainterView(colorWave: Colors.white),
            HomeView(),
          ],
        )
      ),
    );
  }
}