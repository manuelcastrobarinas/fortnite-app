import 'package:flutter/material.dart';
import '../../contants.dart';

//genera una interfaz de usuario  que muestra una lista de elementos (secciones estadísticas) en un diseño de filas automatico, 
//donde cada fila puede contener hasta 3 elementos. 
//Entre los elementos de cada fila se puede agregar un separador vertical, excepto después del último elemento de la fila.

class StadisticsComponentMultipleRows extends StatelessWidget {

  final List<StadisticSection> listStadistics;
  final double? radius;
  
  const StadisticsComponentMultipleRows({
    super.key,
    required this.listStadistics,
    this.radius
  });

  @override
 Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      width : double.infinity,
      decoration: BoxDecoration(
        color:  kPrimaryColor,
        borderRadius: BorderRadius.circular(radius ?? 100),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 3
          )
        ]
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: List.generate(
            (listStadistics.length / 3).ceil(), // Número de filas necesarias
            (index) {
              int startIndex = index * 3;
              int endIndex = startIndex + 3;
              if (endIndex > listStadistics.length) {
                endIndex = listStadistics.length;
              }
              return Column(
                children: [
                  Row(
                    children: List.generate(
                      endIndex - startIndex, // Número de elementos en esta fila
                      (subIndex) {
                        return Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: listStadistics[startIndex + subIndex],
                                ),
                                // Agregar el separador solo si no es el último elemento en la fila
                                if (subIndex < (endIndex - startIndex - 1))
                                  const _StadisticSeparator(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          )
        ),
      ),
    );
  }
}


class _StadisticSeparator extends StatelessWidget {
  const _StadisticSeparator();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 1,
      height: 45,
    );
  }
}

class StadisticSection extends StatelessWidget {
  final String title;
  final String description;
  final String value;

  const StadisticSection({
    super.key, 
    required this.title,
    required this.description,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    const  TextStyle titleStyle        = TextStyle(color: kPrimaryTextColor, fontSize: 22.0, overflow: TextOverflow.ellipsis); 
    const  TextStyle descriptionStyle  = TextStyle(color: Colors.white, fontSize: 12.0, overflow: TextOverflow.ellipsis); 
    const  TextStyle valueStyle        = TextStyle(color: Colors.white, fontSize: 18.0, overflow: TextOverflow.ellipsis); 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        // color: Colors.red,
        child: Column(
          mainAxisAlignment : MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              // color: Colors.amber,
              child: Text(title, style: titleStyle),
            ),
            const SizedBox(height: 5.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment : MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    // color: Colors.orange,
                    child: Text(value, style: valueStyle, maxLines: 1)
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    // color: Colors.pink,
                    child: Text(description, style: descriptionStyle, maxLines: 2)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}