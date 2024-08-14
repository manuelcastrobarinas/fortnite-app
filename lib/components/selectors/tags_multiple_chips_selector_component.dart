import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:fortnite_app/contants.dart';

class TagsMultipleChipSelectorComponent extends StatefulWidget {

  const TagsMultipleChipSelectorComponent({
    super.key,
  });

  @override
  State<TagsMultipleChipSelectorComponent> createState() => _TagsMultipleChipSelectorComponentState();
}

class _TagsMultipleChipSelectorComponentState extends State<TagsMultipleChipSelectorComponent> {
  //listas para los CHIP  
   List<String> tags = ['Destacados'];  //CHIPS SELECCIONADOS
  // lISTA COMPLETA DE CHIPS
  List<String> options = [
    'Todos',
    'Destacados',
    'Sin Categoria',
    'Sube al Escenario',
    'Paquetes',
    'Star Wars',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ChipsChoice<String>.multiple(
        choiceStyle: C2ChipStyle.filled(
          foregroundStyle: const TextStyle(color: Colors.white, fontFamily: 'fortnite', fontSize: 16),
          color: kPrimaryColorVariant,
          borderRadius: BorderRadius.circular(20),
          selectedStyle: const C2ChipStyle(
            backgroundColor: kPrimaryColor,
            foregroundStyle: TextStyle(color: Colors.white, fontFamily: 'fortnite', fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        value: tags,
        onChanged: (val) => setState(() => tags = val),
        choiceItems: C2Choice.listFrom<String, String>(
          source: options,
          value: (i, v) => v,
          label: (i, v) => v,
        ),
      ),
    );
  }
}