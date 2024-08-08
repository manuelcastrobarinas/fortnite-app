import 'package:flutter/material.dart';
import 'package:fortnite_app/presentation/screens/navegation/main_screen.dart';

import 'package:fortnite_app/presentation/screens.dart';

Map<String, Widget Function(BuildContext)> routes = {
  'loading' : (_) => const LoadingScreen(),
  'main'    : (_) => const MainScreen(),
  'home'    : (_) => const HomeScreen(),
  'news'    : (_) => const NewsScreen(),
  'shop'    : (_) => const ShopScreen(),
  'player'  : (_) => const PlayerScreen(),
};