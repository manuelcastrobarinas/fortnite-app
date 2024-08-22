import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fortnite_app/contants.dart';

import '../../screens.dart';

List<Widget> _navigationItems = <Widget> [
    const Icon(Icons.home_rounded),
    const Icon(Icons.newspaper_rounded),
    const Icon(Icons.shopping_bag_rounded),
    const Icon(Icons.query_stats_rounded),
  ];

//PANTALLAS A LAS CUALES VA A NAVEGAR 
  final List<StatelessWidget> _screens = <StatelessWidget> [
    const HomeScreen(),
    const NewsScreen(),
    const ShopScreen(),
    const PlayerScreen(),
  ];

//COLORES DE FONDO DE LAS PANTALLAS
  final List<Color> _backgroundScreenColors = <Color>[
    kBackgroundColor,
    kBackgroundColor,
    Colors.white,
    kBackgroundColor,
  ];

//COLORES DE LA NAVEGACION DE LA BARRA
  final List<Color> _backgroundNavigatorColors = <Color>[
    Colors.white,
    Colors.white,
    kBackgroundColor,
    Colors.white,
  ];

class NavegationScreen extends StatefulWidget {
  const NavegationScreen({super.key});

  @override
  State<NavegationScreen> createState() => _NavegationScreenState();
}

class _NavegationScreenState extends State<NavegationScreen> {
  int selectedIndex = 0;
  Color backgroundColor = kBackgroundColor;
  Color backgroundNavigatorColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    //EVALUA EL INDICE EN EL QUE EL USUARIO SE ENCUENTRA Y NAVEGA A LA PANTALLA QUE CORRESPONDE A ESE INDICE 
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: selectedIndex,
        items: _navigationItems,
        backgroundColor: backgroundColor,
        height: 65.0,
        buttonBackgroundColor: backgroundNavigatorColor,
        color: backgroundNavigatorColor,
        onTap: (int newIndex) {
          setState(() {
            selectedIndex = newIndex;
            backgroundColor = _backgroundScreenColors[newIndex];
            backgroundNavigatorColor = _backgroundNavigatorColors[newIndex];
          });
        },          
      ),
      body: _screens[selectedIndex],
    );
  }
}