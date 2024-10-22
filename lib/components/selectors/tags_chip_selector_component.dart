import 'package:flutter/material.dart';

import '../../contants.dart';

class ChoiceChipSelectComponent extends StatelessWidget {

  final int defaultChoiseIndex;     //INDICE DEL CHIP SELECCIONADO
  final List<String> choisesList;   //LISTA DE ELEMENTOS PARA CADA UNO DE LOS CHOISE
  final void Function(int) onSelected;  //fUNCION DE EJECUCION 

  const ChoiceChipSelectComponent({
    super.key, 
    required this.choisesList,
    required this.defaultChoiseIndex,
    required this.onSelected
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:  List.generate(
              choisesList.length, 
              (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ChoiceChip(
                    labelPadding: const EdgeInsets.all(2.0),
                    label: Text(choisesList[index], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), 
                    selected: defaultChoiseIndex == index,
                    selectedColor: kPrimaryColor,
                    disabledColor: kPrimaryColorVariant,
                    backgroundColor: kPrimaryColorVariant,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    onSelected: (value) {
                        onSelected(index);
                    },
                  ),
                );
              } 
            ),
          )
        )
      ),
    );
  }
}