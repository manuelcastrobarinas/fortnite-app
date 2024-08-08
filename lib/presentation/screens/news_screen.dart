import 'package:flutter/material.dart';
import 'package:fortnite_app/contants.dart';
import 'package:fortnite_app/presentation/views/news_views.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackgroundColor,
      body: NewsView()
    );
  }
}