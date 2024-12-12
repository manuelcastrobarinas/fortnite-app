import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/blocs/news/news_bloc.dart';

import 'package:fortnite_app/contants.dart';

import '../../models/news/news.dart';
import '../views/news_views.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsBloc newsBloc = BlocProvider.of<NewsBloc>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: FutureBuilder(
        future: newsBloc.getNews(), 
        builder: (BuildContext context, AsyncSnapshot<NewsModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.connectionState == ConnectionState.none)    return const Center(child: Text("No hay conexión"));
          if (snapshot.hasError || snapshot.error == true)         return Center(child: Text(snapshot.error.toString()));
          if (!snapshot.hasData) return const Center(child: Text("No hay datos"));
          return const NewsView();
        }
      )
    );
  }
}
