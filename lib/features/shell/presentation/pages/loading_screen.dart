import 'package:flutter/material.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';
import 'package:fortnite_app/features/shell/presentation/widgets/loading_view.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kGround,
      body: LoadingView(),
    );
  }
}