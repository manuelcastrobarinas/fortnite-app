import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fortnite_app/blocs/items/items_bloc.dart';
import 'package:fortnite_app/blocs/news/news_bloc.dart';
import 'package:fortnite_app/blocs/player/player_bloc.dart';
import 'package:fortnite_app/contants.dart';
import 'package:fortnite_app/routes/routes.dart';
import 'package:fortnite_app/services/items/items.dart';
import 'package:fortnite_app/services/news/news.dart';
import 'package:fortnite_app/services/players/player.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ItemsBloc> (create:  (BuildContext context) => ItemsBloc(itemServices: ItemServices())),
        BlocProvider<NewsBloc>  (create:  (BuildContext context) => NewsBloc(newsServices: NewsServices())),
        BlocProvider<PlayerBloc>(create:  (BuildContext context) => PlayerBloc(playerServices: PlayerServices())),
      ],
      child: const MyApp()
    )
  );   
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fortnite Flutter App',
      theme: ThemeData(
        colorScheme : ColorScheme.fromSeed(seedColor: kPrimaryColor),
        useMaterial3: false,
        primaryColor: kPrimaryColor,
        fontFamily  : kPrimaryFont,
      ),
      routes: routes,
      initialRoute: 'loading',
    );
  }
} 