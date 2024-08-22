import 'package:flutter/material.dart';

//genera una interfaz de usuario  que muestra una lista de elementos (secciones estadísticas) en un diseño de filas automatico, 
//donde cada fila puede contener hasta 3 elementos. 
//Entre los elementos de cada fila se puede agregar un separador vertical, excepto después del último elemento de la fila.

class StadisticsWaponsComponent extends StatelessWidget {

  final List<StadisticSections> listStadistics;
  final double? radius;
  
  const StadisticsWaponsComponent({
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
        color:  const Color.fromRGBO(78, 129, 234, 1),
        borderRadius: BorderRadius.circular(radius ?? 40),
        boxShadow: const [
          BoxShadow(
            color:Color.fromRGBO(78, 129, 234, 1),
            offset: Offset(0, 6),
            blurRadius: 20
          )
        ]
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              children: List.generate(
                (listStadistics.length / 2).ceil(), // Número de filas necesarias
                (index) {
                  int startIndex = index * 2;
                  int endIndex = startIndex + 2;
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
      color: const Color.fromARGB(170, 255, 255, 255),
      width: 1,
      height: 45,
    );
  }
}

class StadisticSections extends StatelessWidget {
  final String title;
  final String value;

  const StadisticSections({
    super.key, 
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    const  TextStyle titleStyle = TextStyle(color: Colors.white, fontSize: 14.0, overflow: TextOverflow.ellipsis); 
    const  TextStyle valueStyle = TextStyle(color: Colors.white, fontSize: 26.0, overflow: TextOverflow.ellipsis); 

    return SizedBox(
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment : MainAxisAlignment.start,
              children: [
                SizedBox(
                  // color: Colors.red,
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Text(value, style: valueStyle, maxLines: 1)
                ),
                const SizedBox(width: 4.0),
                SizedBox(
                  // color: Colors.amber,
                  width: MediaQuery.of(context).size.width * 0.22,
                  child: Text(title, style: titleStyle, maxLines: 2),
                ),
              ],
            ),
      ),
    );
  }
}