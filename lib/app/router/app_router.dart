import 'package:flutter/material.dart';
import 'package:fortnite_app/features/items/presentation/pages/home_screen.dart';
import 'package:fortnite_app/features/news/presentation/pages/news_screen.dart';
import 'package:fortnite_app/features/players/presentation/pages/player_screen.dart';
import 'package:fortnite_app/features/shell/presentation/pages/loading_screen.dart';
import 'package:fortnite_app/features/shell/presentation/pages/navigation_screen.dart';
import 'package:fortnite_app/features/shop/presentation/pages/shop_screen.dart';

/// Nombres de rutas centralizados: la navegación siempre usa estas
/// constantes, nunca strings sueltos.
abstract class AppRoutes {
  static const String loading = 'loading';
  static const String main = 'main';
  static const String home = 'home';
  static const String news = 'news';
  static const String shop = 'shop';
  static const String player = 'player';
}

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.loading: (_) => const LoadingScreen(),
  AppRoutes.main: (_) => const NavegationScreen(),
  AppRoutes.home: (_) => const HomeScreen(),
  AppRoutes.news: (_) => const NewsScreen(),
  AppRoutes.shop: (_) => const ShopScreen(),
  AppRoutes.player: (_) => const PlayerScreen(),
};
