import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            const _FortniteImageAndShields(),
            const _Banner(),
            _Button(size: size)
          ],
        ),
      )
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

class _Button extends StatelessWidget {
  const _Button({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded( 
      flex :1,
      child: SizedBox(
        // color: Colors.orange,
        child: Center(
          child: Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: const LinearGradient(
                stops: [
                  0.05,
                  1
                ],
                colors: [
                  Color.fromARGB(213, 105, 208, 255),
                  Color.fromARGB(255, 31, 170, 239)
                ]
              ),
              boxShadow: const [
                BoxShadow(
                  color:Color.fromARGB(205, 213, 242, 255),
                  blurRadius: 8,
                  offset: Offset(0, 12),
                )
              ]
            ),
            child: MaterialButton(
              padding : const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              minWidth: size.width * 0.7,
              height  : 60,
              elevation : 0,
              shape : const  StadiumBorder(),
              child : const Text(
                'PRESS TO START', 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 18, 
                  fontFamily: 'fortnite'
                )
              ),
              onPressed: () {}
            ),
          ),
        )
      )
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    return const Expanded( 
      flex :1,
      child: SizedBox(
        child: Column(
          children: [
            Text("FORTNITE", style: TextStyle(fontFamily: 'fortnite', fontSize: 70, color: Color.fromRGBO(40, 52, 83, 1))),
            Text("BATTLE ROYALE", style: TextStyle(fontFamily: 'fortnite', fontSize: 36, color: Color.fromRGBO(40, 52, 83, 1))),
          ],
        ),
      )
    );
  }
}