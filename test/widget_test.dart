import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fortnite_app/features/shell/presentation/pages/loading_screen.dart';

void main() {
  testWidgets('la app muestra la pantalla de carga', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoadingScreen()));

    expect(find.text('FORTNITE'), findsOneWidget);
    expect(find.text('BATTLE ROYALE'), findsOneWidget);
  });
}
