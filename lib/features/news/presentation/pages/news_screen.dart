import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';
import 'package:fortnite_app/core/widgets/error_retry_view.dart';
import 'package:fortnite_app/features/news/domain/entities/news.dart';
import 'package:fortnite_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:fortnite_app/features/news/presentation/widgets/news_view.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Future<NewsModel>? _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _future ??= context.read<NewsBloc>().getNews();
  }

  void _retry() {
    setState(() {
      _future = context.read<NewsBloc>().getNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: FutureBuilder<NewsModel>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return ErrorRetryView(
              message: snapshot.error.toString(),
              onRetry: _retry,
            );
          }
          if (!snapshot.hasData) return const Center(child: Text('No hay datos'));
          return const NewsView();
        },
      ),
    );
  }
}
