import 'package:flutter/material.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';

/// Tema de la aplicación. `FortniteApp` es el único lugar que lo aplica.
abstract class AppTheme {
  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: kChannelWeapons,
      onPrimary: Colors.white,
      secondary: kLive,
      onSecondary: Colors.white,
      error: kLive,
      onError: Colors.white,
      surface: kGround,
      onSurface: kInk,
    );
    const label = TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600);
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      scaffoldBackgroundColor: kGround,
      primaryColor: kChannelWeapons,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kChannelWeapons,
        selectionColor: Color(0x330B3D91),
        selectionHandleColor: kChannelWeapons,
      ),
      scrollbarTheme: const ScrollbarThemeData(
        thumbColor: const WidgetStatePropertyAll(Color(0xFF8A93A3)),
        thickness: const WidgetStatePropertyAll(8),
        radius: const Radius.circular(8),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        backgroundColor: kChannelWeapons,
        indicatorColor: kGround,
        labelTextStyle: const WidgetStatePropertyAll(label),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: kInk, size: 24);
          }
          return const IconThemeData(color: Colors.white, size: 24);
        }),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: kChannelWeapons),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: kChannelWeapons,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontFamily: kPrimaryFont, fontSize: 18),
        ),
      ),
    );
  }
}
