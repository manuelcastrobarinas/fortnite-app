import 'package:flutter/material.dart';
import '../../models/shop/shop_limited.dart';

//Esta funcion remplaza el formato de color que trae la Api de la tienda al formato de dart
Color replaceShopColorWithDartFormat(Shop shopElement) {
  return (shopElement.colors?.color1 != null)
    ?  Color(int.parse(shopElement.colors!.color1!.replaceFirst('#', '0xFF')))
  : (shopElement.colors?.color2 != null) 
    ? Color(int.parse(shopElement.colors!.color2!.replaceFirst('#', '0xFF'))) 
  : (shopElement.colors?.color3 != null)
    ? Color(int.parse(shopElement.colors!.color3!.replaceFirst('#', '0xFF'))) 
  : Colors.black;
}


