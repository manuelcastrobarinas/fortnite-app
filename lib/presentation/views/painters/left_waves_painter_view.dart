import 'package:flutter/material.dart';
import 'package:fortnite_app/contants.dart';

class LeftWavesPainterView extends StatelessWidget {

  final Color? colorWave;
  
  const LeftWavesPainterView({
    super.key,
    this.colorWave
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width : double.infinity,
      child : CustomPaint(
        painter: _LeftWavesPainter(colorWave: colorWave),
      ),
    );
  }
}

class _LeftWavesPainter extends CustomPainter {
  final Color? colorWave;

  _LeftWavesPainter({
    this.colorWave
  }); 
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    final Path path   = Path();

    paint.color = colorWave ?? kBackgroundColor;
    paint.strokeWidth = 10;
    paint.style = PaintingStyle.fill;


    path.lineTo(size.width * 0.0, size.height * 0.06);

    path.quadraticBezierTo(
      size.width * 0.20,   size.height * 0.12,
      size.width * 0.19,   size.height * 0.2245
    );

    path.quadraticBezierTo(
      size.width * 0.19,   size.height * 0.2745,
      size.width * 0.12,   size.height * 0.34045   
    );


    path.quadraticBezierTo(
      size.width * 0.06,   size.height * 0.4095,
      size.width * 0.11,   size.height * 0.518
    );

    path.quadraticBezierTo(
      size.width * 0.14,   size.height * 0.618,
      size.width * 0.0,    size.height * 0.66
    );

    path.lineTo(0, 0);
    path.lineTo(0, 0);
  

    //DIBUJAR EL LIENZO
    canvas.drawPath(path, paint);
  
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw true;
  }


}

  //VALORES DE LA CURVA EN PANTALLA COMPLETA
  // path.lineTo(size.width * 0.05, size.height * 0.0);


  // path.quadraticBezierTo(
  //   size.width * 0.166,  size.height * 0.17,
  //   size.width * 0.333,  size.height * 0.1
  // );
  
  // path.quadraticBezierTo(
  //   // size.width * 0.333,  size.height * 0.2,
  //   size.width * 0.499,  size.height * 0.02,
  //   size.width * 0.716,  size.height * 0.10
  // );

  //  path.quadraticBezierTo(
  //   size.width * 0.896,  size.height * 0.16,
  //   size.width * 1,   size.height * 0.0
  // );

  // path.lineTo(size.width, 0);
  // path.lineTo(0, 0);


//VALORES DE LA CURVA EN PANTALLA COMPLETA
  // path.quadraticBezierTo(
    //   size.width * 0.17,  size.height * 0.166,
    //   size.width * 0.1,  size.height  * 0.333
    // );
    
    // path.quadraticBezierTo(
    //   // size.width * 0.333,  size.height * 0.2,
    //   size.width * 0.02,  size.height * 0.499,
    //   size.width * 0.10,  size.height * 0.716,
    // );

    //  path.quadraticBezierTo(
    //   size.width * 0.16,  size.height * 0.896,
    //   size.width * 0.0,   size.height * 1
    // );