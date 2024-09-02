 import 'package:flutter/material.dart';
import 'package:fortnite_app/models/items/items.dart';

final Map<Rarity, Color> _backgroundColorRarityList = {
  Rarity.COMMON : Colors.grey[350]!,
  Rarity.UNCOMMON : const Color.fromARGB(168, 102, 187, 106),
  Rarity.RARE : const Color.fromARGB(70, 66, 164, 245),
  Rarity.EPIC   : Colors.purple[400]!,
  Rarity.LEGENDARY: Colors.orange,
  Rarity.EXOTIC: Colors.cyanAccent,
  Rarity.TRANSCENDENT : Colors.red,
  Rarity.UNATTAINABLE : Colors.teal,
  Rarity.MYTHIC : const Color.fromARGB(255, 203, 173, 0)
};


Color setBackgroundItemColor(Rarity rarity) {
  Color setColor = _backgroundColorRarityList[rarity]!;
  return setColor;
}

final Map<Rarity, String> _rarityName = {
  Rarity.COMMON       : 'Común',
  Rarity.UNCOMMON     : 'Poco Común',
  Rarity.RARE         : 'Raro',
  Rarity.EPIC         : 'Epico',
  Rarity.LEGENDARY    : 'Legendario',
  Rarity.EXOTIC       : 'Exotico',
  Rarity.TRANSCENDENT : 'Trascendente',
  Rarity.UNATTAINABLE : 'Incapturable',
  Rarity.MYTHIC       : 'Mitico'
};

String setRarityItemName(Rarity rarity) {
  String setRarity = _rarityName[rarity]!;
  return setRarity;
}