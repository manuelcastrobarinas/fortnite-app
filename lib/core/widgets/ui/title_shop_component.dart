import 'package:flutter/material.dart';

class SectionTitleShopComponent extends StatelessWidget {
  final String titleSection;
  final int elementsNumber;

  const SectionTitleShopComponent({
    super.key, 
    required this.titleSection,
    required this.elementsNumber
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 8,
          child: Text(titleSection, style: style, maxLines: 2)
        ),
        Expanded(
          flex: 1,
          child: Text(elementsNumber.toString(), style: style, maxLines: 2)
        ),
      ],
    );
  }
}