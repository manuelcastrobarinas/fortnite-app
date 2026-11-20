import 'package:flutter/material.dart';

import 'package:fortnite_app/app/theme/app_colors.dart';

class ChoiceChipSelectComponent extends StatelessWidget {

  final int defaultChoiseIndex;
  final List<String> choisesList;
  final void Function(int) onSelected;
  final Color selectedColor;

  const ChoiceChipSelectComponent({
    super.key, 
    required this.choisesList,
    required this.defaultChoiseIndex,
    required this.onSelected,
    this.selectedColor = kChannelShop,
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
                    labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                    showCheckmark: false,
                    label: Text(
                      choisesList[index],
                      style: TextStyle(
                        color: defaultChoiseIndex == index ? Colors.white : kInk,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    selected: defaultChoiseIndex == index,
                    selectedColor: selectedColor,
                    backgroundColor: kQuiet,
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
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