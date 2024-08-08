import 'package:flutter/material.dart';
import 'package:fortnite_app/presentation/views/loading_view.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadingView()
    );
  }
}