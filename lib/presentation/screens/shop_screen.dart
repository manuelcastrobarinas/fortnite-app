import 'package:flutter/material.dart';
import 'package:fortnite_app/presentation/views/shop_view.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: ShopView(),
    );
  }
}