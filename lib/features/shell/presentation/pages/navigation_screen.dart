import 'package:flutter/material.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';
import 'package:fortnite_app/features/island/presentation/pages/island_screen.dart';
import 'package:fortnite_app/features/items/presentation/pages/home_screen.dart';
import 'package:fortnite_app/features/news/presentation/pages/news_screen.dart';
import 'package:fortnite_app/features/players/presentation/pages/player_screen.dart';
import 'package:fortnite_app/features/shop/presentation/pages/shop_screen.dart';

const List<Widget> _screens = <Widget>[
  HomeScreen(),
  NewsScreen(),
  ShopScreen(),
  PlayerScreen(),
  IslandScreen(),
];

class NavegationScreen extends StatefulWidget {
  const NavegationScreen({super.key});

  @override
  State<NavegationScreen> createState() => _NavegationScreenState();
}

class _NavegationScreenState extends State<NavegationScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final channel = kChannelColors[selectedIndex];
    return Scaffold(
      backgroundColor: kGround,
      body: _screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: channel,
        indicatorColor: kGround,
        selectedIndex: selectedIndex,
        onDestinationSelected: (int newIndex) {
          setState(() => selectedIndex = newIndex);
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: ExcludeSemantics(child: Icon(Icons.home_rounded)),
            label: 'Armas',
          ),
          NavigationDestination(
            icon: ExcludeSemantics(child: Icon(Icons.newspaper_rounded)),
            label: 'Noticias',
          ),
          NavigationDestination(
            icon: ExcludeSemantics(child: Icon(Icons.shopping_bag_rounded)),
            label: 'Tienda',
          ),
          NavigationDestination(
            icon: ExcludeSemantics(child: Icon(Icons.query_stats_rounded)),
            label: 'Cuenta',
          ),
          NavigationDestination(
            icon: ExcludeSemantics(child: Icon(Icons.map_rounded)),
            label: 'Mapa',
          ),
        ],
      ),
    );
  }
}
