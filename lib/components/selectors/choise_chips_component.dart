import 'package:flutter/material.dart';
import '../../contants.dart';

class ChoiceChipComponent extends StatefulWidget {
  
  final List<String> choisesList; //LISTA DE ELEMENTOS PARA CADA UNO DE LOS CHOISE

  const ChoiceChipComponent({
    super.key,
    required this.choisesList
  });

  @override
  State<ChoiceChipComponent> createState() => _ChoiceChipComponentState();
}

class _ChoiceChipComponentState extends State<ChoiceChipComponent> {

  int defaultChoiseIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Wrap(
            spacing: 10.0,
            children: List.generate(widget.choisesList.length, (index) {
                return ChoiceChip(
                  labelPadding: const EdgeInsets.all(2.0),
                  label: Text(widget.choisesList[index], style: const TextStyle(color: Colors.white)), 
                  selected: defaultChoiseIndex == index,
                  selectedColor: kPrimaryColor,
                  disabledColor: kPrimaryColorVariant,
                  backgroundColor: kPrimaryColorVariant,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  onSelected: (value) {
                    setState(() {
                      defaultChoiseIndex = value ? index : defaultChoiseIndex;
                    });
                  },
                );
              } 
            ),
          ),
        )
      ),
    );
  }
}