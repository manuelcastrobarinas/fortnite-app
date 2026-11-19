import 'package:flutter/material.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';

/// Tema de la aplicación. `FortniteApp` es el único lugar que lo aplica.
abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
      useMaterial3: false,
      primaryColor: kPrimaryColor,
      fontFamily: kPrimaryFont,
    );
  }
}
