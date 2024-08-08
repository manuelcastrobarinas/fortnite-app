import 'package:flutter/material.dart';
import 'package:fortnite_app/contants.dart';

import '../views/player_view.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          title: const Text('Estadisticas de Usuario', style: TextStyle(color: Colors.black, fontSize: 26)),
          toolbarHeight: 100,
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black, size: 30),
              onPressed: () {}, //TODO: HACER EL DELEGATE
            ),
            const SizedBox(width: 20.0)
          ],
        ),
        body: const PlayerView()
      )
    );
  }
}