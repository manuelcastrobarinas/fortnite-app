import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../contants.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(height: 30),
            const _FortniteImageAndShields(),
            const _Banner(),
            Expanded(
              flex  : 1,
              child : ButtonComponent(text:'PRESS TO START', size: size, route: 'main')
            )
          ],
        ),
      ),
    );
  }
}


class _FortniteImageAndShields extends StatelessWidget {
const _FortniteImageAndShields();

@override
Widget build(BuildContext context) {
  return const Expanded( 
      flex: 4,
      child : SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image(
                image: AssetImage("assets/loading/5.png"),
                fit: BoxFit.fill,
              )
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
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner();
  //este metodo muestra una forma diferente de definir propiedades dentro de un text para añadir las que necesite
  //sin embargo es importante entender que este metodo aunque es efectivo es menos eficiente, pues debe hacer que el widget se construya cada vez que se llama la pantalla 
  @override
  Widget build(BuildContext context) {
    const TextStyle text = TextStyle(fontFamily: 'fortnite', color: kPrimaryTextColor);
    return Expanded( 
      flex :1,
      child: Column(
        children: [
          Expanded(
            flex : 1,
            child: Text("FORTNITE",      style: text.copyWith(fontSize: 70))
          ),
          Expanded(
            flex  : 1,
            child : Text("BATTLE ROYALE", style: text.copyWith(fontSize: 36))
          ),
        ],
      )
    );
  }
}