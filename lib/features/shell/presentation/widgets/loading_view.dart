import 'package:flutter/material.dart';

import 'package:fortnite_app/core/widgets/widgets.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = (constraints.maxHeight * 0.46).clamp(180.0, 420.0);
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: imageHeight, child: const _FortniteImageAndShields()),
                const _Banner(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
                  child: ButtonComponent(
                    text: 'PRESIONA INICIAR',
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    route: 'main',
                    isBack: false,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class _FortniteImageAndShields extends StatelessWidget {
const _FortniteImageAndShields();

@override
Widget build(BuildContext context) {
  return const Stack(
    fit: StackFit.expand,
    children: [
      Image(
        image: AssetImage("assets/loading/5.png"),
        fit: BoxFit.contain,
      ),
      Positioned(
        left: -55,
        bottom: 30,
        child: SizedBox(
          width : 140,
          height: 140,
          child: Image(
            image: AssetImage("assets/loading/slurp_bottle.png")
          )
        ),
      ),
      Positioned(
        right: -20,
        bottom: 0,
        child: SizedBox(
          width : 100,
          height: 100,
          child: Image(
            image: AssetImage("assets/loading/big.png")
          )
        ),
      ),
    ],
  );
}
}

class _Banner extends StatelessWidget {
  const _Banner();
  //este metodo muestra una forma diferente de definir propiedades dentro de un text para añadir las que necesite
  //sin embargo es importante entender que este metodo aunque es efectivo es menos eficiente, pues debe hacer que el widget se construya cada vez que se llama la pantalla 
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            'FORTNITE',
            style: TextStyle(fontFamily: kPrimaryFont, color: kInk, fontSize: 56, height: 1),
          ),
          SizedBox(height: 4),
          Text(
            'BATTLE ROYALE',
            style: TextStyle(
              color: kInk,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.4,
            ),
          ),
        ],
      ),
    );
  }
}