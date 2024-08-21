import 'package:flutter/material.dart';
import 'package:fortnite_app/contants.dart';
import 'package:fortnite_app/presentation/views/painters/painters.dart';
import 'package:fortnite_app/presentation/views/shop_view.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Tienda Hoy', style: TextStyle(color: Colors.black, fontSize: 38), maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black, size: 40,)),
          const SizedBox(width: 40.0)
        ],
      ),
      body:  const Stack(
          children: [
            LeftWavesPainterView(colorWave: kBackgroundColor),
            ShopView(),
          ],
        )
    );
  }
}